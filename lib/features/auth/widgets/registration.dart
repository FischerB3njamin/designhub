import 'package:designhub/features/navigation/view/navigation_page.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool termsAndConditions = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Name',
            ),
          ),
          SizedBox(
            height: 8,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Email',
            ),
          ),
          SizedBox(height: 8),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
            ),
          ),
          SizedBox(height: 8),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Repeat Password',
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: termsAndConditions,
                onChanged: (value) => setState(() {
                  termsAndConditions = value!;
                }),
              ),
              Text("I agree the terms and conditions")
            ],
          ),
          SizedBox(
            height: 24,
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all<Color>(DesignhubColors.primary),
            ),
            onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => NavigationPage())),
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
          SizedBox(height: 16)
        ],
      ),
    );
  }
}
