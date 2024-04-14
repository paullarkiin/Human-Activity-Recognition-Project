import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:viz_app/pages/model_info.dart';
import 'package:viz_app/pages/prediction_page.dart';
import 'package:viz_app/main.dart';
import 'package:viz_app/pages/navigation_page.dart';
import 'package:viz_app/pages/angle_chart_page.dart';
import 'package:viz_app/pages/acceleration_chart_page.dart';
import 'package:viz_app/pages/bar_chart.dart';
import 'package:viz_app/pages/energy_chart_page.dart';
import 'package:viz_app/pages/standard_dev_chart_page.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('Main', () {
    testWidgets('Check that NavigationPage is set as the home page',
        (WidgetTester tester) async {
      await tester.pumpWidget(const VizApp());
      expect(find.byType(NavigationPage), findsOneWidget);
    });
  });

  group('PredictionPage', () {
    testWidgets('shows the correct page title', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(const MaterialApp(home: PredictionPage()));
      // find text
      final titleFinder = find.text('Model Predictions');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('Shows the refresh button', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(const MaterialApp(home: PredictionPage()));

      // Find the refresh button
      final refreshButtonFinder = find.text('Refresh');

      // Verify the refresh button is displayed
      expect(refreshButtonFinder, findsOneWidget);
    });

    testWidgets('displays loading indicators', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: PredictionPage()));

      // Find the loading text widgets
      final loadingProbabilitiesFinder = find.text('Loading');
      final loadingPredClassFinder = find.text('Loading');
      final loadingActualClassFinder = find.text('Loading');

      // Verify the loading text widgets are displayed
      expect(loadingProbabilitiesFinder, findsOneWidget);
      expect(loadingPredClassFinder, findsOneWidget);
      expect(loadingActualClassFinder, findsOneWidget);
    });
  });

  group('AccelerationLineChartPage', () {
    testWidgets('should display the app bar title',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: AccelerationLineChartPage(),
      ));

      final titleFinder = find.text('Acceleration Mean');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('Display a loading indicator when data is not loaded',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: AccelerationLineChartPage(),
      ));

      final loadingIndicatorFinder = find.byType(CircularProgressIndicator);
      expect(loadingIndicatorFinder, findsOneWidget);
    });
  });

  group('EnergyLineChartPage', () {
    testWidgets('check if the correct app bar title is displayed',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: EnergyChartPage(),
      ));

      final titleFinder = find.text('Energy');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('Display a loading indicator when data is not loaded',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: EnergyChartPage(),
      ));

      final loadingIndicatorFinder = find.byType(CircularProgressIndicator);
      expect(loadingIndicatorFinder, findsOneWidget);
    });
  });
  group('AngleLineChartPage', () {
    testWidgets('check if the correct app bar title is displayed',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: AngleChartPage(),
      ));

      final titleFinder = find.text('Angle (Gravity)');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('Display a loading indicator when data is not loaded',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: AngleChartPage(),
      ));

      final loadingIndicatorFinder = find.byType(CircularProgressIndicator);
      expect(loadingIndicatorFinder, findsOneWidget);
    });
  });
  group('StdineChartPage', () {
    testWidgets('check if the correct app bar title is displayed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: StandardDevChartPage()),
      );

      final titleFinder = find.text('Standard Deviation');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('Display a loading indicator when data is not loaded',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: StandardDevChartPage(),
      ));

      final loadingIndicatorFinder = find.byType(CircularProgressIndicator);
      expect(loadingIndicatorFinder, findsOneWidget);
    });
  });

  group('BarChartPage', () {
    testWidgets('check if the correct app bar title is displayed',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: BarChartPage(),
      ));

      final titleFinder = find.text('Activities Breakdown');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('Check if List Tile Titles are displayed',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: BarChartPage(),
      ));

      final titleFinder = find.text('Standing');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('Display a loading indicator when data is not loaded',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: BarChartPage(),
      ));

      final loadingIndicatorFinder = find.byType(CircularProgressIndicator);
      expect(loadingIndicatorFinder, findsOneWidget);
    });
  });

  group('ModelInfo', () {
    testWidgets('check if the correct app bar title is displayed',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ModelInformation(),
      ));

      final titleFinder = find.text('Acceleration Mean');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('check if the view details text is displayed',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ModelInformation(),
      ));

      final titleFinder = find.text('View Details');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('Check if List tile titles are displayed',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ModelInformation(),
      ));

      final titleFinder = find.text('Mean');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('Check if List tile icon are displayed',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ModelInformation(),
      ));

      final iconFinder = find.byIcon(Icons.square);
      expect(iconFinder, findsOneWidget);
    });

    testWidgets(
        'check if user can navigate to BarChartPage when button is tapped',
        (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(MaterialApp(
        home: NavToViewDetails(),
        navigatorObservers: [mockObserver],
      ));

      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(any!, any));
      expect(find.byType(BarChartPage), findsOneWidget);
    });
  });
}
