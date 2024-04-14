from flask import Flask, request, jsonify
import numpy as np
from sklearn.preprocessing import LabelEncoder
from sklearn.preprocessing import MinMaxScaler
from keras.models import load_model
import numpy as np
import json
import tensorflow as tf
import pandas as pd

train_data = pd.read_csv('train.csv')
test_data = pd.read_csv('test.csv')

# Load the saved Keras model into memory
model = load_model('model.h5')

# Define the endpoint for receiving data and returning predictions
def prediction(number):

    x_train, y_train = train_data.iloc[:, :-2], train_data.iloc[:, -1:]
    x_test, y_test = test_data.iloc[:, :-2], test_data.iloc[:, -1:]

    le = LabelEncoder()
    y_train = le.fit_transform(y_train)
    y_test = le.fit_transform(y_test)

    le.inverse_transform([0,1,2,3,4,5])

    scaling_data = MinMaxScaler()
    x_train = scaling_data.fit_transform(x_train)
    x_test = scaling_data.transform(x_test)
    
    pred = model.predict(x_test)[number] # this can be a random number to generate new data every time.

    class_index = str(pred.argmax())
    class_pred = le.inverse_transform([pred.argmax()]).tolist()
    class_percent = pred.max()*100
    real_class = str(y_test[number])

    
    r = {
     "class_index": class_index,
     "prediction": class_pred,
     "probability": class_percent,
     "actual_class": real_class
    }

    return json.dumps(r)
