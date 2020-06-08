import pandas as pd 
import numpy as np
import sklearn
import keras
from keras import models
from keras import layers
from keras.layers import LSTM
from sklearn.preprocessing import OneHotEncoder

# load models
from keras.models import load_model
Intensity_Classifier = load_model('gdrive/My Drive/金融科技Final_project/Intensity_Classifier')
Small_Event_Classifier = load_model('gdrive/My Drive/金融科技Final_project/Small_Event_Classifier')
Big_Event_Classifier = load_model('gdrive/My Drive/金融科技Final_project/Big_Event_Classifier')

# load encoders
Intensity_enc = OneHotEncoder(sparse=False)
Intensity_enc.classes_ = [-3, -2, -1,  0,  1,  2,  3]

BE_enc = OneHotEncoder(sparse=False)
BE_enc.classes_ = ['A_會計/財報分析', 'F_市場交易', 'I_產業前景', 'M_經營層', 'R_危機']

SE_enc = OneHotEncoder(sparse=False)
SE_enc.classes_ = ['AF05_財務警示', 'AI01_延遲公告', 'FS02_股價暴跌或異常', 'FS03_其他市場交易議題',
        'IP01_成本/產能變動或資本支出', 'IS01_營收變動或客戶/商品/通路策略', 'MT02_董監異動',
        'MT06_高管異動', 'RB01_TCRI負向觀察', 'RB02_TCRI降等', '危機_其他', '市場交易_其他',
        '會計/財報分析_其他', '產業前景_其他', '經營層_其他']


def preprocess_text(corpus, MAX_NUM_WORDS = 10000, MAX_SEQUENCE_LENGTH = 1000):
  tokenizer = keras .preprocessing.text.Tokenizer(num_words=MAX_NUM_WORDS)
  tokenizer.fit_on_texts(corpus)
  output = tokenizer.texts_to_sequences(corpus)
  output = keras .preprocessing .sequence .pad_sequences(output, maxlen=MAX_SEQUENCE_LENGTH)
  return output

  # Ex: x = preprocess_text(corpus = data_df, MAX_NUM_WORDS = 10000, MAX_SEQUENCE_LENGTH = 1305)

def predict_intensity(x):
  pred_Intensity = Intensity_Classifier.predict(x)
  pred_Intensity =(pred_Intensity>0.5).astype(int)

  # decode categorical dummy variables to categorical variables
  pred_Intensity = Intensity_enc.inverse_transform(pred_Intensity)
  pred_Intensity = Intensity_enc.inverse_transform(pred_Intensity)
  return pred_Intensity

def predict_Big_Event(x):
  pred_Big_Event = Big_Event_Classifier.predict(x)
  pred_Big_Event =(pred_Big_Event>0.5).astype(int)

  # decode categorical dummy variables to categorical variables
  pred_Big_Event = BE_enc.inverse_transform(pred_Big_Event)
  pred_Big_Event = BE_enc.inverse_transform(pred_Big_Event)
  return pred_Big_Event

def predict_Small_Event(x):
  pred_Small_Event = Small_Event_Classifier.predict(x)
  pred_Small_Event =(pred_Small_Event>0.5).astype(int)

  # decode categorical dummy variables to categorical variables
  pred_Small_Event = SE_enc.inverse_transform(pred_Small_Event)
  pred_Small_Event = SE_enc.inverse_transform(pred_Small_Event)
  return pred_Small_Event

