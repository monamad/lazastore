import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

class SafeSvgImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final String fallbackUrl;

  const SafeSvgImage({
    super.key,
    required this.imageUrl,
    this.width = 20,
    this.height = 20,
    required this.fallbackUrl,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _loadImage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: width,
              height: height,
              color: Colors.grey[300],
            ),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Image.network(
            fallbackUrl,
            width: width,
            height: height,
            fit: BoxFit.cover,
          );
        }

        return snapshot.data!;
      },
    );
  }

  Future<Widget> _loadImage() async {
    try {
      // Try to load and parse the SVG
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode != 200) {
        throw Exception('Failed to load SVG');
      }

      final svgString = response.body;

      // Validate basic SVG structure
      if (!svgString.contains('<svg')) {
        throw Exception('Invalid SVG structure');
      }

      // Try to create the SVG widget
      return SvgPicture.string(
        svgString,
        width: width,
        height: height,
        fit: BoxFit.contain,
        placeholderBuilder: (context) => Container(),
      );
    } catch (e) {
      print('SVG load error for URL $imageUrl: $e');
      return Image.network(
        fallbackUrl,
        fit: BoxFit.cover,
        width: width,
        height: height,
      );
    }
  }
}
