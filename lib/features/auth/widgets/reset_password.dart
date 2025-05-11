import 'package:designhub/features/auth/provider/auth_notifier.dart';
import 'package:designhub/theme/custom_text_styles.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

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
        children: [
          _buildTitle(context),
          const SizedBox(height: 8),
          _buildSubtitle(context),
          _buildEmailField(),
          const SizedBox(height: 16),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      "Reset Password",
      style: TextTheme.of(context)
          .headlineLarge!
          .copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      "Enter your mail address",
      style: CustomTextStyles.bodyLarge(context),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      onChanged: (value) => setState(() => mail = value),
      decoration: const InputDecoration(
        labelText: 'Email Address',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildCancelButton(context),
        const SizedBox(width: 16),
        _buildResetButton(context),
      ],
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text('Cancel'),
    );
  }

  Widget _buildResetButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          padding: WidgetStateProperty.all(const EdgeInsets.all(8))),
      onPressed: () async {
        if (mail.isNotEmpty) {
          await context.read<AuthNotifier>().resetPassword(mail);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'You got an email with the link to reset your password.'),
              ),
            );
            if (context.mounted) Navigator.of(context).pop();
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 32),
        child: Text(
          "Reset password",
          style: CustomTextStyles.bodyLargeColorBold(
              context, DesignhubColors.white, FontWeight.normal),
        ),
      ),
    );
  }
}
