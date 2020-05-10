#!/usr/bin/env python
# coding: utf-8

# In[4]:


pip install -U ckiptagger[tf,gdown]


# In[5]:


from ckiptagger import data_utils, construct_dictionary, WS, POS, NER


# In[6]:


ws = WS("./data")
pos = POS("./data")
ner = NER("./data")


# In[11]:


sentence_listtest = [
    "傅達仁今將執行安樂死，卻突然爆出自己20年前遭緯來體育台封殺，他不懂自己哪裡得罪到電視台。",
    "美國參議院針對今天總統布什所提名的勞工部長趙小蘭展開認可聽證會，預料她將會很順利通過參議院支持，成為該國有史以來第一位的華裔女性內閣成員。",
    "",
    "土地公有政策?？還是土地婆有政策。.",
    "… 你確定嗎… 不要再騙了……",
    "最多容納59,000個人,或5.9萬人,再多就不行了.這是環評的結論.",
    "科長說:1,坪數對人數為1:3。2,可以再增加。",
]

word_sentence_listtest = ws(
    sentence_listtest,
    # sentence_segmentation = True, # To consider delimiters
    # segment_delimiter_set = {",", "。", ":", "?", "!", ";"}), # This is the defualt set of delimiters
    # recommend_dictionary = dictionary1, # words in this dictionary are encouraged
    # coerce_dictionary = dictionary2, # words in this dictionary are forced
)

#pos_sentence_listtest = pos(word_sentence_listtest)

#entity_sentence_listtest = ner(word_sentence_listtest, pos_sentence_listtest)


# In[38]:


word_sentence_listtest


# In[8]:


def print_word_pos_sentence(word_sentence, pos_sentence):
    assert len(word_sentence) == len(pos_sentence)
    for word, pos in zip(word_sentence, pos_sentence):
        print(f"{word}({pos})", end="\u3000")
    print()
    return
    
for i, sentence in enumerate(sentence_list):
    print()
    print(f"'{sentence}'")
    print_word_pos_sentence(word_sentence_list[i],  pos_sentence_list[i])
    for entity in sorted(entity_sentence_list[i]):
        print(entity)


# In[29]:


import pandas as pd
import numpy as np


# In[56]:


df = pd.read_excel("/Users/ryoakirakotowaza/Desktop/4.9文字探勘/2019年看門狗資訊事件整理( 全年).xlsx")


# In[57]:


df


# In[59]:


sentence_list=[]


# In[60]:


for i in df["事件內容"]:
  sentence_list.append(i)


# In[67]:


sentence_list


# In[65]:


word_sentence_list = ws(sentence_list,)




# In[68]:


word_sentence_list


# In[69]:


pos_sentence_list = pos(word_sentence_list)

entity_sentence_list = ner(word_sentence_list, pos_sentence_list)


# In[156]:


def print_word_pos_sentence(word_sentence, pos_sentence):
    assert len(word_sentence) == len(pos_sentence)
    for word, pos in zip(word_sentence, pos_sentence):
        if pos!="COMMACATEGORY" and pos!="PERIODCATEGORY" and pos!="Nd" and pos!="FW" and pos!="PARENTHESISCATEGORY" and pos!="QUESTIONCATEGORY" and pos!="SEMICOLONCATEGORY" and pos!="COLONCATEGORY" and pos!="PAUSECATEGORY" and pos!="ETCCATEGORY"and pos!="DOTCATEGORY"and pos!="DASHCATEGORY" :
          print(f"{word}", end="\u3000")
    print()
    return
    
for i, sentence in enumerate(sentence_list):
    print()
    print(f"'{sentence}'")
    print_word_pos_sentence(word_sentence_list[i],  pos_sentence_list[i])


# In[ ]:





# In[152]:





# In[ ]:





# In[ ]:




