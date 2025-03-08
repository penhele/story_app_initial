import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../model/story/story.dart';

class StoryListWidget extends StatelessWidget {
  final Story story;
  final Function() onTap;

  const StoryListWidget({super.key, required this.story, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Row(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 60,
                minHeight: 60,
                maxWidth: 80,
                minWidth: 80,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Hero(
                  tag: story.photoUrl,
                  child: _buildImage(story.photoUrl),
                ),
              ),
            ),
            const SizedBox.square(dimension: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    story.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox.square(dimension: 6),
                  Text(
                    story.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
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
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }
  }
}
