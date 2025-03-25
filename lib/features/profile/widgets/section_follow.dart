import 'package:designhub/features/follow/controller/follow_controller.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

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
  int counterFollower = 0;
  int counterFollowMe = 0;

  final followController = FollowController();

  @override
  void initState() {
    _load();
    super.initState();
  }

  void _load() async {
    counterFollower = await followController.countFollow(widget.profile.userId);
    counterFollowMe =
        await followController.countFollowMe(widget.profile.userId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Row(
          spacing: 48,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: DesignhubColors.grey100,
                  border: Border.all(color: DesignhubColors.black26, width: 3),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Text(counterFollower.toString()),
                    Text(
                      'Follow',
                      style: TextTheme.of(context)
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: DesignhubColors.grey100,
                  border: Border.all(color: DesignhubColors.black26, width: 3),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Text(counterFollowMe.toString()),
                    Text(
                      'Follow me ',
                      style: TextTheme.of(context)
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 16)
    ]);
  }
}
