import 'package:flutter/material.dart';
import 'package:viz_app/pages/acceleration_chart_page.dart';
import 'package:viz_app/pages/angle_chart_page.dart';
import 'package:viz_app/pages/energy_chart_page.dart';
import 'package:viz_app/pages/bar_chart.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:math' as math;
import 'package:viz_app/pages/standard_dev_chart_page.dart';
import 'package:viz_app/network/constants.dart';
import 'package:viz_app/network/call_api.dart';

enum LegendShape { circle, rectangle }

class ModelInformation extends StatefulWidget {
  const ModelInformation({super.key});

  @override
  State<ModelInformation> createState() => _ModelInformationState();
}

// primary widget try that takes inastances of other classes below and renders them
class _ModelInformationState extends State<ModelInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu, color: Colors.black),
          title: const Text('Model Information',
              style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0.5,
        ),
        body: ListView(
          children: <Widget>[
            const SizedBox(
              height: 12,
            ),
            const ListTile(
              leading: Text("Activities Breakdown"),
              trailing: NavToViewDetails(),
            ),
            const SizedBox(height: 24), // space between elements
            const CreateChart(),
            const SizedBox(height: 24),
            const InformationRows(),
          ],
        ));
  }
}

// allow user to navigate to bar chart page from model information
class NavToViewDetails extends StatelessWidget {
  const NavToViewDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const BarChartPage())));
      },
      child: const Text("View Details", style: TextStyle(color: Colors.black)),
    );
  }
}

class InformationRows extends StatefulWidget {
  const InformationRows({super.key});

  @override
  State<InformationRows> createState() => _InformationRowsState();
}

class _InformationRowsState extends State<InformationRows> {
  var meanValue, stdValue, angleValue, energyValue;

  Future getMean() async {
    final results = await ApiService().defaultGetRequest(
        ApiConstants.baseUrl, ApiConstants.meanValuesEndpoint);

    setState(() {
      meanValue = results["Mean"]["tBodyAccMag-mean()"]["mean"];
      stdValue = results["Mean"]["tBodyAcc-std()-X"]["std"];
      angleValue = results["Mean"]["angle(tBodyAccMean,gravity)"]["mean"];
      energyValue = results["Mean"]["tBodyAcc-energy()-X"]["mean"];
    });
  }

