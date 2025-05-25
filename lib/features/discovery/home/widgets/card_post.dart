import 'package:cached_network_image/cached_network_image.dart';
import 'package:designhub/features/discovery/home/widgets/gradient_overlay.dart';
import 'package:designhub/features/discovery/home/widgets/post_footer.dart';
import 'package:designhub/features/content/posts/models/post.dart';
import 'package:designhub/features/content/posts/view/post_detail_view.dart';
import 'package:designhub/features/socials/profile/models/profile.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class CardPost extends StatelessWidget {
  final Post post;
  final Profile profile;

  const CardPost({super.key, required this.post, required this.profile});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PostDetailView(post: post, profile: profile),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.width * 1,
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(34),
              ),
            ),
            elevation: 5,
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                post.images.isEmpty
                    ? Container()
                    : CachedNetworkImage(
                        imageUrl: post.images.first,
                        placeholder: (context, url) => Container(
                          color: DesignhubColors.white,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                const Positioned.fill(
                  child: GradientOverlay(),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: PostFooter(profile: profile, post: post),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
