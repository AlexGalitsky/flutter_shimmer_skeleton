import 'package:flutter/material.dart';
import 'package:flutter_shimmer_skeleton/flutter_shimmer_skeleton.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Shimmer Widget Tests', () {
    testWidgets('Shimmer widget builds correctly', (WidgetTester tester) async {
      const shimmerGradient = LinearGradient(colors: [Colors.grey, Colors.white, Colors.grey]);

      await tester.pumpWidget(
        const MaterialApp(
          home: Shimmer(linearGradient: shimmerGradient, child: Text('Test')),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('Shimmer.of returns null when no ancestor', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final shimmer = Shimmer.of(context);
              expect(shimmer, isNull);
              return const Text('Test');
            },
          ),
        ),
      );
    });

    testWidgets('Shimmer.of returns state when ancestor exists', (WidgetTester tester) async {
      const LinearGradient shimmerGradient = LinearGradient(
        colors: [Colors.grey, Colors.white, Colors.grey],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Shimmer(
            linearGradient: shimmerGradient,
            child: Builder(
              builder: (context) {
                final shimmer = Shimmer.of(context);
                expect(shimmer, isNotNull);
                return const Text('Test');
              },
            ),
          ),
        ),
      );
    });
  });

  group('ShimmerLoading Widget Tests', () {
    testWidgets('ShimmerLoading shows child when not loading', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ShimmerLoading(isLoading: false, child: Text('Content'))),
      );

      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('ShimmerLoading shows shimmer when loading without Shimmer ancestor', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: ShimmerLoading(isLoading: true, child: Text('Content'))),
      );

      // Should show empty box when no Shimmer ancestor
      expect(find.text('Content'), findsNothing);
    });
  });

  group('Skeleton Widgets Tests', () {
    testWidgets('SkeletonBox builds correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: SkeletonBox(width: 100, height: 50))),
      );

      expect(find.byType(SkeletonBox), findsOneWidget);
    });

    testWidgets('SkeletonCircle builds correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: SkeletonCircle(size: 50))));

      expect(find.byType(SkeletonCircle), findsOneWidget);
    });

    testWidgets('SkeletonText builds correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: SkeletonText(lines: 3, lineHeight: 16))),
      );

      expect(find.byType(SkeletonText), findsOneWidget);
    });

    testWidgets('SkeletonListItem builds correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SkeletonListItem(hasAvatar: true, hasSubtitle: true)),
        ),
      );

      expect(find.byType(SkeletonListItem), findsOneWidget);
    });

    testWidgets('SkeletonCard builds correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: SkeletonCard(hasImage: true, hasText: true))),
      );

      expect(find.byType(SkeletonCard), findsOneWidget);
    });
  });
}
