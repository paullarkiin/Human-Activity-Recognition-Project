// application routes used throughout, easier to manage and reference.
class ApiConstants {
  static String baseUrl = 'http://10.0.2.2';
  static String localTestingUrl = 'http://127.0.0.1';
  static String circleChartEndpoint = '/activities';
  static String barChartEndpoint = '/activities/chart/bar';
  static String meanValuesEndpoint = '/activities/mean';
  static String meanLineChartEndpoint = '/activities/chart/line/acceleration';
  static String angleLineChartEndpoint = '/activities/chart/line/angle';
  static String stdLineChartEndpoint = '/activities/chart/line/std';
  static String energyLineChartEndpoint = '/activities/chart/line/energy';
  static String predictionEndpoint = '/predict';
}
