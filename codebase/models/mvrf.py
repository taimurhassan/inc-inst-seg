# Re-implementation of MvRF-CNN. Paper ref is given below: 
#T. Akilan, Q. M. J. Wu, and W. Zhang, “Video foreground extraction using multi-view receptive field and encoder–decoder dcnn for traffic and surveillance applications,” IEEE Transactions on Vehicular Technology, vol. 68, no. 10, pp. 9478–9493, 2019

import numpy as np
import keras
from keras.models import *
from keras.models import Model
from keras.layers import *
import keras.backend as K
 
from keras import optimizers
from keras.preprocessing.image import ImageDataGenerator
from keras import layers
import tensorflow as tf

from .model_utils import get_segmentation_model, resize_image

def get_segmentor(classes, height=240, width=320, addActivation = True):

#    assert height % 192 == 0
#    assert width % 192 == 0

    inputLayer, o = mvrf_cnn(height=height,  width=width, classes = classes)
    	
    modelSegmentor = get_segmentation_model(inputLayer, o, addActivation)
    return modelSegmentor
    
def mvrf(n_classes,  height=240, width=320, addActivation = True):

    modelSegmentor = get_segmentor(n_classes, height=height, width=width, addActivation = addActivation)
    modelSegmentor.model_name = "segmentor"
	
    return modelSegmentor
    
def mvrf_cnn(height,  width, classes):
    from .config import IMAGE_ORDERING as order
    
