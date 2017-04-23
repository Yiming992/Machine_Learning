# -*- coding: utf-8 -*-
"""
Created on Sat Apr 22 03:24:25 2017

@author: caesarliu
"""

##################### Data preprocessing
import numpy as np
import pandas as pd
import matplotlib.pylab as plt

# Importing data
dataset=pd.read_csv('Churn_Modelling.csv')
X=dataset.iloc[:,3:-1].values
Y=dataset.iloc[:,-1].values

# Encoding categorical variables
from sklearn.preprocessing import LabelEncoder, OneHotEncoder
label=LabelEncoder()
Onehot=OneHotEncoder(categorical_features=[1])

X[:,2]=label.fit_transform(X[:,2])
X[:,1]=label.fit_transform(X[:,1])

X=Onehot.fit_transform(X).toarray()

X=X[:,1:]

# Train and Validation split
from sklearn.model_selection import train_test_split
X_train,X_test,Y_train,Y_test= train_test_split(X,Y,test_size=0.2)


# Feature scaling
from sklearn.preprocessing import StandardScaler
scaler=StandardScaler()
X_train[:,[2,4,5,6,7,10]]=scaler.fit_transform(X_train[:,[2,4,5,6,7,10]])
X_test[:,[2,4,5,6,7,10]]=scaler.transform(X_test[:,[2,4,5,6,7,10]])



#################### Build ANN
import keras
from keras.models import Sequential
from keras.layers import Dense, Activation
# Initialize
classifier=Sequential()
#
classifier.add(Dense(units=6, kernel_initializer='glorot_uniform',input_dim=11))
classifier.add(Activation('relu'))

classifier.add(Dense(units=6, kernel_initializer='glorot_uniform'))
classifier.add(Activation('relu'))


classifier.add(Dense(units=1, kernel_initializer='glorot_uniform'))
classifier.add(Activation('sigmoid'))

# compile
classifier.compile(optimizer='adam',loss='binary_crossentropy', metrics=['accuracy'])

########################## 
classifier.fit(X_train,Y_train, batch_size=10, epochs=100)
###################### Predictions
Y_pred=classifier.predict(X_test)


































