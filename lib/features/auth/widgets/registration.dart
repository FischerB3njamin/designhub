import 'package:designhub/features/auth/provider/auth_notifier.dart';
import 'package:designhub/shared/controller/validation_controller.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  final mailController = TextEditingController();
  final pwdController = TextEditingController();
  final repeatPwdController = TextEditingController();

  @override
  void dispose() {
    mailController.dispose();
    pwdController.dispose();
    repeatPwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = context.watch<AuthNotifier>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildEmailField(),
            const SizedBox(height: 8),
            _buildPasswordField(authNotifier),
            const SizedBox(height: 8),
            _buildRepeatPasswordField(authNotifier),
            const SizedBox(height: 8),
            _buildTermsCheckbox(authNotifier),
            if (authNotifier.hasError) _buildError(authNotifier),
            const SizedBox(height: 8),
            _buildSignupButton(authNotifier),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: mailController,
      decoration: const InputDecoration(labelText: 'Email'),
      validator: ValidationController.validateEmail,
    );
  }

  Widget _buildPasswordField(AuthNotifier authNotifier) {
    return TextFormField(
      controller: pwdController,
      obscureText: authNotifier.hidePasswort,
      decoration: InputDecoration(
        labelText: 'Password',
        suffixIcon: IconButton(
          style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all(DesignhubColors.transparent),
            shadowColor: WidgetStateProperty.all(DesignhubColors.transparent),
          ),
          onPressed: authNotifier.togglePasswort,
          icon: Icon(authNotifier.hidePasswort
              ? Icons.visibility_off
              : Icons.visibility),
        ),
      ),
      validator: ValidationController.validatePassword,
    );
  }

  Widget _buildRepeatPasswordField(AuthNotifier authNotifier) {
    return TextFormField(
      controller: repeatPwdController,
      obscureText: authNotifier.hideRepeatPasswort,
      decoration: InputDecoration(
        labelText: 'Repeat Password',
        suffixIcon: IconButton(
          style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all(DesignhubColors.transparent),
            shadowColor: WidgetStateProperty.all(DesignhubColors.transparent),
          ),
          onPressed: authNotifier.toggleRepeatedPasswort,
          icon: Icon(authNotifier.hideRepeatPasswort
              ? Icons.visibility_off
              : Icons.visibility),
        ),
      ),
      validator: ValidationController.validatePassword,
    );
  }

  Widget _buildTermsCheckbox(AuthNotifier authNotifier) {
    return Row(
      children: [
        Checkbox(
          activeColor: DesignhubColors.primary,
          value: authNotifier.termsAndConditions,
          onChanged: (value) =>
              authNotifier.toggleTermsAndConditions(value ?? false),
        ),
        const Expanded(
          child: Text(
            "I agree to the terms and conditions",
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildError(AuthNotifier authNotifier) {
    return Text(
      authNotifier.error!,
      style: TextTheme.of(context)
          .bodyLarge!
          .copyWith(color: DesignhubColors.red, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSignupButton(AuthNotifier authNotifier) {
    return authNotifier.isLoading
        ? const CircularProgressIndicator()
        : ElevatedButton(
            onPressed: authNotifier.termsAndConditions
                ? () => authNotifier.handleSignup(
                      _formKey,
                      mailController.text,
                      pwdController.text,
                      pwdController.text == repeatPwdController.text,
                    )
                : null,
            child: SizedBox(
              width: double.infinity,
              child: Text(
                'Signup',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: DesignhubColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          );
  }
}
