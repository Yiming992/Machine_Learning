# -*- coding: utf-8 -*-
"""
Created on Sat Apr 22 03:24:26 2017

@author: caesarliu
"""

# Logistic regression
import numpy as np
import pandas as pd
import matplotlib.pylab as plt

# Importing data
dataset=pd.read_csv('Social_Network_Ads.csv')

X=dataset.iloc[:,1:-1].values
Y=dataset.iloc[:,-1].values


from sklearn.preprocessing import LabelEncoder, OneHotEncoder
labelencoder_X=LabelEncoder()
X[:,0]=labelencoder_X.fit_transform(X[:,0])


# Training and validation split
from sklearn.model_selection import train_test_split
X_train, X_test, Y_train, Y_test=train_test_split(X,Y,test_size=0.2, random_state=0)


# Feature scaling
from sklearn.preprocessing import StandardScaler
sc_X= StandardScaler()
X_train[:,1:]=sc_X.fit_transform(X_train[:,1:])
X_test[:,1:]=sc_X.transform(X_test[:,1:])


# Logistic regression

from sklearn.linear_model import LogisticRegression
classifier=LogisticRegression(random_state=0)
classifier.fit(X_train,Y_train)


classifier2=LogisticRegression(random_state=1)
classifier2.fit(X_train[:,[1,2]],Y_train)

# Predicting the Test set rersults

y_pred=classifier.predict(X_test)
y_pred_2=classifier2.predict(X_test[:,[1,2]])

# Making the Confusion Matrix
from sklearn.metrics import confusion_matrix
cm=confusion_matrix(Y_test,y_pred)
cm2=confusion_matrix(Y_test,y_pred_2)

# Visualising the Training set results

from matplotlib.colors import ListedColormap

X_set, Y_set= X_train[:,[1,2]], Y_train
Xm,Ym=np.meshgrid(np.arange(start=X_set[:,0].min()-1,stop=X_set[:,0].max()+1,step=0.01),
            np.arange(start=X_set[:,1].min()-1,stop=X_set[:,1].max()+1,step=0.01))
plt.contourf(Xm,Ym,classifier2.predict(np.array([Xm.ravel(),Ym.ravel()]).T).reshape(Xm.shape),
             alpha=0.55,cmap=ListedColormap(('red','blue')))
plt.xlim(Xm.min(),Xm.max())
plt.ylim(Ym.min(),Ym.max())

for i, j in enumerate(np.unique(Y_set)):
    plt.scatter(X_set[Y_set==j,0],X_set[Y_set==j,1],
                c=ListedColormap(('red','blue'))(i),label=j)
plt.title('Visualization of Logistic regression')
plt.legend()
plt.show()
    







X_set[Y_set==0,0]



























