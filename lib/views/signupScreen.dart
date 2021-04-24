import 'package:btw_test_app/utils/passwordCard.dart';
import 'package:btw_test_app/utils/phoneCard.dart';
import 'package:btw_test_app/utils/textCard.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController name;
  TextEditingController phone;
  TextEditingController password;
  TextEditingController referralCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 300,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextCard(
                hintText: 'name',
                controller: name,
                prefixIcon: Icons.person,
              ),
              PhoneCard(controller: phone),
              PasswordCard(controller: password),
              TextCard(
                hintText: 'Refferal Code',
                controller: referralCode,
                prefixIcon: Icons.person,
                suffixIcon: Icons.info_outline,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () async {
                    // print('>>>>>>>>>>>>>>>>>>>>>>>>>>>mail, pass ${[
                    //   phoneField.text,
                    //   _passwordField.text
                    // ]}');
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.pink),
                    alignment: Alignment.center,
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'OR',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () async {
                    // showAlertDialog(context,
                    //     title: 'Connection Error',
                    //     content: 'error in connecting to Facebook');
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.blueAccent),
                    alignment: Alignment.center,
                    child: Text(
                      'IMPORT FROM FACEBOOK',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(
                            color: Colors.pink,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                ' By clicking signup,',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'you agree our ',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'TERMS AND CONDITIONS',
                      style: TextStyle(
                          color: Colors.pink,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