  @override
  void initState() {
    super.initState();
    getMean();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListView(
              // padding: EdgeInsets.only(left: 8),
              children: const <Widget>[
                ListTile(
                  tileColor: Colors.white,
                  leading: Icon(
                    Icons.square,
                    color: const Color.fromRGBO(72, 93, 254, 1),
                  ),
                  title: Text("Mean"),
                ),
                ListTile(
                  tileColor: Colors.white,
                  leading: Icon(
                    Icons.square,
                    color: Color.fromRGBO(72, 93, 254, 1),
                  ),
                  title: Text("Standard Deviation"),
                ),
                ListTile(
                  tileColor: Colors.white,
                  leading: Icon(
                    Icons.square,
                    color: Color.fromRGBO(72, 93, 254, 1),
                  ),
                  title: Text("Angle"),
                ),
                ListTile(
                  tileColor: Colors.white,
                  leading: Icon(
                    Icons.square,
                    color: Color.fromRGBO(72, 93, 254, 1),
                  ),
                  title: Text("Energy"),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              // padding: EdgeInsets.only(right: 8),
              children: <Widget>[
                ListTile(
                  tileColor: Colors.white,
                  trailing: const Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                const AccelerationLineChartPage())));
                  },
                  title: Text(
                    meanValue != null
                        ? meanValue.toStringAsFixed(6)
                        : "Loading",
                  ),
                ),
                ListTile(
                  tileColor: Colors.white,
                  trailing: const Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                const StandardDevChartPage())));
                  },
                  title: Text(stdValue != null
                      ? stdValue.toStringAsFixed(6)
                      : "Loading"),
                ),
                ListTile(
                  tileColor: Colors.white,
                  trailing: const Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const AngleChartPage())));
                  },
                  title: Text(angleValue != null
                      ? angleValue.toStringAsFixed(6)
                      : "Loading"),
                ),
                ListTile(
                  tileColor: Colors.white,
                  trailing: const Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const EnergyChartPage())));
                  },
                  title: Text(energyValue != null
                      ? energyValue.toStringAsFixed(6)
                      : "Loading"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CreateChart extends StatefulWidget {
  const CreateChart({Key? key}) : super(key: key);

  @override
  CreateChartState createState() => CreateChartState();
}

class CreateChartState extends State<CreateChart> {
  var standingLabel,
      sittingLabel,
      layingLabel,
      walkingLabel,
      walkingDownstairsLabel,
      walkingUpStairsLabel;

  var standingValue,
      sittingValue,
      layingValue,
      walkingValue,
      walkingDownstairsValue,
      walkingUpStairsValue,
      meanValue;

  Future getActivities() async {
    final results = await ApiService().defaultGetRequest(
        ApiConstants.baseUrl, ApiConstants.circleChartEndpoint);

    // assigns local varables a value from JSON object sent back,
    //which can be displayed in the widget tree below.

    setState(() {
      standingLabel = results["activities"]["Activity"]["0"];
      sittingLabel = results["activities"]["Activity"]["1"];
      layingLabel = results["activities"]["Activity"]["2"];
      walkingLabel = results["activities"]["Activity"]["3"];
      walkingDownstairsLabel = results["activities"]["Activity"]["4"];
      walkingUpStairsLabel = results["activities"]["Activity"]["5"];

      standingValue = results["activities"]["Value"]["0"];
      sittingValue = results["activities"]["Value"]["1"];
      layingValue = results["activities"]["Value"]["2"];
      walkingValue = results["activities"]["Value"]["3"];
      walkingDownstairsValue = results["activities"]["Value"]["4"];
      walkingUpStairsValue = results["activities"]["Value"]["5"];
    });
  }

  @override
  void initState() {
    super.initState();
    getActivities();
  }

  final legendLabels = <String, String>{
    "Standing": "Standing legend",
    "Sitting": "Sitting legend",
    "Laying": "Laying legend",
    "Walking": "Walking legend",
  };

  final colorList = <Color>[
    // Color.fromRGBO(188, 145, 249, 1),
    // Color.fromRGBO(9, 132, 227, 1),
    const Color.fromRGBO(0, 106, 255, 1),
    const Color.fromRGBO(30, 0, 255, 1),
    const Color.fromRGBO(108, 92, 231, 1),
    const Color.fromRGBO(136, 105, 248, 1)
    // Color.fromRGBO(163, 59, 255, 1),
    // const Color(0xffe17055),
  ];

  ChartType? _chartType = ChartType.ring;
  bool _showCenterText = true;
  double? _ringStrokeWidth = 24;
  double? _chartLegendSpacing = 32;

  bool _showLegendsInRow = true;
  bool _showLegends = true;
  bool _showLegendLabel = false;

  bool _showChartValueBackground = true;
  bool _showChartValues = true;
  bool _showChartValuesInPercentage = true;
  bool _showChartValuesOutside = false;

  bool _showGradientColors = false;

  LegendShape? _legendShape = LegendShape.circle;
  LegendPosition? _legendPosition = LegendPosition.bottom;

  int key = 0;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      key: ValueKey(key),
      dataMap: {
        "Standing": standingValue ?? 0.0,
        "Sitting": sittingValue ?? 0.0,
        "Laying": layingValue ?? 0.0,
        "Walking": walkingValue ?? 0.0,
      },
      animationDuration: const Duration(milliseconds: 800),
      chartLegendSpacing: _chartLegendSpacing!,
      chartRadius: math.min(MediaQuery.of(context).size.width / 2.1, 300),
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: _chartType!,
      centerText: _showCenterText ? "ACTIVITIES" : null,
      legendLabels: _showLegendLabel ? legendLabels : {},
      legendOptions: LegendOptions(
        showLegendsInRow: _showLegendsInRow,
        legendPosition: _legendPosition!,
        showLegends: _showLegends,
        legendShape: _legendShape == LegendShape.circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        legendTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: _showChartValueBackground,
        showChartValues: _showChartValues,
        showChartValuesInPercentage: _showChartValuesInPercentage,
        showChartValuesOutside: _showChartValuesOutside,
      ),
      ringStrokeWidth: _ringStrokeWidth!,
      emptyColor: Colors.grey,
      gradientList: null,
      emptyColorGradient: const [
        Color(0xff6c5ce7),
        Colors.blue,
      ],
      baseChartColor: Colors.transparent,
    );
  }
}
