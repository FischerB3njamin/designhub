import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/widgets/btn_sg_profile_sections.dart';
import 'package:designhub/features/profile/widgets/profile_info.dart';
import 'package:designhub/features/profile/widgets/section_profile_cards.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final Profile profile;

  const ProfilePage({
    super.key,
    required this.profile,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Set<String> tabBar = {"Work", "Info", "Saved"};
  String selectedTab = "Info";

  @override
  Widget build(BuildContext context) {
    Map pages = {
      'Work': SectionProfilCard(
        profile: widget.profile,
        type: "title",
      ),
      'Info': ProfileInfo(
        profile: widget.profile,
      ),
      'Saved': SectionProfilCard(
        profile: widget.profile,
        type: "name",
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
                errorBuilder: (context, error, stackTrace) =>
                    Assets.images.noImage.image(
                        height: 180, width: double.infinity, fit: BoxFit.fill),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 53.0),
                  child: AvatarCircle(
                    profilId: widget.profile.userId,
                    height: 200,
                    width: 200,
                    allowNavigation: false,
                  ),
                ),
              ),
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
        BtnSgProfileSections(
          callback: (value) => setState(() {
            if (value.isNotEmpty) selectedTab = value.first;
          }),
          selectedTab: selectedTab,
          profileId: widget.profile.userId,
        ),
        SizedBox(height: 16),
        pages[selectedTab]
      ],
    );
  }
}
