import 'package:flutter/material.dart';
import 'package:flutter_shimmer_skeleton/src/shimmer_loading.dart';

/// A skeleton box widget that displays a rectangular placeholder with shimmer effect.
///
/// This widget is commonly used to show loading placeholders for images,
/// cards, or other rectangular content.
///
/// Example:
/// ```dart
/// SkeletonBox(
///   width: 200,
///   height: 100,
///   borderRadius: BorderRadius.circular(8),
/// )
/// ```
class SkeletonBox extends StatelessWidget {
  /// Creates a skeleton box widget.
  const SkeletonBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.color = Colors.black,
    this.isLoading = true,
  });

  /// The width of the box. If null, the box will expand to fill available width.
  final double? width;

  /// The height of the box. If null, the box will expand to fill available height.
  final double? height;

  /// The border radius of the box.
  final BorderRadius? borderRadius;

  /// The base color of the skeleton (before shimmer is applied).
  final Color color;

  /// Whether the shimmer effect should be active.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      isLoading: isLoading,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius ?? BorderRadius.zero,
        ),
      ),
    );
  }
}

/// A skeleton circle widget that displays a circular placeholder with shimmer effect.
///
/// This widget is commonly used to show loading placeholders for avatars
/// or circular images.
///
/// Example:
/// ```dart
/// SkeletonCircle(
///   size: 50,
/// )
/// ```
class SkeletonCircle extends StatelessWidget {
  /// Creates a skeleton circle widget.
  const SkeletonCircle({
    super.key,
    required this.size,
    this.color = Colors.black,
    this.isLoading = true,
  });

  /// The diameter of the circle.
  final double size;

  /// The base color of the skeleton (before shimmer is applied).
  final Color color;

  /// Whether the shimmer effect should be active.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      isLoading: isLoading,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}

/// A skeleton text widget that displays text-like placeholders with shimmer effect.
///
/// This widget is commonly used to show loading placeholders for text content.
/// It can display multiple lines of text with varying widths.
///
/// Example:
/// ```dart
/// SkeletonText(
///   lines: 3,
///   lineHeight: 16,
///   spacing: 8,
/// )
/// ```
class SkeletonText extends StatelessWidget {
  /// Creates a skeleton text widget.
  const SkeletonText({
    super.key,
    this.lines = 1,
    this.lineHeight = 16,
    this.spacing = 8,
    this.width,
    this.lastLineWidth,
    this.borderRadius,
    this.color = Colors.black,
    this.isLoading = true,
  });

  /// The number of text lines to display.
  final int lines;

  /// The height of each line.
  final double lineHeight;

  /// The spacing between lines.
  final double spacing;

  /// The width of the lines. If null, lines will expand to fill available width.
  final double? width;

  /// The width of the last line. If null, uses [width].
  final double? lastLineWidth;

  /// The border radius of each line.
  final BorderRadius? borderRadius;

  /// The base color of the skeleton (before shimmer is applied).
  final Color color;

  /// Whether the shimmer effect should be active.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(lines, (index) {
        final bool isLastLine = index == lines - 1;
        final double? lineWidth = isLastLine && lastLineWidth != null
            ? lastLineWidth
            : width;

        return Padding(
          padding: EdgeInsets.only(bottom: isLastLine ? 0 : spacing),
          child: SkeletonBox(
            width: lineWidth,
            height: lineHeight,
            borderRadius: borderRadius ?? BorderRadius.circular(lineHeight / 2),
            color: color,
            isLoading: isLoading,
          ),
        );
      }),
    );
  }
}

/// A skeleton list item widget that displays a common list item layout with shimmer effect.
///
/// This widget combines multiple skeleton widgets to create a typical list item
/// layout with an avatar, title, and subtitle.
///
/// Example:
/// ```dart
/// SkeletonListItem(
///   hasAvatar: true,
///   hasSubtitle: true,
/// )
/// ```
class SkeletonListItem extends StatelessWidget {
  /// Creates a skeleton list item widget.
  const SkeletonListItem({
    super.key,
    this.hasAvatar = true,
    this.hasSubtitle = true,
    this.avatarSize = 48,
    this.titleWidth,
    this.subtitleWidth,
    this.spacing = 12,
    this.color = Colors.black,
    this.isLoading = true,
  });

  /// Whether to show an avatar skeleton.
  final bool hasAvatar;

  /// Whether to show a subtitle skeleton.
  final bool hasSubtitle;

  /// The size of the avatar.
  final double avatarSize;

  /// The width of the title line.
  final double? titleWidth;

  /// The width of the subtitle line.
  final double? subtitleWidth;

  /// The spacing between avatar and text content.
  final double spacing;

  /// The base color of the skeleton (before shimmer is applied).
  final Color color;

  /// Whether the shimmer effect should be active.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasAvatar) ...[
          SkeletonCircle(size: avatarSize, color: color, isLoading: isLoading),
          SizedBox(width: spacing),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonText(
                lines: 1,
                lineHeight: 16,
                width: titleWidth,
                color: color,
                isLoading: isLoading,
              ),
              if (hasSubtitle) ...[
                const SizedBox(height: 8),
                SkeletonText(
                  lines: 1,
                  lineHeight: 14,
                  width: subtitleWidth,
                  color: color,
                  isLoading: isLoading,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// A skeleton card widget that displays a card-like layout with shimmer effect.
///
/// This widget is commonly used to show loading placeholders for card-based
/// content with an image and text.
///
/// Example:
/// ```dart
/// SkeletonCard(
///   hasImage: true,
///   imageHeight: 200,
///   hasText: true,
/// )
/// ```
class SkeletonCard extends StatelessWidget {
  /// Creates a skeleton card widget.
  const SkeletonCard({
    super.key,
    this.hasImage = true,
    this.imageHeight = 200,
    this.imageAspectRatio,
    this.hasText = true,
    this.textLines = 2,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.color = Colors.black,
    this.isLoading = true,
  });

  /// Whether to show an image skeleton.
  final bool hasImage;

  /// The height of the image skeleton.
  final double imageHeight;

  /// The aspect ratio of the image skeleton. If null, uses [imageHeight].
  final double? imageAspectRatio;

  /// Whether to show text skeletons.
  final bool hasText;

  /// The number of text lines to display.
  final int textLines;

  /// The padding around the card content.
  final EdgeInsets padding;

  /// The border radius of the card.
  final BorderRadius borderRadius;

  /// The base color of the skeleton (before shimmer is applied).
  final Color color;

  /// Whether the shimmer effect should be active.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasImage) ...[
            SkeletonBox(
              width: double.infinity,
              height: imageAspectRatio != null ? null : imageHeight,
              borderRadius: borderRadius,
              color: color,
              isLoading: isLoading,
            ),
            if (hasText) const SizedBox(height: 16),
          ],
          if (hasText) ...[
            SkeletonText(
              lines: textLines,
              lineHeight: 16,
              spacing: 8,
              lastLineWidth: 250,
              color: color,
              isLoading: isLoading,
            ),
          ],
        ],
      ),
    );
  }
}
