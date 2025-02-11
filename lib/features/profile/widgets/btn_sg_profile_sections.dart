import 'package:designhub/features/profile/models/profile_singleton.dart';
import 'package:flutter/material.dart';

class BtnSgProfileSections extends StatelessWidget {
  final Function callback;
  final String selectedTab;
  final String profileId;

  const BtnSgProfileSections({
    super.key,
    required this.callback,
    required this.selectedTab,
    required this.profileId,
  });

  @override
  Widget build(BuildContext context) {
    bool ownProfile = ProfileSingleton().profile?.userId == profileId;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SegmentedButton(
        showSelectedIcon: false,
        onSelectionChanged: (newSelection) => callback(newSelection),
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
    );
  }
}
