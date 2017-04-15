# -*- coding: utf-8 -*-
"""
Created on Sat Apr 15 12:24:56 2017

@author: caesarliu
"""

import numpy as np


## Softmax on One-dimensional numpy array
a= np.random.randn(5)
expa=np.exp(a)
answer=expa/np.sum(expa)



## Softmax ON two-dimensional numpy array
b=np.random.randn(100,5)
expb=np.exp(b)
expb/expb.sum(axis=1,keepdims=True)


