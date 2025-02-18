import 'package:designhub/features/auth/view/login_page.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  SectionHeader({super.key});
  final ProfileController profileController = ProfileController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: DesignhubColors.grey100),
      child: Row(
        children: [
          Assets.images.logo.image(height: 60, fit: BoxFit.fitWidth),
          Spacer(),
          IconButton(onPressed: () {}, icon: Assets.icons.search.svg()),
          IconButton(
            onPressed: () {
              profileController.logout();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
            icon: Assets.icons.logout.svg(),
          )
        ],
      ),
    );
  }
}
