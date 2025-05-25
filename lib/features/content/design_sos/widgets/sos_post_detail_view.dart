import 'package:cached_network_image/cached_network_image.dart';
import 'package:designhub/features/socials/chat/provider/chat_notifier.dart';
import 'package:designhub/features/content/posts/controller/post_controller.dart';
import 'package:designhub/features/content/posts/widgets/image_gallery_screen.dart';
import 'package:designhub/features/content/posts/widgets/section_avatar.dart';
import 'package:designhub/features/content/posts/widgets/section_icon.dart';
import 'package:designhub/features/content/posts/widgets/section_post_detail.dart';
import 'package:designhub/features/socials/profile/models/profile.dart';
import 'package:designhub/features/socials/profile/provider/current_profile_notifier.dart';
import 'package:designhub/features/socials/profile/provider/profile_notifier.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:designhub/features/content/posts/models/post.dart';
import 'package:provider/provider.dart';

class SosPostDetailView extends StatefulWidget {
  final Post post;
  final Profile profile;

  const SosPostDetailView({
    super.key,
    required this.post,
    required this.profile,
  });

  @override
  State<SosPostDetailView> createState() => _SosPostDetailViewState();
}

class _SosPostDetailViewState extends State<SosPostDetailView> {
  bool postIsClose = false;

  @override
  Widget build(BuildContext context) {
    final loginNotifier = context.watch<CurrentProfileNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
            child: Column(
              children: [
                if (widget.post.userId != loginNotifier.getProfileId())
                  _buildAvatarSection(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildIconSection(),
                    widget.post.userId != loginNotifier.getProfileId()
                        ? _buildSupportSection(context)
                        : _buildCloseSection(context),
                  ],
                ),
                _buildPostDetailSection(),
                if (widget.post.images.isNotEmpty) _buildImageGallery(context),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarSection(BuildContext context) =>
      SectionAvatar(post: widget.post, profile: widget.profile);

  _buildCloseSection(BuildContext context) => _sectionCollaboration(
      context,
      'Close',
      (widget.post.isActive
          ? () {
              setState(() {
                widget.post.isActive = false;
              });
              context.read<ProfileNotifier>().removeSosPost(widget.post.postId);
              context.read<PostController>().deletePost(widget.post.postId);
            }
          : null));

  _buildSupportSection(BuildContext context) =>
      _sectionCollaboration(context, 'Support', () {
        context.read<ChatNotifier>().openChat(context, widget.profile);
      });

  Widget _sectionCollaboration(
          BuildContext context, String textButton, Function? callback) =>
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
                onPressed: callback != null ? () => callback() : null,
                child: Text(textButton))
          ],
        ),
      );

  Widget _buildPostDetailSection() {
    return SectionPostDetail(post: widget.post);
  }

  Widget _buildIconSection() {
    return Expanded(
        child: SectionIcon(post: widget.post, profile: widget.profile));
  }

  Widget _buildImageGallery(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SizedBox(
        height: 600,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.post.images.length,
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
                    imageUrl: widget.post.images[index],
                    placeholder: (context, url) => Container(
                      color: DesignhubColors.white,
                    ),
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
          title: widget.post.title,
          images: widget.post.images,
          initialIndex: initialIndex,
        ),
      ),
    );
  }
}
