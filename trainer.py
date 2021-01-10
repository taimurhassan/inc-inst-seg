import cv2
import os
from keras.models import load_model
import matplotlib.pyplot as plt
from codebase.models.net import *
from config import *

import tensorflow as tf
config = tf.compat.v1.ConfigProto(gpu_options = 
                         tf.compat.v1.GPUOptions(per_process_gpu_memory_fraction=0.8)
# device_count = {'GPU': 1}
)
config.gpu_options.allow_growth = True
session = tf.compat.v1.Session(config=config)
tf.compat.v1.keras.backend.set_session(session)

def generateTrainingPaths(numIterations):
    trainingImagesPaths = []
    trainingGTPaths = []
    validationImagesPaths = []
    validationGTPaths = []
    
    for i in range(numIterations):
        trainingImagesPaths.append("trainingDataset/trainImages_"+ str(i + 1) + "/")
        trainingGTPaths.append("trainingDataset/trainGT_"+ str(i + 1) + "/")
        validationImagesPaths.append("trainingDataset/valImages_"+ str(i + 1) + "/")
        validationGTPaths.append("trainingDataset/valGT_"+ str(i + 1) + "/")

    return trainingImagesPaths, trainingGTPaths, validationImagesPaths, validationGTPaths

def evaluateModel(model, rPath):
    folder = folderPath
    for filename in os.listdir(folder):
        out = model.predict_segmentation(inp=os.path.join(folder,filename),
        out_fname=os.path.join(rPath,filename))
    
def generateModelInstance(model, prevClasses, newClasses, activationFlag = True):
    newModel = net(n_classes = prevClasses + newClasses, height=imgHeight, width= imgWidth, addActivation = activationFlag)
    #model.summary()
    #newModel.summary()
    
    for i in range(1,len(newModel.layers)-1):
        weights = newModel.layers[i].get_weights()
        old_weights = model.layers[i].get_weights() 
        weights[:][:][:][0:prevClasses-1] = old_weights
        newModel.layers[i].set_weights(weights)
    
    return newModel

def trainModelsIncrementally(numIterations):
    prevClasses = 0;
    doValidate = False
    
    trainingImagesPaths, trainingGTPaths, validationImagesPaths, validationGTPaths = generateTrainingPaths(numIterations)
    
    for i in range(numIterations):
        if i is 0: # semantic segmentation (no incremental training)
            model = net(n_classes=newClasses[i] , height = imgHeight, width = imgWidth)
            
            model.train(
            train_images =  trainingImagesPaths[i],
            train_annotations = trainingGTPaths[i],
            val_images =  validationImagesPaths[i],
            val_annotations = validationGTPaths[i],
            checkpoints_path = None , epochs=1, validate=doValidate, iteration = i + 1, oldClasses = prevClasses, newClasses = newClasses[i]
            )
            
            prevClasses = prevClasses + newClasses[i]
        else: # instance aware segmentation via incremental training 
            newModel = generateModelInstance(model, prevClasses, newClasses[i], True) 
                
            newModel.train(
            train_images =  trainingImagesPaths[i],
            train_annotations = trainingGTPaths[i],
            val_images =  validationImagesPaths[i],
            val_annotations = validationGTPaths[i],
            checkpoints_path = None , epochs=1, validate=doValidate, iteration = i + 1, oldClasses = prevClasses, newClasses = newClasses[i]
            )
            
            prevClasses = prevClasses + newClasses[i]
            model = newModel
            
        model.save("model" + str(i) + ".h5");
        model.summary()
        evaluateModel(model, resultsPath + str(i + 1) + "/")
        
trainModelsIncrementally(K)