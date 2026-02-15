# flutter_shimmer_skeleton

A Flutter package that provides shimmer loading skeleton widgets based on the [official Flutter documentation](https://docs.flutter.dev/cookbook/effects/shimmer-loading).

## Features

- ✨ Shimmer effect animation
- 🎨 Customizable gradient colors
- 📦 Ready-to-use skeleton widgets:
  - `SkeletonBox` - Rectangular placeholders
  - `SkeletonCircle` - Circular placeholders (for avatars)
  - `SkeletonText` - Text-like placeholders with multiple lines
  - `SkeletonListItem` - List item layout with avatar and text
  - `SkeletonCard` - Card layout with image and text
- 🎯 Easy to use and integrate
- 📱 Works on all Flutter platforms

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_shimmer_skeleton: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Example

Wrap your widgets with a `Shimmer` widget and use `ShimmerLoading` to conditionally apply the shimmer effect:

```dart
import 'package:flutter_shimmer_skeleton/flutter_shimmer_skeleton.dart';

Shimmer(
  linearGradient: LinearGradient(
    colors: [
      Colors.grey[300]!,
      Colors.grey[100]!,
      Colors.grey[300]!,
    ],
    stops: [0.1, 0.3, 0.4],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  ),
  child: YourWidget(),
)
```

### Using ShimmerLoading

```dart
ShimmerLoading(
  isLoading: true,
  child: Container(
    width: 200,
    height: 100,
    color: Colors.grey,
  ),
)
```

### Using Skeleton Widgets

#### SkeletonBox

```dart
SkeletonBox(
  width: 200,
  height: 100,
  borderRadius: BorderRadius.circular(8),
)
```

#### SkeletonCircle

```dart
SkeletonCircle(
  size: 50,
)
```

#### SkeletonText

```dart
SkeletonText(
  lines: 3,
  lineHeight: 16,
  spacing: 8,
  lastLineWidth: 250, // Last line can be shorter
)
```

#### SkeletonListItem

```dart
SkeletonListItem(
  hasAvatar: true,
  hasSubtitle: true,
  avatarSize: 48,
  titleWidth: 200,
  subtitleWidth: 150,
)
```

#### SkeletonCard

```dart
SkeletonCard(
  hasImage: true,
  imageHeight: 200,
  hasText: true,
  textLines: 2,
)
```

### Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_shimmer_skeleton/flutter_shimmer_skeleton.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool isLoading = true;

  static const _shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [0.1, 0.3, 0.4],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer(
        linearGradient: _shimmerGradient,
        child: ListView(
          children: [
            SkeletonListItem(
              hasAvatar: true,
              hasSubtitle: true,
            ),
            SkeletonCard(
              hasImage: true,
              hasText: true,
            ),
            SkeletonText(
              lines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
```

## API Reference

### Shimmer

The main widget that provides the shimmer effect to its children.

**Properties:**
- `linearGradient` (required) - The gradient used for the shimmer effect
- `child` - The child widget to apply the shimmer effect to
- `period` - The duration of one shimmer animation cycle (default: 1000ms)

### ShimmerLoading

A widget that conditionally applies a shimmer effect to its child.

**Properties:**
- `isLoading` (required) - Whether the shimmer effect should be active
- `child` (required) - The child widget to apply the shimmer effect to

### SkeletonBox

A rectangular skeleton placeholder.

**Properties:**
- `width` - The width of the box
- `height` - The height of the box
- `borderRadius` - The border radius of the box
- `color` - The base color (default: Colors.black)
- `isLoading` - Whether shimmer is active (default: true)

### SkeletonCircle

A circular skeleton placeholder.

**Properties:**
- `size` (required) - The diameter of the circle
- `color` - The base color (default: Colors.black)
- `isLoading` - Whether shimmer is active (default: true)

### SkeletonText

A text-like skeleton placeholder with multiple lines.

**Properties:**
- `lines` - Number of lines (default: 1)
- `lineHeight` - Height of each line (default: 16)
- `spacing` - Spacing between lines (default: 8)
- `width` - Width of lines
- `lastLineWidth` - Width of the last line
- `borderRadius` - Border radius of each line
- `color` - The base color (default: Colors.black)
- `isLoading` - Whether shimmer is active (default: true)

### SkeletonListItem

A list item skeleton with avatar and text.

**Properties:**
- `hasAvatar` - Whether to show avatar (default: true)
- `hasSubtitle` - Whether to show subtitle (default: true)
- `avatarSize` - Size of avatar (default: 48)
- `titleWidth` - Width of title line
- `subtitleWidth` - Width of subtitle line
- `spacing` - Spacing between avatar and text (default: 12)
- `color` - The base color (default: Colors.black)
- `isLoading` - Whether shimmer is active (default: true)

### SkeletonCard

A card skeleton with image and text.

**Properties:**
- `hasImage` - Whether to show image (default: true)
- `imageHeight` - Height of image (default: 200)
- `imageAspectRatio` - Aspect ratio of image
- `hasText` - Whether to show text (default: true)
- `textLines` - Number of text lines (default: 2)
- `padding` - Padding around card (default: EdgeInsets.all(16))
- `borderRadius` - Border radius of card (default: BorderRadius.all(Radius.circular(12)))
- `color` - The base color (default: Colors.black)
- `isLoading` - Whether shimmer is active (default: true)

## Customization

You can customize the shimmer effect by providing your own gradient:

```dart
Shimmer(
  linearGradient: LinearGradient(
    colors: [
      Colors.blue[300]!,
      Colors.blue[100]!,
      Colors.blue[300]!,
    ],
    // ... other gradient properties
  ),
  period: Duration(milliseconds: 1500), // Custom animation speed
  child: YourWidget(),
)
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Credits

This package is based on the official Flutter documentation example:
https://docs.flutter.dev/cookbook/effects/shimmer-loading
