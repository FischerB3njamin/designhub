import 'package:designhub/features/auth/view/registration_page.dart';
import 'package:designhub/features/navigation/view/navigation_page.dart';
import 'package:designhub/features/profile/models/profile_singleton.dart';
import 'package:designhub/shared/controller/controller.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isError = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
            ),
          ),
          SizedBox(
            height: 16,
          ),
          TextField(
            obscureText: true,
            controller: pwdController,
            decoration: InputDecoration(
              labelText: 'Password',
            ),
          ),
          SizedBox(
            height: 16,
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
          TextButton(
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all<Color>(DesignhubColors.primary),
            ),
            onPressed: () {
              String userId = Controller()
                  .loginDB
                  .checkLogin(emailController.text, pwdController.text);
              if (userId.isNotEmpty) {
                ProfileSingleton().setProfile(userId);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => NavigationPage(),
                  ),
                );
              } else {
                setState(() {
                  isError = true;
                });
              }
            },
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
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("New to the app? ",
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
