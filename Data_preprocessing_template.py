# -*- coding: utf-8 -*-
"""
Created on Sat Apr 22 03:25:23 2017

@author: caesarliu
"""

# Datapreprocessing template

import numpy as np
import pandas as pd
import matplotlib.pylab as plt

# Importing data
dataset=pd.read_csv('Data.csv')
X=dataset.iloc[:,:-1].values
Y=dataset.iloc[:,-1].values

# Imputation for missing data
from sklearn.preprocessing import Imputer
imputer=Imputer(missing_values='NaN', strategy='mean')
imputer=imputer.fit(X[:,[1,2]])
X[:,[1,2]]=imputer.transform(X[:,[1,2]])

# Encoding categortical variable
from sklearn.preprocessing import LabelEncoder, OneHotEncoder
labelencoder_X=LabelEncoder()
X[:,0]=labelencoder_X.fit_transform(X[:,0])

one_hot_encoder=OneHotEncoder(categorical_features=[0])
X=one_hot_encoder.fit_transform(X).toarray()

labelencoder_Y=LabelEncoder()
Y=labelencoder_Y.fit_transform(Y)

# Training and validation split
from sklearn.model_selection import train_test_split
X_train, X_test, Y_train, Y_test=train_test_split(X,Y,test_size=0.2, random_state=0)


# Feature scaling
from sklearn.preprocessing import StandardScaler
sc_X= StandardScaler()
X_train=sc_X.fit_transform(X_train)
X_test=sc_X.transform(X_test)


