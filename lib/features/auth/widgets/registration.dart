import 'package:designhub/features/navigation/view/navigation_page.dart';
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
              filled: true,
              fillColor: Color.fromRGBO(0, 0, 0, .06),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  gapPadding: 16,
                  borderSide: BorderSide.none),
              hintText: 'Name',
            ),
          ),
          SizedBox(
            height: 8,
          ),
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Color.fromRGBO(0, 0, 0, .06),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  gapPadding: 16,
                  borderSide: BorderSide.none),
              hintText: 'Email',
            ),
          ),
          SizedBox(height: 8),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color.fromRGBO(0, 0, 0, .06),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  gapPadding: 16,
                  borderSide: BorderSide.none),
              hintText: 'Password',
            ),
          ),
          SizedBox(height: 8),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color.fromRGBO(0, 0, 0, .06),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  gapPadding: 16,
                  borderSide: BorderSide.none),
              hintText: 'Repeat Password',
            ),
          ),
          // SizedBox(height: 4),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
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
              backgroundColor: WidgetStateProperty.all<Color>(
                  Color.fromRGBO(242, 86, 25, 1)),
            ),
            onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => NavigationPage())),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                'Signup',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
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
