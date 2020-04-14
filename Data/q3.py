#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import pandas as pd
original= pd.read_csv("//users//ryoakirakotowaza//Desktop//文字探勘（q3).csv", index_col=0)
original.head(3)
original.rename(columns={'事件內容':'incident'},inplace=True)
train = original[:5000]
train
test =original[5000:6243]
get_ipython().system('pip install jieba')
import jieba.posseg as pseg
def jieba_tokenizer(text):
    words = pseg.cut(text)
    return ''.join([word for word, flag in words if flag != 'x'])
cols = ['incident']
train = train.loc[:, cols]
train['title1_tokenized'] =  train.loc[:, 'incident'].apply(jieba_tokenizer)
train1.iloc[:, [0,1]].head()

