import 'package:designhub/features/profile/provider/profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SosHistory extends StatelessWidget {
  const SosHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final profilNotifier = context.watch<ProfileNotifier>();
    return Column(
      children: [...profilNotifier.getPostWidgetsByProfile()],
    );
  }
}
