import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:viz_app/network/constants.dart';
import '../models/line_chart_model.dart';
import '../network/call_api.dart';

// public
class EnergyChartPage extends StatefulWidget {
  const EnergyChartPage({super.key});

  @override
  _EnergyChartPage createState() => _EnergyChartPage();
}

// private
class _EnergyChartPage extends State<EnergyChartPage> {
  late List<charts.Series<ChartModelValue, int>> _seriesLineData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final jsonData = await ApiService().defaultGetRequest(
        ApiConstants.baseUrl, ApiConstants.energyLineChartEndpoint);

    // uses the model class to trasform data so that it in the correct format
    // accepted by the series object from the chart package below.

    final walkingData = (jsonData['walking_data'] as List)
        .map((e) => ChartModelValue.fromJson(e))
        .toList();

    final upstairsData = (jsonData['upstairs_data'] as List)
        .map((e) => ChartModelValue.fromJson(e))
        .toList();

    final standingData = (jsonData['standing_data'] as List)
        .map((e) => ChartModelValue.fromJson(e))
        .toList();

    final layingData = (jsonData['laying_data'] as List)
        .map((e) => ChartModelValue.fromJson(e))
        .toList();

    final sittingData = (jsonData['sitting_data'] as List)
        .map((e) => ChartModelValue.fromJson(e))
        .toList();

    final downstairsData = (jsonData['downstairs_data'] as List)
        .map((e) => ChartModelValue.fromJson(e))
        .toList();

    setState(() {
      _seriesLineData = [
        charts.Series<ChartModelValue, int>(
          id: 'Walking',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(
              Color.fromARGB(255, 105, 122, 248)),
          domainFn: (ChartModelValue cv, _) => cv.index,
          measureFn: (ChartModelValue cv, _) => cv.value,
          data: walkingData,
        ),
        charts.Series<ChartModelValue, int>(
          id: 'Walking Upstairs',
          colorFn: (_, __) =>
              charts.ColorUtil.fromDartColor(Color.fromARGB(160, 255, 225, 0)),
          domainFn: (ChartModelValue cv, _) => cv.index,
          measureFn: (ChartModelValue cv, _) => cv.value,
          data: upstairsData,
        ),
        charts.Series<ChartModelValue, int>(
          id: 'Standing',
          colorFn: (_, __) =>
              charts.ColorUtil.fromDartColor(Color.fromARGB(125, 255, 0, 204)),
          domainFn: (ChartModelValue cv, _) => cv.index,
          measureFn: (ChartModelValue cv, _) => cv.value,
          data: standingData,
        ),
        charts.Series<ChartModelValue, int>(
          id: 'Laying',
          colorFn: (_, __) =>
              charts.ColorUtil.fromDartColor(Color.fromARGB(98, 34, 205, 252)),
          domainFn: (ChartModelValue cv, _) => cv.index,
          measureFn: (ChartModelValue cv, _) => cv.value,
          data: layingData,
        ),
        charts.Series<ChartModelValue, int>(
          id: 'Sitting',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(
              Color.fromRGBO(108, 92, 231, 0.602)),
          domainFn: (ChartModelValue cv, _) => cv.index,
          measureFn: (ChartModelValue cv, _) => cv.value,
          data: sittingData,
        ),
        charts.Series<ChartModelValue, int>(
          id: 'Downstairs',
          colorFn: (_, __) =>
              charts.ColorUtil.fromDartColor(Color.fromARGB(142, 215, 57, 255)),
          domainFn: (ChartModelValue cv, _) => cv.index,
          measureFn: (ChartModelValue cv, _) => cv.value,
          data: downstairsData,
        ),
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, // <-- SEE HERE
        ),
        title: const Text('Energy', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2,
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
                          child:
                              CircularProgressIndicator(), // display's if error
                        )
                      : charts.LineChart(_seriesLineData,
                          behaviors: [
                            charts.SeriesLegend(
                              position: charts.BehaviorPosition.bottom,
                              horizontalFirst: false,
                              desiredMaxRows: 3,
                            )
                          ],
                          domainAxis: const charts.NumericAxisSpec(
                              viewport: charts.NumericExtents(0, 60)),
                          primaryMeasureAxis: const charts.NumericAxisSpec(
                              viewport: charts.NumericExtents(-6, 0.5)),
                          defaultRenderer:
                              charts.LineRendererConfig(stacked: true))),
            ),
          ),
        ],
      ),
    );
  }
}
