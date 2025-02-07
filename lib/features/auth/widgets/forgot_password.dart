import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Forgot your password? "),
        Text(
          "click here ",
          style: TextStyle(color: DesignhubColors.primary),
        ),
        Text("to reset it.")
      ],
    );
  }
}
