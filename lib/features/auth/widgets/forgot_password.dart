import 'package:designhub/features/auth/widgets/reset_password.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 0,
      children: [
        Text("Forgot your password? "),
        GestureDetector(
          onTap: () {
            CustomBottomSheet.show(context, ResetPassword(), 1);
          },
          child: Text(
            "click here ",
            style: TextStyle(color: DesignhubColors.primary),
          ),
        ),
        Text("to reset it.")
      ],
    );
  }
}
