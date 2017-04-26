# -*- coding: utf-8 -*-
"""
Created on Tue Apr 25 02:47:35 2017

@author: caesarliu
"""

# Convolutional Nerual Network


from keras.models import Sequential
from keras.layers import Conv2D
from keras.layers import MaxPooling2D
from keras.layers import Flatten
from keras.layers import Dense




# Initialize the Cnn

CNN=Sequential()

# build_up the the CNN

CNN.add(Conv2D(32,(3,3),input_shape=(64,64,3),data_format='channels_last',activation='relu'))

CNN.add(MaxPooling2D(pool_size=(2,2)))

CNN.add(Conv2D(64,(3,3),activation='relu'))
CNN.add(MaxPooling2D(pool_size=(2,2)))

CNN.add(Flatten())



CNN.add(Dense(units=64, activation='relu'))


CNN.add(Dense(units=1, activation='sigmoid'))

CNN.compile(optimizer='adam',loss='binary_crossentropy', metrics=['accuracy'])


# Processing image data and fit CNN
from keras.preprocessing.image import ImageDataGenerator

train_datagen = ImageDataGenerator(
        rescale=1./255,
        shear_range=0.2,
        zoom_range=0.2,
        horizontal_flip=True)

test_datagen = ImageDataGenerator(rescale=1./255)

train_set = train_datagen.flow_from_directory(
        'dataset/training_set',
        target_size=(64, 64),
        batch_size=32,
        class_mode='binary')

test_set = test_datagen.flow_from_directory(
        'dataset/test_set',
        target_size=(64, 64),
        batch_size=32,
        class_mode='binary')

CNN.fit_generator(
        train_set,
        steps_per_epoch=8000,
        epochs=12,
        validation_data=test_set,
        validation_steps=2000)



















































