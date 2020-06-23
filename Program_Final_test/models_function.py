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
Intensity_Classifier = load_model('/Users/wangyuda/Desktop/文字探勘/Program_Final_test/models_function_box/Intensity_Classifier')
Small_Event_Classifier = load_model('/Users/wangyuda/Desktop/文字探勘/Program_Final_test/models_function_box/Small_Event_Classifier')
Big_Event_Classifier = load_model('/Users/wangyuda/Desktop/文字探勘/Program_Final_test/models_function_box/Big_Event_Classifier')
Month_abnormal_returns_Classifier = load_model('/Users/wangyuda/Desktop/文字探勘/Program_Final_test/models_function_box/Month_abnormal_returns_Classifier')

# load encoders
from joblib import dump, load

Intensity_enc = load('/Users/wangyuda/Desktop/文字探勘/Program_Final_test/models_function_box/Intensity_enc.joblib')

BE_enc = load('/Users/wangyuda/Desktop/文字探勘/Program_Final_test/models_function_box/BE_enc.joblib')

SE_enc = load('/Users/wangyuda/Desktop/文字探勘/Program_Final_test/models_function_box/SE_enc.joblib')

# load tokenizer

my_tokenizer = load('/Users/wangyuda/Desktop/文字探勘/Program_Final_test/models_function_box/my_tokenizer.joblib')


def preprocess_text(Tokenizer,corpus, MAX_SEQUENCE_LENGTH = 1000):
  '''
  put our fitted tokernizer into the "Tokernizer" of the function
  put our cutted text into the "corpus" of the function
  '''
  output = Tokenizer.texts_to_sequences(corpus)
  output = keras .preprocessing .sequence .pad_sequences(output, maxlen=MAX_SEQUENCE_LENGTH)
  return output

  # Ex: x = preprocess_text(Tokenizer = my_tokenizer,corpus = data_df.content_tokenized, MAX_SEQUENCE_LENGTH = 1305)

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

def predict_Month_abnormal_returns(x):
  pred_Month_abnormal_returns = Month_abnormal_returns_Classifier.predict(x)
  pred_Month_abnormal_returns =(pred_Month_abnormal_returns>0.5).astype(int)
  if pred_Month_abnormal_returns == 0:
    output = "下跌"
  else:
    output = "上漲"
  return output