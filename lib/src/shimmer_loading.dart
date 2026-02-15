import 'package:flutter/material.dart';
import 'package:flutter_shimmer_skeleton/src/shimmer.dart';

/// A widget that conditionally applies a shimmer effect to its child.
///
/// When [isLoading] is true, the child widget is masked with a shimmer effect
/// from the nearest [Shimmer] ancestor. When [isLoading] is false, the child
/// is displayed normally.
///
/// Example:
/// ```dart
/// ShimmerLoading(
///   isLoading: true,
///   child: Container(
///     width: 200,
///     height: 100,
///     color: Colors.grey,
///   ),
/// )
/// ```
class ShimmerLoading extends StatefulWidget {
  /// Creates a shimmer loading widget.
  ///
  /// The [isLoading] parameter determines whether to show the shimmer effect.
  /// The [child] parameter is the widget to apply the shimmer to.
  const ShimmerLoading({super.key, required this.isLoading, required this.child});

  /// Whether the shimmer effect should be active.
  final bool isLoading;

  /// The child widget to apply the shimmer effect to.
  final Widget child;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  Listenable? _shimmerChanges;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_shimmerChanges != null) {
      _shimmerChanges!.removeListener(_onShimmerChange);
    }
    _shimmerChanges = Shimmer.of(context)?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges!.addListener(_onShimmerChange);
    }
  }

  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  void _onShimmerChange() {
    if (widget.isLoading) {
      setState(() {
        // Update the shimmer painting.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    // Collect ancestor shimmer info.
    final shimmer = Shimmer.of(context);
    if (shimmer == null || !shimmer.isSized) {
      // The ancestor Shimmer widget has not laid itself out yet.
      // Return an empty box.
      return const SizedBox();
    }

    final Size shimmerSize = shimmer.size;
    final LinearGradient gradient = shimmer.gradient;
    final renderBox = context.findRenderObject() as RenderBox?;
    final Offset offsetWithinShimmer = renderBox == null
        ? Offset.zero
        : shimmer.getDescendantOffset(descendant: renderBox);

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(
            -offsetWithinShimmer.dx,
            -offsetWithinShimmer.dy,
            shimmerSize.width,
            shimmerSize.height,
          ),
        );
      },
      child: widget.child,
    );
  }
}
