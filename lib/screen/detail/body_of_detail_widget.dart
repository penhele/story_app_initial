import 'package:cached_network_image/cached_network_image.dart';
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
      return CachedNetworkImage(
        imageUrl: imageUrl,
        progressIndicatorBuilder:
            (context, url, progress) =>
                CircularProgressIndicator(value: progress.progress),
        width: 150,
        height: 150,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }
  }
}
