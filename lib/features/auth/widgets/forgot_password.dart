import 'package:designhub/features/auth/controller/auth_controller.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  final AuthController authController;
  const ForgotPassword({super.key, required this.authController});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 0,
      children: [
        Text("Forgot your password? "),
        GestureDetector(
          onTap: () {
            CustomBottomSheet.show(
                context,
                ResetPassword(
                  authController: authController,
                ),
                1);
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

class ResetPassword extends StatefulWidget {
  final AuthController authController;
  const ResetPassword({super.key, required this.authController});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String mail = "";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          Text(
            "Reset Password",
            style: TextTheme.of(context)
                .headlineLarge!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Text("Enter your mail address",
              style: TextTheme.of(context).bodyLarge!),
          TextField(
            onChanged: (value) => setState(() => mail = value),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 32,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('cancel'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    padding: WidgetStateProperty.all(EdgeInsets.all(8))),
                onPressed: () async {
                  if (mail.isNotEmpty) {
                    await widget.authController.resetPassword(mail);
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'You got an email with the link to reset your password.'),
                        ),
                      );

                      Navigator.of(context).pop();
                    }
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 32),
                  child: Text(
                    "Reset password",
                    style: TextTheme.of(context).bodyLarge!.copyWith(
                        color: DesignhubColors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
