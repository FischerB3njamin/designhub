import 'package:designhub/features/auth/view/registration_page.dart';
import 'package:designhub/features/navigation/view/navigation_page.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: 'Email',
            ),
          ),
          SizedBox(
            height: 16,
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
            ),
          ),
          SizedBox(
            height: 16,
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                  Color.fromRGBO(242, 86, 25, 1)),
            ),
            onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => NavigationPage())),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
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
                    color: Color.fromRGBO(242, 86, 25, 1),
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
                style: TextStyle(color: Color.fromRGBO(242, 86, 25, 1)),
              ),
              Text("to reset it.")
            ],
          )
        ],
      ),
    );
  }
}
