# -*- coding: utf-8 -*-
"""


@author: caesarliu
"""

import numpy as np
import matplotlib.pyplot as plt


Nclass = 1000

## Generating input 

X1=np.random.randn(Nclass,2) + np.array([0,-2])
X2=np.random.randn(Nclass,2) + np.array([2,2])
X3=np.random.randn(Nclass,2) + np.array([-2,2])

X=np.vstack([X1,X2,X3])

## Generating Labels

Y=np.array([0]*Nclass+[1]*Nclass+[2]*Nclass)

## Input Layer Size
D=2

## Hidden Layer Size
M=3

## Number of Classes, i.e. output_layer size
K=3

##Initialize Weight
W1=np.random.randn(D,M)
b1=np.random.randn(M)
W2=np.random.randn(M,K)
b2=np.random.randn(K)


def forward(X,W1,b1,W2,b2):
    """
    Function to compute the softmax output for a
    simple one-hidden-layer feedforward neural network
    X: Input Layer
    W1: Input Layer to hidden layer weight 
    W2: Input weight of output  layer
    b1: Bias terms of hidden layer
    """
    Z =1/(1+ (-X.dot(W1)-b1))
    A= np.exp(Z.dot(W2)+b2)
    R=A/A.sum(axis=1,keepdims=True)
    return R
    
def classification_rate(labels,P):
    """
    labels: labels to test against
    P: Predictions produced by Neural Network
    
    """
    n_correct =0
    n_total=0
    for i in range(len(labels)):
        n_total+=1
        if labels[i]==P[i]:
            n_correct+=1
    return float(n_correct)/n_total

output=forward(X,W1,b1,W2,b2)
P=np.argmax(output,axis=1)
    
print('Classification correction rate is:', classification_rate(Y,P))
