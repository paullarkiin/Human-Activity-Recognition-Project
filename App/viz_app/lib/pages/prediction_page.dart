import 'dart:math';

import 'package:flutter/material.dart';
import 'package:viz_app/network/constants.dart';
import 'package:viz_app/network/values.dart';

import '../network/call_api.dart';

class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  State<PredictionPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  var probabilities;
  var predictions;
  var pred_class;
  var actual_class;

  List dataValueArray = [data, dataTwo, dataThree];

// post data funcationally works but is limited to three movements.
// to make the app present a more accurate represention get movement is used.

  postData() async {
    int randomIndex = Random().nextInt(dataValueArray.length);
    var randomSelection = dataValueArray[randomIndex];

    final request = await ApiService().defaultPostRequest(
        ApiConstants.baseUrl, ApiConstants.predictionEndpoint, randomSelection);

    debugPrint(request);
  }

  getData() async {
    final results = await ApiService().defaultGetRequest(
        ApiConstants.baseUrl, ApiConstants.predictionEndpoint);

    setState(() {
      predictions = results["prediction"][0];
      probabilities = results["probability"];
      pred_class = results["class_index"];
      actual_class = results['actual_class'];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu, color: Colors.black),
          title: const Text('Model Predictions',
              style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0.5,
        ),
        body: Column(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(10),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                const Text("Movement"),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    predictions ?? "Error Getting Results - Please Refresh",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView(
                children: [
                  ListTile(
                    tileColor: Colors.white,
                    title: const Text("Confidence"),
                    trailing: Text(
                      probabilities != null
                          ? probabilities.toStringAsFixed(6)
                          : "Loading",
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  ListTile(
                    tileColor: Colors.white,
                    title: const Text("Predicted class"),
                    trailing: Text(
                      pred_class ?? "Loading",
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  ListTile(
                    tileColor: Colors.white,
                    title: const Text("Actual class"),
                    trailing: Text(
                      actual_class ?? "Loading",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView(children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15),
                          backgroundColor:
                              const Color.fromARGB(255, 105, 122, 248)),
                      onPressed: () {
                        getData();
                      },
                      child: const Text('Refresh'),
                    )
                  ])))
        ]));
  }
}
