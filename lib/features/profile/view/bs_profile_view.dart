import 'package:designhub/features/profile/data/profile_mock_database.dart';
import 'package:designhub/features/profile/view/profile_page.dart';
import 'package:flutter/material.dart';

class BsProfileView extends StatelessWidget {
  final String profileId;

  const BsProfileView({
    super.key,
    required this.profileId,
  });

  @override
  Widget build(BuildContext context) {
    ProfileMockDatabase db = ProfileMockDatabase();

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
      padding: EdgeInsets.only(
        top: 0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: FractionallySizedBox(
        heightFactor: 0.9,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: SizedBox(
            child: ProfilePage(profile: db.getProfile(profileId)),
          ),
        ),
      ),
    );
  }
}
