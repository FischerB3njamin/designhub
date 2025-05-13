import 'package:cached_network_image/cached_network_image.dart';
import 'package:designhub/features/posts/controller/post_controller.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/view/post_detail_view.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/provider/profile_notifier.dart';
import 'package:designhub/features/profile/provider/current_profile_notifier.dart';
import 'package:designhub/theme/custom_text_styles.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardWithTitle extends StatelessWidget {
  final Post post;
  final Profile profile;

  const CardWithTitle({
    super.key,
    required this.post,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToPostDetail(context),
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          children: [
            _buildPostImage(),
            _buildPostTitle(context),
            _buildDeleteButton(context),
          ],
        ),
      ),
    );
  }

  void _navigateToPostDetail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PostDetailView(
          post: post,
          profile: profile,
        ),
      ),
    );
  }

  Widget _buildPostImage() {
    return Positioned.fill(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: post.images.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: post.images.first,
                placeholder: (context, url) => Container(
                  color: DesignhubColors.white,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              )
            : Container(color: DesignhubColors.white),
      ),
    );
  }

  Positioned _buildPostTitle(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 40,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          color: DesignhubColors.white,
        ),
        child: Text(
          post.title,
          overflow: TextOverflow.clip,
          style: CustomTextStyles.bodyMedium(context),
        ),
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    if (profile.userId !=
        context.read<CurrentProfileNotifier>().getProfileId()) {
      return SizedBox.shrink();
    }

    return Positioned(
      right: -8,
      top: -8,
      child: IconButton(
        onPressed: () => _showDeleteDialog(context),
        icon: const Icon(Icons.delete),
      ),
    );
  }

  Future<void> _showDeleteDialog(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content:
            Text("Do you really want to delete this post? (${post.title})"),
        actions: [
          TextButton(
            onPressed: () async {
              await context.read<PostController>().deletePost(post.postId);
              if (context.mounted) {
                context.read<ProfileNotifier>().removePost(post.postId);
                Navigator.pop(context, true);
              }
            },
            child: const Text("Delete"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
