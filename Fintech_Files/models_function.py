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
from joblib import dump, load

Intensity_enc = load('gdrive/My Drive/金融科技Final_project/Intensity_enc.joblib')

BE_enc = load('gdrive/My Drive/金融科技Final_project/BE_enc.joblib')

SE_enc = load('gdrive/My Drive/金融科技Final_project/SE_enc.joblib')

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
  return pred_Intensity

def predict_Big_Event(x):
  pred_Big_Event = Big_Event_Classifier.predict(x)
  pred_Big_Event =(pred_Big_Event>0.5).astype(int)

  # decode categorical dummy variables to categorical variables
  pred_Big_Event = BE_enc.inverse_transform(pred_Big_Event)
  return pred_Big_Event

def predict_Small_Event(x):
  pred_Small_Event = Small_Event_Classifier.predict(x)
  pred_Small_Event =(pred_Small_Event>0.5).astype(int)

  # decode categorical dummy variables to categorical variables
  pred_Small_Event = SE_enc.inverse_transform(pred_Small_Event)
  return pred_Small_Event

