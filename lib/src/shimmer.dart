import 'package:flutter/material.dart';

/// A widget that provides a shimmer effect to its child widgets.
///
/// This widget creates an animated gradient that can be used to create
/// a shimmer loading effect. Child widgets can access the shimmer state
/// using [Shimmer.of].
///
/// Example:
/// ```dart
/// Shimmer(
///   linearGradient: LinearGradient(
///     colors: [
///       Colors.grey[300]!,
///       Colors.grey[100]!,
///       Colors.grey[300]!,
///     ],
///   ),
///   child: YourWidget(),
/// )
/// ```
class Shimmer extends StatefulWidget {
  /// Creates a shimmer widget.
  ///
  /// The [linearGradient] parameter is required and defines the gradient
  /// colors for the shimmer effect.
  const Shimmer({
    super.key,
    required this.linearGradient,
    this.child,
    this.period = const Duration(milliseconds: 1000),
  });

  /// The gradient used for the shimmer effect.
  final LinearGradient linearGradient;

  /// The child widget to apply the shimmer effect to.
  final Widget? child;

  /// The duration of one shimmer animation cycle.
  final Duration period;

  /// Returns the [ShimmerState] of the nearest [Shimmer] ancestor.
  ///
  /// Returns null if no [Shimmer] ancestor is found.
  static ShimmerState? of(BuildContext context) {
    return context.findAncestorStateOfType<ShimmerState>();
  }

  @override
  ShimmerState createState() => ShimmerState();
}

/// The state for [Shimmer] widget.
class ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: widget.period);
  }

  @override
  void didUpdateWidget(Shimmer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.period != widget.period) {
      _shimmerController.repeat(min: -0.5, max: 1.5, period: widget.period);
    }
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  /// The current gradient with the shimmer transform applied.
  LinearGradient get gradient => LinearGradient(
    colors: widget.linearGradient.colors,
    stops: widget.linearGradient.stops,
    begin: widget.linearGradient.begin,
    end: widget.linearGradient.end,
    transform: _SlidingGradientTransform(
      slidePercent: _shimmerController.value,
    ),
  );

  /// Whether the shimmer widget has been laid out and has a size.
  bool get isSized =>
      (context.findRenderObject() as RenderBox?)?.hasSize ?? false;

  /// The size of the shimmer widget.
  Size get size =>
      (context.findRenderObject() as RenderBox?)?.size ?? Size.zero;

  /// Gets the offset of a descendant widget within the shimmer widget.
  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final shimmerBox = context.findRenderObject() as RenderBox?;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  /// A [Listenable] that notifies listeners when the shimmer animation changes.
  Listenable get shimmerChanges => _shimmerController;

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}

/// A gradient transform that slides the gradient horizontally.
class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.slidePercent});

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0, 0);
  }
}
