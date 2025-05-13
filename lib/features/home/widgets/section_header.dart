import 'package:designhub/features/auth/provider/auth_notifier.dart';
import 'package:designhub/features/home/provider/home_notifier.dart';
import 'package:designhub/features/search/provider/search_motifer.dart';
import 'package:designhub/features/search/view/search_page.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/features/profile/provider/current_profile_notifier.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: DesignhubColors.grey100,
      child: Row(
        children: [
          Assets.images.logo.image(height: 40, fit: BoxFit.fitWidth),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.read<SearchNotifier>().init(
                      context.read<CurrentProfileNotifier>().getProfileId());
                });
                return SearchPage();
              }));
            },
            icon: Assets.icons.search.svg(),
          ),
          IconButton(
            onPressed: () {
              context.read<CurrentProfileNotifier>().logout();
              context.read<HomeNotifier>().resetUiState();
              context.read<AuthNotifier>().logout();
            },
            icon: Assets.icons.logout.svg(),
          ),
        ],
      ),
    );
  }
}
