import 'package:designhub/features/socials/profile/provider/profile_notifier.dart';
import 'package:designhub/features/socials/profile/provider/current_profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BtnSgProfileSections extends StatelessWidget {
  final String selectedTab;
  final String profileId;

  const BtnSgProfileSections({
    super.key,
    required this.selectedTab,
    required this.profileId,
  });

  @override
  Widget build(BuildContext context) {
    bool ownProfile =
        context.read<CurrentProfileNotifier>().getProfileId() == profileId;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SegmentedButton(
        showSelectedIcon: false,
        onSelectionChanged: (newSelection) =>
            context.read<ProfileNotifier>().changePage(newSelection),
        emptySelectionAllowed: true,
        selected: {selectedTab},
        segments: [
          ButtonSegment(
            value: "Info",
            label: Text("Info"),
          ),
          ButtonSegment(
            value: "Work",
            label: Text("Work"),
          ),
          if (ownProfile)
            ButtonSegment(
              value: "Saved",
              label: Text("Saved"),
            ),
          if (ownProfile)
            ButtonSegment(
              value: "SOS",
              label: Text("SOS"),
            ),
        ],
      ),
    );
  }
}
