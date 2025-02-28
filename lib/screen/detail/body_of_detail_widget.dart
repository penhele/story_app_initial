import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../model/story.dart';

class BodyOfDetailWidget extends StatelessWidget {
  final Story story;

  const BodyOfDetailWidget({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Hero(
                tag: story.photoUrl,
                child: _buildImage(story.photoUrl),
              ),
            ),
            const SizedBox.square(dimension: 12),
            Text(story.name, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox.square(dimension: 6),
            Text(
              story.description,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    if (imageUrl.endsWith('.svg')) {
      return SvgPicture.network(
        imageUrl,
        width: 50,
        height: 50,
        placeholderBuilder: (context) => CircularProgressIndicator(),
      );
    } else {
      return Image.network(
        imageUrl,
        width: 150,
        height: 150,
        fit: BoxFit.cover,
        errorBuilder:
            (context, error, stackTrace) => Icon(Icons.image_not_supported),
      );
    }
  }
}
