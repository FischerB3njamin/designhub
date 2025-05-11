import 'package:cached_network_image/cached_network_image.dart';
import 'package:designhub/features/chat/provider/chat_notifier.dart';
import 'package:designhub/features/posts/controller/post_controller.dart';
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

class SosPostDetailView extends StatelessWidget {
  final Post post;
  final Profile profile;

  const SosPostDetailView({
    super.key,
    required this.post,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final loginNotifier = context.read<CurrentProfileNotifier>();

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
                if (post.userId != loginNotifier.getProfileId())
                  _buildAvatarSection(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildIconSection(),
                    post.userId != loginNotifier.getProfileId()
                        ? _buildSupportSection(context)
                        : _buildCloseSection(context),
                  ],
                ),
                _buildPostDetailSection(),
                if (post.images.isNotEmpty) _buildImageGallery(context),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startChat() {}
  void closePost() {}

  Widget _buildAvatarSection(BuildContext context) =>
      SectionAvatar(post: post, profile: profile);

  _buildCloseSection(BuildContext context) => _sectionCollaboration(context,
      'Close', () => context.read<PostController>().deletePost(post.postId));

  _buildSupportSection(BuildContext context) =>
      _sectionCollaboration(context, 'Support', () {
        context.read<ChatNotifier>().openChat(context, profile);
      });

  Widget _sectionCollaboration(
          BuildContext context, String textButton, Function callback) =>
      Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 16),
        child: Row(
          children: [
            ElevatedButton(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                ),
                onPressed: () => callback(),
                child: Text(textButton))
          ],
        ),
      );

  Widget _buildPostDetailSection() {
    return SectionPostDetail(post: post);
  }

  Widget _buildIconSection() {
    return Expanded(child: SectionIcon(post: post, profile: profile));
  }

  Widget _buildImageGallery(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SizedBox(
        height: 600,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: post.images.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _openImageGallery(context, index),
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: DesignhubColors.black,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: post.images[index],
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    width: MediaQuery.of(context).size.width - 32 > 400
                        ? 400
                        : MediaQuery.of(context).size.width - 32,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            );
          },
        ),
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
