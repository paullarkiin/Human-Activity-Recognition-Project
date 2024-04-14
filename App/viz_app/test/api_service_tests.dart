import 'package:flutter_test/flutter_test.dart';
import 'package:viz_app/network/call_api.dart';
import 'package:viz_app/network/constants.dart';

void main() {
  test('defaultGetRequest should return the expected response for a valid URL',
      () async {
    final apiService = ApiService();
    final response = await apiService.defaultGetRequest(
        'https://jsonplaceholder.typicode.com', '/todos/1');
    expect(response['id'], equals(1));
    expect(response['userId'], equals(1));
    expect(response['title'], equals('delectus aut autem'));
    expect(response['completed'], equals(false));
  });

  test('defaultGetRequest should return null for an invalid URL', () async {
    final apiService = ApiService();
    final response = await apiService.defaultGetRequest(
        'https://jsonplaceholder.typicode.com', '/todos/invalid');
    expect(response, isNull);
  });

  test(
      'defaultGetRequest should return the expected response for a valid project URL',
      () async {
    final apiService = ApiService();
    final response = await apiService.defaultGetRequest(
        ApiConstants.baseUrl, ApiConstants.barChartEndpoint);

    expect(response['data'][0]['Value'], equals(1906.0));
    expect(response['data'][1]['Value'], equals(1777.0));
    expect(response['data'][2]['Value'], equals(1944.0));
    expect(response['data'][3]['Value'], equals(1722.0));
    expect(response['data'][4]['Value'], equals(1406.0));
    expect(response['data'][5]['Value'], equals(1544.0));
  });
}
