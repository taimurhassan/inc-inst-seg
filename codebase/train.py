# Note: This code is a modified version of a original train.py from Divam Gupta's GitHub repository. The modifications are done by us as per our application. Many thanks to her and her team for the original code.
import argparse
import json
from .data_utils.data_loader import image_segmentation_generator, \
    verify_segmentation_dataset
import os
import glob
import six
import matplotlib.pyplot as plt
from keras import optimizers
import keras.backend as K
import tensorflow as tf
import keras 
import numpy as np

def incrementalLearningLoss(yTrue,yPred, iteration, oldClasses, newClasses):
    if iteration == 1:
        return K.categorical_crossentropy(yTrue,yPred,from_logits=True)
    else:
        a1 = 0.2
        a2 = 0.3
        a3 = 0.5
        
        yOldP = yPred[:,:,:oldClasses]
        yOldT = yTrue[:,:,:oldClasses]
        yNewP = yPred[:,:, newClasses:]
        yNewT = yTrue[:,:, newClasses:]
        
        yop = yOldP
        yot = yOldT
        ynp = yNewP
        ynt = yNewT
        
        # Mutual Information Loss Function (L_{mi})
        n1 = float(yOldP.get_shape().as_list()[1])
        n2 = float(yNewP.get_shape().as_list()[1])
            
        pOld = n1/(n1+n2)
        pNew = n2/(n1+n2)
            
        yOldP = (yOldP * yNewP) / yNewP
        m1 = K.mean(yOldP)
        s1 = K.std(yOldP)
        like1 = (1./(np.sqrt(2.*3.1415)*s1))*K.exp(-0.5*((yOldP-m1)**2./(s1**2.)))
            
        yOldNewP = like1 * pOld 
        
        yNewP = (yOldP * yNewP) / yOldP 
        m2 = K.mean(yNewP)
        s2 = K.std(yNewP)       
        like2 = (1./(np.sqrt(2.*3.1415)*s2))*K.exp(-0.5*((yNewP-m2)**2./(s2**2.)))
        
        yNewP = like2 * pNew
        
        yP = tf.concat([yOldP,yNewP],0)
        
        #print(tf.size(yP))
        #print(yP)
        loss = a1 * K.mean(K.categorical_crossentropy(yot,yop)) +  a2 * K.mean(keras.losses.kullback_leibler_divergence(ynt,ynp)) +  a3 * K.mean(K.categorical_crossentropy(yOldT,yOldNewP))
        #print(loss)
        return loss
def find_latest_checkpoint(checkpoints_path, fail_safe=True):

    def get_epoch_number_from_path(path):
        return path.replace(checkpoints_path, "").strip(".")

    # Get all matching files
    all_checkpoint_files = glob.glob(checkpoints_path + ".*")
    # Filter out entries where the epoc_number part is pure number
    all_checkpoint_files = list(filter(lambda f: get_epoch_number_from_path(f).isdigit(), all_checkpoint_files))
    if not len(all_checkpoint_files):
        # The glob list is empty, don't have a checkpoints_path
        if not fail_safe:
            raise ValueError("Checkpoint path {0} invalid".format(checkpoints_path))
        else:
            return None

    # Find the checkpoint file with the maximum epoch
    latest_epoch_checkpoint = max(all_checkpoint_files, key=lambda f: int(get_epoch_number_from_path(f)))
    return latest_epoch_checkpoint


def train(model,
          train_images,
          train_annotations,
          input_height=None,
          input_width=None,
          n_classes=None,
          verify_dataset=True,
          checkpoints_path=None,
          epochs=10,
          batch_size=2,
          validate=False,
          val_images=None,
          val_annotations=None,
          val_batch_size=2,
          auto_resume_checkpoint=False,
          load_weights=None,
          steps_per_epoch=512,
          optimizer_name='adadelta' , 
		  do_augment=False, 
		  classifier=None,
          oldClasses = 0,
          newClasses = 0,
          iteration = 0
          ):
    
    from .models.all_models import model_from_name
    # check if user gives model name instead of the model object
    if isinstance(model, six.string_types):
        # create the model from the name
        assert (n_classes is not None), "Please provide the n_classes"
        if (input_height is not None) and (input_width is not None):
            model = model_from_name[model](
                n_classes, input_height=input_height, input_width=input_width)
        else:
            model = model_from_name[model](n_classes)

    n_classes = model.n_classes
    input_height = model.input_height
    input_width = model.input_width
    output_height = model.output_height
    output_width = model.output_width

    if validate:
        assert val_images is not None
        assert val_annotations is not None
    if optimizer_name is not None:
        model.compile(loss=lambda yTrue, yPred: incrementalLearningLoss(yTrue, yPred, iteration, oldClasses, newClasses),
            optimizer=optimizer_name,metrics=['accuracy'])
            
    if checkpoints_path is not None:
        with open(checkpoints_path+"_config.json", "w") as f:
            json.dump({
                "model_class": model.model_name,
                "n_classes": n_classes,
                "input_height": input_height,
                "input_width": input_width,
                "output_height": output_height,
                "output_width": output_width
            }, f)

    if load_weights is not None and len(load_weights) > 0:
        print("Loading weights from ", load_weights)
        model.load_weights(load_weights)

    if auto_resume_checkpoint and (checkpoints_path is not None):
        latest_checkpoint = find_latest_checkpoint(checkpoints_path)
        if latest_checkpoint is not None:
            print("Loading the weights from latest checkpoint ",
                  latest_checkpoint)
            model.load_weights(latest_checkpoint)

    if verify_dataset:
        print("Verifying training dataset")
        verified = verify_segmentation_dataset(train_images, train_annotations, n_classes)
        assert verified
        if validate:
            print("Verifying validation dataset")
            verified = verify_segmentation_dataset(val_images, val_annotations, n_classes)
            assert verified

    train_gen = image_segmentation_generator(
        train_images, train_annotations,  batch_size,  n_classes,
        input_height, input_width, output_height, output_width , do_augment=do_augment )

    if validate:
        val_gen = image_segmentation_generator(
            val_images, val_annotations,  val_batch_size,
            n_classes, input_height, input_width, output_height, output_width)

    if not validate:
        for ep in range(epochs):
            print("Starting Epoch ", ep)
            history = model.fit_generator(train_gen, steps_per_epoch, epochs=1)
            if checkpoints_path is not None:
                model.save_weights(checkpoints_path + "." + str(ep))
                print("saved ", checkpoints_path + ".model." + str(ep))		  
            
    else:
        for ep in range(epochs):
            print("Starting Epoch ", ep)
            history = model.fit_generator(train_gen, steps_per_epoch,
                                validation_data=val_gen,
                                validation_steps=200,  epochs=1)
           
            if checkpoints_path is not None:
                model.save_weights(checkpoints_path + "." + str(ep))
                print("saved ", checkpoints_path + ".model." + str(ep))
            print("Finished Epoch", ep)       