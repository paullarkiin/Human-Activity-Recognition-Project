import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:viz_app/network/constants.dart';

import '../models/bar_chart_model.dart';
import '../network/call_api.dart';

class BarChartPage extends StatefulWidget {
  const BarChartPage({super.key});

  @override
  _BarChartPageState createState() => _BarChartPageState();
}

class _BarChartPageState extends State<BarChartPage> {
  late List<charts.Series<BarChartModelValue, String>> _seriesList;
  bool _isLoading = true;

// varaibles for late init and assignement to JSON responses.

  var standingValue,
      walkingValue,
      layingValue,
      sittingValue,
      upstairsValue,
      downstairsValue;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final jsonData = await ApiService()
        .defaultGetRequest(ApiConstants.baseUrl, ApiConstants.barChartEndpoint);

    // uses the model class to trasform data so that it in the correct format
    // accepted by the series object from the chart package below.

    final data = (jsonData['data'] as List)
        .map((e) => BarChartModelValue.fromJson(e))
        .toList();

    setState(() {
      _seriesList = [
        charts.Series<BarChartModelValue, String>(
          id: 'ChartModelValue',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(
              const Color.fromARGB(255, 105, 122, 248)),
          domainFn: (BarChartModelValue bcv, _) => bcv.activity,
          measureFn: (BarChartModelValue bcv, _) => bcv.value,
          data: data,
        )
      ];
      _isLoading = false;
      standingValue = jsonData['data'][0]['Value'];
      sittingValue = jsonData['data'][1]['Value'];
      layingValue = jsonData['data'][2]['Value'];
      walkingValue = jsonData['data'][3]['Value'];
      upstairsValue = jsonData['data'][4]['Value'];
      downstairsValue = jsonData['data'][5]['Value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, // <-- SEE HERE
        ),
        title: const Text('Activities Breakdown',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(12),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 400.0,
                  maxWidth: 600.0,
                ),
                padding: const EdgeInsets.all(6),
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : charts.BarChart(
                        _seriesList,
                        animate: true,
                        vertical: true,
                        domainAxis: const charts.OrdinalAxisSpec(
                          renderSpec: charts.NoneRenderSpec(),
                        ),
                        primaryMeasureAxis: const charts.NumericAxisSpec(
                          renderSpec: charts.GridlineRendererSpec(),
                        ),
                      ),
              ),
            ),
          ),
          SizedBox(
            height: 400,
            child: ListView(
              padding: const EdgeInsets.all(16),
              itemExtent: 60,
              children: <Widget>[
                ListTile(
                  tileColor: Colors.white,
                  title: const Text("Standing"),
                  trailing: Text(
                    standingValue != null
                        ? standingValue.toStringAsFixed(0)
                        : "Loading",
                  ),
                ),
                ListTile(
                    tileColor: Colors.white,
                    title: const Text("Sitting"),
                    trailing: Text(
                      sittingValue != null
                          ? sittingValue.toStringAsFixed(0)
                          : "Loading",
                    )),
                ListTile(
                    tileColor: Colors.white,
                    title: const Text("Laying"),
                    trailing: Text(
                      layingValue != null
                          ? layingValue.toStringAsFixed(0)
                          : "Loading",
                    )),
                ListTile(
                    tileColor: Colors.white,
                    title: const Text("Walking"),
                    trailing: Text(
                      walkingValue != null
                          ? walkingValue.toStringAsFixed(0)
                          : "Loading",
                    )),
                ListTile(
                    tileColor: Colors.white,
                    title: const Text("Walking Upstairs"),
                    trailing: Text(
                      upstairsValue != null
                          ? upstairsValue.toStringAsFixed(0)
                          : "Loading",
                    )),
                ListTile(
                    tileColor: Colors.white,
                    title: const Text("Walking Downstairs"),
                    trailing: Text(
                      downstairsValue != null
                          ? downstairsValue.toStringAsFixed(0)
                          : "Loading",
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
