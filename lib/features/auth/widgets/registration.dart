import 'package:designhub/features/auth/controller/auth_controller.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/shared/controller/validation_controller.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  final AuthController authController;
  const Registration({
    super.key,
    required this.authController,
  });

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String? errorMessage;
  bool hidePasswort = true;
  bool hideRepeatPasswort = true;
  bool termsAndConditions = false;
  bool registrationIsRunning = false;
  final _formKey = GlobalKey<FormState>();

  ProfileController profileController = ProfileController();
  TextEditingController mailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController repeatPwdController = TextEditingController();

  @override
  void dispose() {
    mailController.dispose();
    pwdController.dispose();
    repeatPwdController.dispose();
    super.dispose();
  }

  void handleSignup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => registrationIsRunning = true);

    final String mail = mailController.text;
    final String pwd = pwdController.text;
    final String repeatedPwd = repeatPwdController.text;

    if (pwd != repeatedPwd) {
      _setError("Password not identical");
      return;
    }

    errorMessage = await widget.authController.register(mail, pwd);
    setState(() {});
  }

  void _setError(String message) {
    setState(() {
      errorMessage = message;
      registrationIsRunning = false;
    });
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
              controller: mailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              validator: ValidationController.validateEmail,
            ),
            TextFormField(
              controller: pwdController,
              obscureText: hidePasswort,
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
            TextFormField(
              controller: repeatPwdController,
              obscureText: hideRepeatPasswort,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            DesignhubColors.transparent),
                        shadowColor: WidgetStateProperty.all(
                            DesignhubColors.transparent)),
                    onPressed: () => setState(
                        () => hideRepeatPasswort = !hideRepeatPasswort),
                    icon: Icon(hideRepeatPasswort
                        ? Icons.visibility_off
                        : Icons.visibility)),
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
            if (errorMessage != null)
              Text(
                errorMessage!,
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
