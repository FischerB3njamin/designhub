import 'package:designhub/features/socials/follow/controller/follow_controller.dart';
import 'package:designhub/features/socials/profile/models/profile.dart';
import 'package:designhub/theme/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionFollow extends StatefulWidget {
  final Profile profile;

  const SectionFollow({
    super.key,
    required this.profile,
  });

  @override
  State<SectionFollow> createState() => _SectionFollowState();
}

class _SectionFollowState extends State<SectionFollow> {
  bool isLoading = true;
  int numberOfFollowers = 0;

  @override
  void initState() {
    _loading();
    super.initState();
  }

  _loading() async {
    final result = await context
        .read<FollowController>()
        .getFollower(widget.profile.userId);
    if (result != null) {
      numberOfFollowers = result.followMe.length;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFollowInfoCard(
                  context, widget.profile.following.length, 'Follow'),
              _buildFollowInfoCard(context, numberOfFollowers, 'Follow me'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFollowInfoCard(BuildContext context, int count, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(count.toString(), style: CustomTextStyles.titleLarge(context)),
          Text(
            label,
            style: CustomTextStyles.bodyLargeBold(context, FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
