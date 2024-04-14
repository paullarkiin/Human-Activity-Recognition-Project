
    # classes = ['WALKING', 'WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS', 'SITTING', 'STANDING', 'LAYING'] # Define the class names
    # le = LabelEncoder()
    # le.fit(classes)
    # le.inverse_transform([0,1,2,3,4,5])


    # data = request.json # Get the data from the request
    # print(data)
    # array = np.array(data) # Convert the data to a numpy array

    # prediction = model.predict(array)
    #  # Make predictions
    # # class_indices = np.argmax(predictions, axis=1)
    # pred_class = le.inverse_transform([prediction.argmax()]).tolist()# Get the class indices
    # # class_probabilities = np.max(predictions, axis=1).tolist() # Get the probability scores
    # # class_predictions = [classes[i] for i in class_indices] # Get the class predictions
    # # 'probabilities': class_probabilities
    # return jsonify({'predictions': pred_class})
    # # return jsonify({'predictions': class_predictions})



    # # Receive the JSON data from the client
    # data = request.get_json()
    # # Preprocess the data as necessary
    # # ...
    # # Convert the data to a numpy array
    # input_data = np.array(data)
    # # Make a prediction with the Keras model
    # prediction = model.predict(input_data)
    # # Convert the prediction to a class string
    # class_prediction = str(np.argmax(prediction))
    # # Return the class prediction to the client as JSON
    # return jsonify({'prediction': class_prediction})


    ######test if maxscaler works with post request version!