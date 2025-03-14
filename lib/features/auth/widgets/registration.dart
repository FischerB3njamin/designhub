import 'package:designhub/features/auth/controller/auth_controller.dart';
import 'package:designhub/features/navigation/view/navigation_page.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/shared/controller/validation_controller.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String errorMessage = "";
  bool termsAndConditions = false;
  bool registrationIsRunning = false;
  final _formKey = GlobalKey<FormState>();

  AuthController authController = AuthController();
  ProfileController profileController = ProfileController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController repeatPwdController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    mailController.dispose();
    pwdController.dispose();
    repeatPwdController.dispose();
    super.dispose();
  }

  void handleSignup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => registrationIsRunning = true);

    final String name = nameController.text;
    final String mail = mailController.text;
    final String pwd = pwdController.text;
    final String repeatedPwd = repeatPwdController.text;

    if (pwd != repeatedPwd) {
      _setError("Password not identical");
      return;
    }

    await _registerUser(name, mail, pwd);
  }

  void _setError(String message) {
    setState(() {
      errorMessage = message;
      registrationIsRunning = false;
    });
  }

  Future<void> _registerUser(String name, String mail, String pwd) async {
    final String userId = await authController.addUser(name, mail, pwd);
    final Profile newProfile =
        await profileController.createProfile(name, userId);
    profileController.setCurrentProfile(newProfile);

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => NavigationPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Form(
        key: _formKey,
        child: Column(
          spacing: 8,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              validator: ValidationController.validateNotEmpty,
            ),
            TextFormField(
              controller: mailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              validator: ValidationController.validateEmail,
            ),
            TextFormField(
              controller: pwdController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              validator: ValidationController.validatePassword,
            ),
            TextFormField(
              controller: repeatPwdController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Repeat Password',
              ),
              validator: ValidationController.validatePassword,
            ),
            Row(
              children: [
                Checkbox(
                  activeColor: DesignhubColors.primary,
                  value: termsAndConditions,
                  onChanged: (value) => setState(() {
                    termsAndConditions = value!;
                  }),
                ),
                Text("I agree to the terms and conditions")
              ],
            ),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: TextTheme.of(context).bodyLarge!.copyWith(
                    color: DesignhubColors.red, fontWeight: FontWeight.bold),
              ),
            registrationIsRunning
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: termsAndConditions ? handleSignup : null,
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Signup',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: DesignhubColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
