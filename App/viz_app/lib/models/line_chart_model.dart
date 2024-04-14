class ChartModelValue {
  final int index;
  final double value;

  ChartModelValue({
    required this.index,
    required this.value,
  });

  factory ChartModelValue.fromJson(Map<String, dynamic> json) {
    return ChartModelValue(
      index: json['Index'],
      value: json['Value'],
    );
  }
}
