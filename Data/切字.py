#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np
import pandas as pd
import os
from ckiptagger import data_utils, construct_dictionary, WS, POS, NER
ws = WS("./data")
import re


# In[2]:


def ckiptoken(pandas):  
    def delete_punctuation(text):
        text = re.sub(r'[^0-9A-Za-z\u4E00-\u9FFF]+', '', text)  
        return text
    sentence_list=pandas.iloc[:,0]
    for i in range(0,len(sentence_list)):
        sentence_list[i]=delete_punctuation(sentence_list[i])
    word_sentence_list = ws(sentence_list)
    content_tokenized=[]
    for i in word_sentence_list:
        content_tokenized.append(' '.join(i))
    content_tokenized=pd.DataFrame(content_tokenized)
    content_tokenized.columns=["content_tokenized"] 
    return content_tokenized


# In[ ]:




