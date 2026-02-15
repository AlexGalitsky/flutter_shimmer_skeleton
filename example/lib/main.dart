import 'package:flutter/material.dart';
import 'package:flutter_shimmer_skeleton/flutter_shimmer_skeleton.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shimmer Skeleton Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  bool _isLoading = true;

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  // Default shimmer gradient based on Flutter documentation
  static const _shimmerGradient = LinearGradient(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer Skeleton Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Shimmer(
        linearGradient: _shimmerGradient,
        child: ListView(
          physics: _isLoading ? const NeverScrollableScrollPhysics() : null,
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 16),
            _buildTopRowList(),
            const SizedBox(height: 24),
            _buildListItem(),
            _buildListItem(),
            _buildListItem(),
            const SizedBox(height: 24),
            _buildCardExample(),
            const SizedBox(height: 24),
            _buildTextExample(),
            const SizedBox(height: 24),
            _buildCustomSkeletons(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleLoading,
        tooltip: _isLoading ? 'Show Content' : 'Show Loading',
        child: Icon(_isLoading ? Icons.hourglass_full : Icons.hourglass_bottom),
      ),
    );
  }

  Widget _buildTopRowList() {
    return SizedBox(
      height: 72,
      child: ListView(
        physics: _isLoading ? const NeverScrollableScrollPhysics() : null,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          const SizedBox(width: 16),
          if (_isLoading)
            ...List.generate(6, (index) => const SkeletonCircle(size: 54))
          else
            ...List.generate(
              6,
              (index) => Container(
                width: 54,
                height: 54,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 30),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildListItem() {
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: SkeletonListItem(
          hasAvatar: true,
          hasSubtitle: true,
          avatarSize: 48,
          titleWidth: 200,
          subtitleWidth: 150,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'List Item Title',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Subtitle text here',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardExample() {
    if (_isLoading) {
      return const SkeletonCard(
        hasImage: true,
        imageHeight: 200,
        hasText: true,
        textLines: 2,
        padding: EdgeInsets.all(16),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(Icons.image, size: 50, color: Colors.blue),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Card Title',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Card description text goes here',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildTextExample() {
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: SkeletonText(
          lines: 3,
          lineHeight: 16,
          spacing: 8,
          lastLineWidth: 250,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Text Line 1',
            style: TextStyle(fontSize: 16, color: Colors.grey[800]),
          ),
          const SizedBox(height: 8),
          Text(
            'Text Line 2',
            style: TextStyle(fontSize: 16, color: Colors.grey[800]),
          ),
          const SizedBox(height: 8),
          Text(
            'Text Line 3',
            style: TextStyle(fontSize: 16, color: Colors.grey[800]),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomSkeletons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Custom Skeletons',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (_isLoading) ...[
            const SkeletonBox(
              width: double.infinity,
              height: 100,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                SkeletonCircle(size: 40),
                SizedBox(width: 16),
                Expanded(
                  child: SkeletonText(
                    lines: 2,
                    lineHeight: 14,
                    spacing: 6,
                  ),
                ),
              ],
            ),
          ] else ...[
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text('Custom Box Content'),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text('Custom content with avatar'),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
