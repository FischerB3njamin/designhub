import 'package:designhub/features/follow/controller/follow_controller.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class BtnFollow extends StatefulWidget {
  final String profilId;
  const BtnFollow({super.key, required this.profilId});

  @override
  State<BtnFollow> createState() => _BtnFollowState();
}

class _BtnFollowState extends State<BtnFollow> {
  final controller = FollowController();
  final profilController = ProfileController();
  bool isFollower = false;
  Widget follow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
      child: ElevatedButton(
        style: ButtonStyle(
            minimumSize: WidgetStateProperty.all(Size(120, 35)),
            padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: 12, vertical: 4))),
        onPressed: () async {
          await controller.addFollow(
              profilController.getCurrentProfile().userId, widget.profilId);
          setState(() {
            isFollower = true;
          });
        },
        child: Text(
          'Follow',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget unFollow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
      child: TextButton(
        style: ButtonStyle(
            minimumSize: WidgetStateProperty.all(Size(80, 30)),
            backgroundColor: WidgetStateProperty.all(DesignhubColors.white)),
        onPressed: () {
          controller.removeFollow(
            profilController.getCurrentProfile().userId,
            widget.profilId,
          );
          setState(() {
            isFollower = false;
          });
        },
        child: Text(
          'Unfollow',
          style: TextStyle(
            color: DesignhubColors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _load();
    super.initState();
  }

  void _load() async {
    final result = await controller.isFollow(
        profilController.getCurrentProfile().userId, widget.profilId);
    setState(() {
      isFollower = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isFollower ? unFollow() : follow();
  }
}
