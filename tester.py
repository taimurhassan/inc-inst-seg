from types import MethodType
import os
from keras.models import load_model
from codebase.models.mvrf import *
from config import *

import tensorflow as tf
config = tf.compat.v1.ConfigProto(gpu_options = 
                         tf.compat.v1.GPUOptions(per_process_gpu_memory_fraction=0.8)
# device_count = {'GPU': 1}
)
config.gpu_options.allow_growth = True
session = tf.compat.v1.Session(config=config)
tf.compat.v1.keras.backend.set_session(session)

def transferWeights(model1, model2):    
    for i in range(1,len(model1.layers)):
        model2.layers[i].set_weights(model1.layers[i].get_weights())
    
    return model2

def extractResults(model, rPath):
    folder = folderPath
    for filename in os.listdir(folder):
        print(rPath)
        print(filename)
        out = model.predict_segmentation(inp=os.path.join(folder,filename),
        out_fname=os.path.join(rPath,filename))
        print(model.evaluate_segmentation( inp_images_dir="testingDataset/test_images/resized/", annotations_dir="testingDataset/test_annotations/resized/" ) )

def loadModels(numIterations):
    prevClasses = 0
    for i in range(numIterations):
        print("Iteration: " + str(i + 1))
        print("Loading Model " + str(i + 1))
        model = load_model("model" + str(i) + ".h5", compile=False)
        
        addActivation = True
        
#        if i == 0: 
#            addActivation = False
        newModel = mvrf(n_classes = prevClasses + newClasses[i], height = imgHeight, width = imgWidth, addActivation = addActivation)                
        model = transferWeights(model, newModel) # TODO: Need to refactor this. The models are built on custom losses which could not be serialized directly
        print("Model " + str(i + 1) + " Loaded")
        print("Generating Results....")
        extractResults(model, resultsPath + str(i + 1) + "/")
        print("Results are generated at the following path: ", resultsPath + str(i + 1) + "/")
        prevClasses = prevClasses + newClasses[i]

loadModels(K)