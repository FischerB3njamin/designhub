import 'package:designhub/features/auth/controller/auth_controller.dart';
import 'package:designhub/features/navigation/view/navigation_page.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool termsAndConditions = false;
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

  void handleSignup() {
    final String name = nameController.text;
    final String mail = mailController.text;
    final String pwd = pwdController.text;
    final String repeatedPwd = repeatPwdController.text;

    if (!authController.mailNotInDb(mail)) return;
    if (pwd != repeatedPwd) return;

    String userId = authController.addUser(name, mail, pwd);
    profileController.createProfile(name, userId);
    profileController.setCurrentProfile(userId);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => NavigationPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        spacing: 8,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Name',
            ),
          ),
          TextField(
            controller: mailController,
            decoration: InputDecoration(
              hintText: 'Email',
            ),
          ),
          TextField(
            controller: pwdController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
            ),
          ),
          TextField(
            obscureText: true,
            controller: repeatPwdController,
            decoration: InputDecoration(
              hintText: 'Repeat Password',
            ),
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
              Text("I agree the terms and conditions")
            ],
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all<Color>(DesignhubColors.primary),
            ),
            onPressed: () => handleSignup(),
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
          SizedBox(height: 4)
        ],
      ),
    );
  }
}
