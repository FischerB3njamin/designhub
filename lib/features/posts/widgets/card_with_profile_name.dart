import 'package:designhub/features/posts/view/post_detail_view.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class CardWithProfileName extends StatefulWidget {
  final Post post;
  final Function callback;
  final Profile profile;
  const CardWithProfileName({
    super.key,
    required this.post,
    required this.callback,
    required this.profile,
  });

  @override
  State<CardWithProfileName> createState() => _CardWithProfileNameState();
}

class _CardWithProfileNameState extends State<CardWithProfileName> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await CustomBottomSheet.showAsync(
            context,
            PostDetailView(
              post: widget.post,
              profile: widget.profile,
            ),
            0.9);
        widget.callback();
      },
      child: SizedBox.expand(
        child: Card(
          // ... (der Rest des Widget-Codes)
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(24)),
                  ),
                  child: Image.network(
                    widget.post.images.first,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(16)),
                    color: DesignhubColors.white,
                  ),
                  child: Row(
                    children: [
                      AvatarCircle(
                          profile: widget.profile, height: 40, width: 40),
                      SizedBox(width: 8),
                      Text(
                        widget.profile.name,
                        style: TextTheme.of(context).bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
