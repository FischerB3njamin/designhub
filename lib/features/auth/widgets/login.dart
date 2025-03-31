import 'package:designhub/features/auth/controller/auth_controller.dart';
import 'package:designhub/features/auth/view/registration_page.dart';
import 'package:designhub/features/auth/widgets/forgot_password.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/shared/controller/validation_controller.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final AuthController authController;

  const Login({
    super.key,
    required this.authController,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? errorText;
  bool logginIsRunning = false;
  bool hidePasswort = true;
  final _formKey = GlobalKey<FormState>();
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

    final error = await widget.authController.login(
      emailController.text,
      pwdController.text,
    );

    if (error != null) {
      setState(() {
        errorText = error;
        logginIsRunning = false;
      });
    }
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
                  obscureText: hidePasswort,
                  controller: pwdController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                DesignhubColors.transparent),
                            shadowColor: WidgetStateProperty.all(
                                DesignhubColors.transparent)),
                        onPressed: () =>
                            setState(() => hidePasswort = !hidePasswort),
                        icon: Icon(hidePasswort
                            ? Icons.visibility_off
                            : Icons.visibility)),
                    labelText: 'Password',
                  ),
                  validator: ValidationController.validatePassword,
                ),
              ],
            ),
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                errorText!,
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
                onPressed: () =>
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => RegistrationPage(
                              authController: widget.authController,
                            ))),
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
          ForgotPassword(authController: widget.authController),
        ],
      ),
    );
  }
}
