import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  const SocialButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.onPressed});

  final AssetGenImage icon;
  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        side: WidgetStateProperty.all(
            BorderSide(color: DesignhubColors.primary, width: 2)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      onPressed: () {
        onPressed();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26),
        child: Row(
          children: [
            icon.image(width: 30, height: 30),
            SizedBox(width: 8),
            Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: DesignhubColors.black))
          ],
        ),
      ),
    );
  }
}
