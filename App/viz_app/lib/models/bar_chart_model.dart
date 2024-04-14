class BarChartModelValue {
  final String activity;
  final double value;

  BarChartModelValue({
    required this.activity,
    required this.value,
  });

  factory BarChartModelValue.fromJson(Map<String, dynamic> json) {
    return BarChartModelValue(
      activity: json['Activity'],
      value: json['Value'],
    );
  }
}
