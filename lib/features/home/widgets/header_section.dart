import 'package:designhub/features/auth/view/login_page.dart';
import 'package:designhub/features/profile/models/profile_singleton.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

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
              ProfileSingleton().logout();
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
