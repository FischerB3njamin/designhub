import 'package:cached_network_image/cached_network_image.dart';
import 'package:designhub/features/posts/widgets/image_gallery_screen.dart';
import 'package:designhub/features/posts/widgets/section_avatar.dart';
import 'package:designhub/features/posts/widgets/section_icon.dart';
import 'package:designhub/features/posts/widgets/section_post_detail.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/provider/current_profile_notifier.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:provider/provider.dart';

class PostDetailView extends StatelessWidget {
  final Post post;
  final Profile profile;

  const PostDetailView({
    super.key,
    required this.post,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
            child: Column(
              children: [
                if (profile.userId !=
                    context.read<CurrentProfileNotifier>().getProfileId())
                  _buildAvatarSection(),
                _buildIconSection(),
                _buildPostDetailSection(),
                SizedBox(height: 16),
                if (post.images.isNotEmpty) _buildImageGallery(context),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarSection() {
    return SectionAvatar(post: post, profile: profile);
  }

  Widget _buildPostDetailSection() {
    return SectionPostDetail(post: post);
  }

  Widget _buildIconSection() {
    return SectionIcon(post: post, profile: profile);
  }

  Widget _buildImageGallery(BuildContext context) {
    return SizedBox(
      height: 600,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: post.images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _openImageGallery(context, index),
            child: Padding(
              padding: index == 0
                  ? const EdgeInsets.only(
                      top: 8.0, right: 8, left: 0, bottom: 8)
                  : const EdgeInsets.all(8.0),
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(32)),
                child: CachedNetworkImage(
                  imageUrl: post.images[index],
                  placeholder: (context, url) => Container(
                    color: DesignhubColors.white,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  width: MediaQuery.of(context).size.width - 32,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _openImageGallery(BuildContext context, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageGalleryScreen(
          title: post.title,
          images: post.images,
          initialIndex: initialIndex,
        ),
      ),
    );
  }
}
