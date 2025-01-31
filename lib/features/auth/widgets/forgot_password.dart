import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Forgot your password? "),
        Text(
          "click here ",
          style: TextStyle(color: Color.fromRGBO(242, 86, 25, 1)),
        ),
        Text("to reset it.")
      ],
    );
  }
}
