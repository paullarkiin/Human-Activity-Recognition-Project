import 'package:flutter_test/flutter_test.dart';
import 'package:viz_app/models/bar_chart_model.dart';
import 'package:viz_app/models/line_chart_model.dart';

void main() {
  group('BarchartModel', () {
    test('fromJson should create a BarChartModelValue from a valid JSON object',
        () {
      final json = {'Activity': 'Running', 'Value': 10.0};
      final value = BarChartModelValue.fromJson(json);

      expect(value.activity, equals('Running'));
      expect(value.value, equals(10.0));
    });
  });

  group('linechart', () {
    test('fromJson should create a ChartModelValue from a valid JSON object',
        () {
      final json = {'Index': 1, 'Value': 10.0};
      final value = ChartModelValue.fromJson(json);

      expect(value.index, equals(1));
      expect(value.value, equals(10.0));
    });
  });
}
