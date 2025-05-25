import 'package:designhub/features/core/auth/provider/auth_notifier.dart';
import 'package:designhub/features/core/auth/view/registration_page.dart';
import 'package:designhub/features/core/auth/widgets/forgot_password.dart';
import 'package:designhub/shared/controller/validation_controller.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final pwdController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = context.watch<AuthNotifier>();

    return Padding(
      padding: const EdgeInsets.all(35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildForm(authNotifier),
          if (authNotifier.hasError) _buildError(authNotifier),
          const SizedBox(height: 16),
          _buildLoginButton(authNotifier),
          _buildSignupRow(context),
          const ForgotPassword(),
        ],
      ),
    );
  }

  Widget _buildForm(AuthNotifier authNotifier) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildEmailField(),
          const SizedBox(height: 16),
          _buildPasswordField(authNotifier),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: emailController,
      decoration: const InputDecoration(labelText: 'Email'),
      validator: ValidationController.validateEmail,
    );
  }

  Widget _buildPasswordField(AuthNotifier authNotifier) {
    return TextFormField(
      obscureText: authNotifier.hidePasswort,
      controller: pwdController,
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

  Widget _buildError(AuthNotifier authNotifier) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        authNotifier.error!,
        style: TextTheme.of(context)
            .bodyLarge!
            .copyWith(color: DesignhubColors.red),
      ),
    );
  }

  Widget _buildLoginButton(AuthNotifier authNotifier) {
    return authNotifier.isLoading
        ? const CircularProgressIndicator()
        : ElevatedButton(
            style: ButtonStyle(
              padding: WidgetStateProperty.all(const EdgeInsets.all(8)),
            ),
            onPressed: () => authNotifier.handleLogin(
              _formKey,
              emailController.text,
              pwdController.text,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: DesignhubColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ),
          );
  }

  Widget _buildSignupRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("New to the app?",
            style: TextStyle(fontWeight: FontWeight.w700)),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const RegistrationPage()),
            );
          },
          child: Text(
            "Sign up now",
            style: TextStyle(
              color: DesignhubColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
