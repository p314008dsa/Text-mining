# Import packages

import pandas as pd 
import numpy as np
import matplotlib
import matplotlib.pyplot as plt
import seaborn as sns


import gc #Garbage Collector interface
from datetime import datetime 
from sklearn.model_selection import train_test_split
from sklearn.model_selection import KFold
from catboost import CatBoostClassifier
import lightgbm as lgb
import xgboost as xgb

# Import datasets
data_df = pd.read_excel('/Users/Stylewsxcde991/Desktop/金融科技_文字探勘與機器學習/金融科技Final_project/whole_year.xlsx',index_col=0)

print("data_df - rows:",data_df.shape[0]," columns:", data_df.shape[1])

data_df.info()

# The proportion of each target class

data_df["事件強度"].value_counts()

import jieba.posseg as pseg

text = '我是李孟，在東京工作的數據科學家'
words = pseg.cut(text)
[word for word in words]


def jieba_tokenizer(text):
    words = pseg.cut(text)
    return ' '.join([
        word for word, flag in words if flag != 'x'])

data_df['content_tokenized'] = data_df.iloc[:10, 6].apply(jieba_tokenizer)

data_df['content_tokenized'] = data_df.loc[:, '事件內容'].apply(jieba_tokenizer)

data_df.to_csv('/Users/Stylewsxcde991/Desktop/金融科技_文字探勘與機器學習/金融科技Final_project/Encode_whole_year.xlsx',index_col=0)

#data_df['big_tokenized'] = data_df.loc[:, '大事件類別'].apply(jieba_tokenizer)
#data_df['small_tokenized'] = data_df.loc[:, '小事件類別'].apply(jieba_tokenizer)

import keras
MAX_NUM_WORDS = 10000
tokenizer = keras .preprocessing.text.Tokenizer(num_words=MAX_NUM_WORDS)

corpus = data_df.content_tokenized

tokenizer.fit_on_texts(corpus)

x_train = tokenizer.texts_to_sequences(corpus)

len(x_train)

x_train[:1]

for seq in x_train[:1]:
    print([tokenizer.index_word[idx] for idx in seq])
    
for seq in x_train[:20]:
    print(len(seq), seq[:5], ' ...')
    
max_seq_len = max([
    len(seq) for seq in x_train])
max_seq_len

MAX_SEQUENCE_LENGTH = 150
x_train = keras .preprocessing .sequence .pad_sequences(x_train, maxlen=MAX_SEQUENCE_LENGTH)

y_train = np.asarray(data_df["事件強度"])

y_train = np.asarray(pd.get_dummies(y_train))

data_df["事件強度"].value_counts()

# Use SMOTE
# import imblearn.over_sampling 

# Construct our model
from keras import models
from keras import layers

model = models.Sequential()
model.add(layers.Dense(100, activation='relu'))
model.add(layers.Dropout(0.5))
model.add(layers.Dense(100, activation='relu'))
model.add(layers.Dropout(0.5))
model.add(layers.Dense(100, activation='relu'))
model.add(layers.Dropout(0.5))
model.add(layers.Dense(100, activation='relu'))
model.add(layers.Dropout(0.5))
model.add(layers.Dense(100, activation='relu'))
model.add(layers.Dropout(0.5))
model.add(layers.Dense(100, activation='relu'))
model.add(layers.Dropout(0.5))
model.add(layers.Dense(100, activation='relu'))
model.add(layers.Dropout(0.5))
model.add(layers.Dense(100, activation='relu'))
model.add(layers.Dropout(0.5))
model.add(layers.Dense(100, activation='relu'))
model.add(layers.Dropout(0.5))
model.add(layers.Dense(100, activation='relu'))
model.add(layers.Dropout(0.5))
model.add(layers.Dense(6, activation='softmax'))

model.compile(optimizer='adam',
              loss='categorical_crossentropy',
              metrics=['accuracy'])


# Iterate on your training data by calling the fit() method of your model
history = model.fit(x_train,
                    y_train,
                    epochs=200,
                    batch_size=50,
                   validation_split=0.2)

# plot the results of loss values from the training set and validtion set
history_dict = history.history
loss_values = history_dict['loss']
val_loss_values = history_dict['val_loss']

epochs = range(1, len(history_dict['accuracy']) + 1)

plt.figure(figsize=(10,6))
plt.plot(epochs, loss_values, 'bo', label='Training loss')
plt.plot(epochs, val_loss_values, 'b', label='Validation loss')
plt.title('Training and validation loss')
plt.xlabel('Epochs')
plt.ylabel('Loss')
plt.legend()
plt.show()


# plot the results of accuracy from the training set and validtion set
acc = history_dict['accuracy']
val_acc = history_dict['val_accuracy']
plt.plot(epochs, acc, 'bo', label='Training acc')
plt.plot(epochs, val_acc, 'b', label='Validation acc')
plt.title('Training and validation accuracy')
plt.xlabel('Epochs')
plt.ylabel('Accuracy')
plt.legend()
plt.show()