#    assert height > 0 == 0
#    assert width > 0 == 0

    if order == 'channels_first':
        inputLayer = Input(shape=(3, height, width))
    elif order == 'channels_last':
        inputLayer = Input(shape=(height, width, 3))

    if order == 'channels_last':
        bn_axis = 3
    else:
        bn_axis = 1

    kernel_size = 3
    
    
    L1 = Conv2D(32, (3, 3), data_format=order, strides=(1, 1), padding='same')(inputLayer)
    L1 = Activation('relu')(L1)
    
    
    L2 = Conv2D(32, (5, 5), data_format=order, strides=(1, 1), padding='same')(inputLayer)
    L2 = Activation('relu')(L2)
    
    L3 = Conv2D(32, (9, 9), data_format=order, strides=(1, 1), padding='same')(inputLayer)
    L3 = Activation('relu')(L3)
    
    L4 = Conv2D(32, (3, 3), data_format=order, strides=(2, 2), padding='same')(L1)
    L4 = Activation('relu')(L4)
    
    L5 = Conv2D(32, (3, 3), data_format=order, strides=(2, 2), padding='same')(L4)
    L5 = Activation('relu')(L5)
    
    L6 = Conv2D(32, (5, 5), data_format=order, strides=(4, 4), padding='same')(L2)
    L6 = Activation('relu')(L6)
    
    L7 = layers.Concatenate(axis=bn_axis)([L5, L6])
    
    L8 = Conv2D(32, (3, 3), data_format=order, strides=(2, 2), padding='same')(L7)
    L8 = Activation('relu')(L8)
    
    L9 = Conv2D(32, (3, 3), data_format=order, strides=(2, 2), padding='same')(L6)
    L9 = Activation('relu')(L9)
    
    L11 = Conv2D(32, (9, 9), data_format=order, strides=(8, 8), padding='same')(L3)
    L11 = Activation('relu')(L11)
        
    L10 = layers.Concatenate(axis=bn_axis)([L8, L9])
    
    L10 = layers.Concatenate(axis=bn_axis)([L10, L11])
        
    L12 = Conv2D(32, (3, 3), data_format=order, strides=(2, 2), padding='same')(L10)
    L12 = Activation('relu')(L12)
    
    L13 = Conv2D(32, (5, 5), data_format=order, strides=(4, 4), padding='same')(L6)
    L13 = Activation('relu')(L13)
        
    L15 = Conv2D(32, (3, 3), data_format=order, strides=(2, 2), padding='same')(L11)
    L15 = Activation('relu')(L15)
    
    L14 = layers.Concatenate(axis=bn_axis)([L12, L13, L15])
        
    L17 = Conv2D(64, (3, 3), data_format=order, strides=(1, 1), padding='same')(L14)
    L17 = Activation('relu')(L17)

    L16 = Conv2D(32, (5, 5), data_format=order, strides=(1, 1), padding='same')(L17)
    L16 = Activation('relu')(L16)
        
        
    L18 = Conv2D(32, (3, 3), data_format=order, strides=(1, 1), padding='same')(L17)
    L18 = Activation('relu')(L18)

    L19 = Conv2DTranspose(32, (3, 3), data_format=order, strides=(2, 2), padding='same')(L17)
    L19 = Activation('relu')(L19)
    
    L20 = layers.Concatenate(axis=bn_axis)([L10, L19])    
    
    L21 = Dropout(.3)(L20)
    
    L22 = Conv2D(32, (3, 3), data_format=order, strides=(1, 1), padding='same')(L21)
    L22 = Activation('relu')(L22)
    
    L23 = Conv2DTranspose(32, (5, 5), data_format=order, strides=(4, 4), padding='same')(L16)
    L23 = Activation('relu')(L23)
    
    L24 = Conv2DTranspose(32, (3, 3), data_format=order, strides=(2, 2), padding='same')(L22)
    L24 = Activation('relu')(L24)

    L25 = Conv2DTranspose(32, (3, 3), data_format=order, strides=(2, 2), padding='same')(L18)
    L25 = Activation('relu')(L25)

    L26 = Conv2D(32, (5, 5), data_format=order, strides=(1, 1), padding='same')(L23)
    L26 = Activation('relu')(L26)
 
    L27 = layers.Concatenate(axis=bn_axis)([L7, L24])
    
    L27 = layers.Concatenate(axis=bn_axis)([L27, L26])    

    L28 = Conv2D(32, (9, 9), data_format=order, strides=(1, 1), padding='same')(L25)
    L28 = Activation('relu')(L28)

    L29 = Conv2DTranspose(32, (5, 5), data_format=order, strides=(4, 4), padding='same')(L26)
    L29 = Activation('relu')(L29)

    L30 = Dropout(.3)(L27)

    L31 = Conv2DTranspose(32, (9, 9), data_format=order, strides=(8, 8), padding='same')(L28)
    L31 = Activation('relu')(L31)
    print(L31.shape)
    
    L32 = Conv2D(32, (3, 3), data_format=order, strides=(1, 1), padding='same')(L30)
    L32 = Activation('relu')(L32)
    print(L32.shape)
    
    L33 = Conv2DTranspose(32, (3, 3), data_format=order, strides=(2, 2), padding='same')(L32)
    L33 = Activation('relu')(L33)

    L34 = Concatenate(axis=bn_axis)([L4, L33])
    
    L35 = Dropout(.3)(L34)

    L36 = Conv2D(32, (3, 3), data_format=order, strides=(1, 1), padding='same')(L35)
    L36 = Activation('relu')(L36)

    L37 = Conv2DTranspose(32, (3, 3), data_format=order, strides=(2, 2), padding='same')(L36)
    L37 = Activation('relu')(L37)

    L38 = Concatenate(axis=bn_axis)([L29, L31])

    L38 = Concatenate(axis=bn_axis)([L38, L37])
    
    L38 = BatchNormalization(axis=bn_axis)(L38)

    L39 = Dropout(.3)(L38)

    L40 = Conv2D(128, (3, 3), data_format=order, strides=(1, 1), padding='same')(L39)
    L40 = Activation('relu')(L40)

    L41 = Conv2D(classes, (3, 3), data_format=order, strides=(1, 1), padding='same')(L40)
    L41 = Activation('sigmoid')(L41)
    
    return inputLayer, L41