import 'package:designhub/features/auth/controller/auth_controller.dart';
import 'package:designhub/features/auth/view/registration_page.dart';
import 'package:designhub/features/navigation/view/navigation_page.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/shared/controller/validation_controller.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isError = false;
  bool logginIsRunning = false;
  final _formKey = GlobalKey<FormState>();
  AuthController authController = AuthController();
  ProfileController profileController = ProfileController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  void navigation() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => logginIsRunning = true);

    final userId = await authController.checkLogin(
      emailController.text,
      pwdController.text,
    );

    if (userId.isNotEmpty) {
      await _navigateToHome(userId);
    } else {
      _showLoginError();
    }
  }

  Future<void> _navigateToHome(String userId) async {
    final profile = await profileController.getProfile(userId);
    profileController.setCurrentProfile(profile);

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavigationPage()),
      );
    }
  }

  void _showLoginError() {
    setState(() {
      isError = true;
      logginIsRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(35),
      child: Column(
        spacing: 0,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: ValidationController.validateEmail,
                ),
                TextFormField(
                  obscureText: true,
                  controller: pwdController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: ValidationController.validatePassword,
                ),
              ],
            ),
          ),
          if (isError)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Invalid login",
                style: TextTheme.of(context)
                    .bodyLarge!
                    .copyWith(color: DesignhubColors.red),
              ),
            ),
          SizedBox(height: 16),
          logginIsRunning
              ? CircularProgressIndicator()
              : ElevatedButton(
                  style: ButtonStyle(
                      padding: WidgetStateProperty.all(EdgeInsets.all(8))),
                  onPressed: navigation,
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: DesignhubColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 24),
                    ),
                  ),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("New to the app?",
                  style: TextStyle(fontWeight: FontWeight.w700)),
              TextButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => RegistrationPage())),
                child: Text(
                  "Sign up now",
                  style: TextStyle(
                    color: DesignhubColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Forgot your password? "),
              Text(
                "click here ",
                style: TextStyle(
                  color: DesignhubColors.primary,
                ),
              ),
              Text("to reset it."),
            ],
          )
        ],
      ),
    );
  }
}
