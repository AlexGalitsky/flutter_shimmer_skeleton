// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://flutter.dev/to/integration-testing

import 'package:flutter/material.dart';
import 'package:flutter_shimmer_skeleton/flutter_shimmer_skeleton.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Shimmer widgets render correctly', (WidgetTester tester) async {
    const shimmerGradient = LinearGradient(
      colors: [
        Color(0xFFEBEBF4),
        Color(0xFFF4F4F4),
        Color(0xFFEBEBF4),
      ],
      stops: [0.1, 0.3, 0.4],
      begin: Alignment(-1, -0.3),
      end: Alignment(1, 0.3),
      tileMode: TileMode.clamp,
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Shimmer(
            linearGradient: shimmerGradient,
            child: Column(
              children: [
                SkeletonBox(
                  width: 200,
                  height: 100,
                ),
                SizedBox(height: 16),
                SkeletonCircle(size: 50),
                SizedBox(height: 16),
                SkeletonText(
                  lines: 3,
                  lineHeight: 16,
                ),
                SizedBox(height: 16),
                SkeletonListItem(
                  hasAvatar: true,
                  hasSubtitle: true,
                ),
                SizedBox(height: 16),
                SkeletonCard(
                  hasImage: true,
                  hasText: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Verify that all skeleton widgets are rendered
    expect(find.byType(SkeletonBox), findsOneWidget);
    expect(find.byType(SkeletonCircle), findsOneWidget);
    expect(find.byType(SkeletonText), findsOneWidget);
    expect(find.byType(SkeletonListItem), findsOneWidget);
    expect(find.byType(SkeletonCard), findsOneWidget);

    // Wait for animation to start
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));

    // Verify widgets are still present after animation
    expect(find.byType(SkeletonBox), findsOneWidget);
    expect(find.byType(SkeletonCircle), findsOneWidget);
  });
}
