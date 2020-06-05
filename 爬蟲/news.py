#!/usr/bin/env python
# coding: utf-8

# In[1]:


import cutword
import pandas as pd
import time
import datetime


# In[2]:


def data():
    url = 'https://mops.twse.com.tw/mops/web/t05sr01_1'
    page=pd.read_html(url)[0][12:]
    page=pd.DataFrame(page)
    page=page.iloc[0:len(page)-1,:5]
    data=pd.DataFrame(page.iloc[1:,:].values)
    data.columns=page.iloc[0].values
    return data


# In[3]:


def news():
    url = 'https://mops.twse.com.tw/mops/web/t05sr01_1'
    page=pd.read_html(url)[0][12:]
    page=pd.DataFrame(page)
    page=page.iloc[0:len(page)-1,:5]
    data=pd.DataFrame(page.iloc[1:,4].values)
    a=[]
    a.append(page.iloc[0][4])
    data.columns=a
    news=cutword.ckiptoken(data)
    return news




