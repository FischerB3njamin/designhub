import 'package:designhub/features/content/design_sos/widgets/sos_post_detail_view.dart';
import 'package:designhub/features/content/posts/models/post.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:designhub/features/socials/profile/models/profile.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:link_text/link_text.dart';

class SosPostCard extends StatelessWidget {
  final Profile profile;
  final Post post;

  const SosPostCard({
    super.key,
    required this.post,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      foregroundDecoration: BoxDecoration(
        color: post.isActive ? null : DesignhubColors.white.withAlpha(150),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: DesignhubColors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _onPostTapped(context),
          child: Card(
            color: DesignhubColors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 12),
                  _buildPostDetails(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onPostTapped(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SosPostDetailView(post: post, profile: profile),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AvatarCircle(profile: profile, height: 48, width: 48),
        const SizedBox(width: 12),
        Expanded(child: _buildProfileInfo(context)),
      ],
    );
  }

  Widget _buildProfileInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          profile.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: DesignhubColors.black87,
          ),
        ),
        Text(
          post.title,
          style: const TextStyle(
            fontSize: 16,
            color: Color.fromARGB(187, 0, 0, 0),
          ),
        ),
      ],
    );
  }

  Widget _buildPostDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        LinkText(
          post.description,
          textStyle: TextStyle(
            color: DesignhubColors.grey600,
            fontSize: 14,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}
