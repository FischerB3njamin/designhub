import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/models/profile_singleton.dart';
import 'package:designhub/features/profile/widgets/profile_info_view.dart';
import 'package:designhub/features/profile/widgets/profile_saved_view.dart';
import 'package:designhub/features/profile/widgets/profile_work_view.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final Profile profile;
  const ProfilePage({super.key, required this.profile});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Set<String> tabBar = {"Work", "Info", "Saved"};
  String selectedTab = "Info";

  @override
  Widget build(BuildContext context) {
    bool ownProfile =
        ProfileSingleton().profile?.userId == widget.profile.userId;

    Map pages = {
      'Work': ProfileWorkView(
        profile: widget.profile,
      ),
      'Info': ProfileInfoView(
        profile: widget.profile,
      ),
      'Saved': ProfileSavedView(
        profile: widget.profile,
      )
    };

    return ListView(
      children: [
        SizedBox(
          height: 275,
          width: double.infinity,
          child: Stack(
            children: [
              Image.network(
                widget.profile.backgroundImagePath,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 55),
                  width: 200,
                  height: 200,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Image.network(
                    widget.profile.avatarImagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ),
        Text(
          widget.profile.name,
          style: TextTheme.of(context)
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SegmentedButton(
            showSelectedIcon: false,
            onSelectionChanged: (newSelection) => setState(() {
              if (newSelection.isNotEmpty) {
                selectedTab = newSelection.first;
              }
            }),
            emptySelectionAllowed: true,
            selected: {selectedTab},
            segments: [
              ButtonSegment(
                value: "Work",
                label: Text("Work"),
              ),
              ButtonSegment(
                value: "Info",
                label: Text("Info"),
              ),
              if (ownProfile)
                ButtonSegment(
                  value: "Saved",
                  label: Text("Saved"),
                ),
            ],
          ),
        ),
        SizedBox(height: 16),
        pages[selectedTab]
      ],
    );
  }
}
