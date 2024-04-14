from flask import Flask
from flask import request
from flask import Response
from flask_cors import CORS
from flask import jsonify
from datetime import datetime
from sklearn.preprocessing import LabelEncoder
import numpy as np
import tensorflow as tf
import random
import json
import time
import os

import activity
import pred

app = Flask(__name__)
CORS(app)

@app.route('/predict')
def predict():
    
    try:
      #generate random number to pass into the model and select a row of test data
        random_number = random.randint(1, 1000)
        #calls the predication class with int value
        predJson = pred.prediction(random_number)
        response = Response(response=predJson, status=200)
        return response
    except Exception as e:
        error_message = {'error': str(e)}
        response = Response(response=json.dumps(error_message), status=500)
        return response

@app.get("/activities")
def getActivityInformation():
    
    try:
      #requests the dataframe in json format
      act = activity.pandasActivityInfo()

      #create an object to return in expected format
      r = {
      "error":False,
      "errorMsg" : "",
      "activities": act,
      }

      #convert object to JSON
      reply = json.dumps(r)
      response = Response(response=reply, status=200)
      return response
    
    except Exception as e:
        error_message = {'error': str(e)}
        response = Response(response=json.dumps(error_message), status=500)
        return response


@app.get("/activities/mean")
def getActivityMeanInformation():

    try:
        data = activity.describeModelInfo()

        r = {
        "error":False,
        "errorMsg" : "",
        "Mean": data,
        }

        reply = json.dumps(r)
        response = Response(response=reply, status=200)
        return response

    except Exception as e:
          error_message = {'error': str(e)}
          response = Response(response=json.dumps(error_message), status=500)
          return response

@app.get("/activities/chart/bar")
def getBarChartActivityInfo():

  try:
    actJson = activity.pandasActivityInfoJson()
    response = Response(response=actJson, status=200)
    return response
  
  except Exception as e:
          error_message = {'error': str(e)}
          response = Response(response=json.dumps(error_message), status=500)
          return response


@app.get("/activities/chart/line/acceleration")
def getAccelerationLineChartInfo():
    try:
      #requests data for each class feature so it can be each be displayed on the line graph
        walkingActJson = activity.chartInfo('WALKING','tBodyAccMag-mean()')
        downstairsActJson = activity.chartInfo('WALKING_DOWNSTAIRS', 'tBodyAccMag-mean()')
        standingActJson = activity.chartInfo('STANDING', 'tBodyAccMag-mean()')
        layingActJson = activity.chartInfo('LAYING', 'tBodyAccMag-mean()')
        upstairsActJson = activity.chartInfo('WALKING_UPSTAIRS', 'tBodyAccMag-mean()')
        sittingActJson = activity.chartInfo('SITTING', 'tBodyAccMag-mean()')

        r = {
          "walking_data": walkingActJson,
          "downstairs_data": downstairsActJson,
          "standing_data": standingActJson,
          "laying_data": layingActJson,
          "upstairs_data": upstairsActJson,
          "sitting_data": sittingActJson
        }

        reply = json.dumps(r)

        response = Response(response=reply, status=200)
        return response
    except Exception as e:
        error_message = {'error': str(e)}
        response = Response(response=json.dumps(error_message), status=500)
        return response


@app.get("/activities/chart/line/energy")
def getEnergyLineChartInfo():

    try:
      walkingActJson = activity.chartInfo('WALKING','tBodyAcc-energy()-X')
      downstairsActJson = activity.chartInfo('WALKING_DOWNSTAIRS', 'tBodyAcc-energy()-X')
      standingActJson = activity.chartInfo('STANDING', 'tBodyAcc-energy()-X')
      layingActJson = activity.chartInfo('LAYING', 'tBodyAcc-energy()-X')
      upstairsActJson = activity.chartInfo('WALKING_UPSTAIRS', 'tBodyAcc-energy()-X')
      sittingActJson = activity.chartInfo('SITTING', 'tBodyAcc-energy()-X')

      r = {
        "walking_data": walkingActJson,
        "downstairs_data": downstairsActJson,
        "standing_data": standingActJson,
        "laying_data": layingActJson,
        "upstairs_data": upstairsActJson,
        "sitting_data": sittingActJson
      }

      reply = json.dumps(r)

      response = Response(response=reply, status=200)
      return response
    except Exception as e:
          error_message = {'error': str(e)}
          response = Response(response=json.dumps(error_message), status=500)
          return response


@app.get("/activities/chart/line/std")
def getStandardDevLineChartInfo():
  try:
    walkingActJson = activity.chartInfo('WALKING','tBodyAcc-std()-X')
    downstairsActJson = activity.chartInfo('WALKING_DOWNSTAIRS', 'tBodyAcc-std()-X')
    standingActJson = activity.chartInfo('STANDING', 'tBodyAcc-std()-X')
    layingActJson = activity.chartInfo('LAYING', 'tBodyAcc-std()-X')
    upstairsActJson = activity.chartInfo('WALKING_UPSTAIRS', 'tBodyAcc-std()-X')
    sittingActJson = activity.chartInfo('SITTING', 'tBodyAcc-std()-X')

    r = {
      "walking_data": walkingActJson,
      "downstairs_data": downstairsActJson,
      "standing_data": standingActJson,
      "laying_data": layingActJson,
      "upstairs_data": upstairsActJson,
      "sitting_data": sittingActJson
    }

    reply = json.dumps(r)

    response = Response(response=reply, status=200)
    return response
  
  except Exception as e:
          error_message = {'error': str(e)}
          response = Response(response=json.dumps(error_message), status=500)
          return response

@app.get("/activities/chart/line/angle")
def getAngleLineChartInfo():
  try:

    walkingActJson = activity.chartInfo('WALKING','angle(tBodyAccMean,gravity)')
    downstairsActJson = activity.chartInfo('WALKING_DOWNSTAIRS', 'angle(tBodyAccMean,gravity)')
    standingActJson = activity.chartInfo('STANDING', 'angle(tBodyAccMean,gravity)')
    layingActJson = activity.chartInfo('LAYING', 'angle(tBodyAccMean,gravity)')
    upstairsActJson = activity.chartInfo('WALKING_UPSTAIRS', 'angle(tBodyAccMean,gravity)')
    sittingActJson = activity.chartInfo('SITTING', 'angle(tBodyAccMean,gravity)')

    r = {
      "walking_data": walkingActJson,
      "downstairs_data": downstairsActJson,
      "standing_data": standingActJson,
      "laying_data": layingActJson,
      "upstairs_data": upstairsActJson,
      "sitting_data": sittingActJson
    }

    reply = json.dumps(r)

    response = Response(response=reply, status=200)
    return response

  
  except Exception as e:
          error_message = {'error': str(e)}
          response = Response(response=json.dumps(error_message), status=500)
          return response




if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
