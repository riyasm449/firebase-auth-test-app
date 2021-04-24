import 'package:btw_test_app/models/user.dart';
import 'package:btw_test_app/utils/passwordCard.dart';
import 'package:btw_test_app/utils/phoneCard.dart';
import 'package:btw_test_app/utils/textCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController referralCode = TextEditingController();
  bool isLoading = false;

  setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: (isLoading)
            ? Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.pink,
                ),
              )
            : SingleChildScrollView(
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
                    TextCard(
                      hintText: 'Mail ID',
                      controller: mail,
                      prefixIcon: Icons.mail,
                    ),
                    PasswordCard(controller: password),
                    TextCard(
                      hintText: 'Refferal Code',
                      controller: referralCode,
                      prefixIcon: Icons.person,
                      suffixIcon: Icons.info_outline,
                    ),
                    signUpButton(),
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
                        onTap: () async {},
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

  void clearForm() {
    name.clear();
    phone.clear();
    password.clear();
    mail.clear();
    referralCode.clear();
  }

  Widget signUpButton() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () async {
          UserModel user = UserModel(
            name: 'riyas', //name.text.trim(),
            mobile_no: '9361144746', //phone.text.trim(),
            email: 'riyas@gmail.com',
            password: 'password', //password.text.trim(),
            referal_id: null, //referralCode.text.trim(),
          );
          try {
            await register(UserModel().toJson(user));
          } catch (e) {
            print('>>>>>>>>>>>>>> error : $e');
          }
        },
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), color: Colors.pink),
          alignment: Alignment.center,
          child: Text(
            'SIGN UP',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  Future<void> register(Map<String, dynamic> user) async {
    print('>>>>>>>>>>>>>>>>> user: $user <<<<<<<<<<<<<<<<<<<<');

    /// checks whether the mail is empty ///
    if (name.text == '') {
      showAlertDialog(context, title: 'Incomplete', content: 'Name is Empty');
    }

    /// checks whether the phone is empty and valid ///
    else if (phone.text == '') {
      showAlertDialog(context,
          title: 'Incomplete', content: 'Phone number is empty or Invalid');
    }

    /// checks whether the mail is empty ///
    else if (mail.text == '') {
      showAlertDialog(context,
          title: 'Incomplete', content: 'Mail id is Empty');
    }

    /// checks whether the mail is valid ///
    else if (validateEmail(mail.text)) {
      showAlertDialog(context,
          title: 'Mail Id', content: 'Enter proper mail id');
    }

    /// checks whether the password is empty ///
    else if (password.text.trim() == '') {
      showAlertDialog(context,
          title: 'Incomplete', content: 'Password is empty');
    } else {
      setLoading(true);

      /// firebase login and Error handling ///
      try {
        /// creating user ///
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: mail.text.trim(), password: password.text.trim())
            .then((value) {
          _firestore.collection('users').doc(value.user.uid).set(user);
        });
        print('================> Success Login <===================');
        clearForm();
        Navigator.pushReplacementNamed(context, '/home');
        setLoading(false);
      } catch (e) {
        setLoading(false);

        /// user not found error ///
        if (e.code == 'email-already-in-use') {
          showAlertDialog(context,
              title: 'Registration Failed', content: 'Email Already in Use');
          print('================> User not found <===================');
        }

        /// wrong password error ///
        else if (e.code == 'wrong-password') {
          showAlertDialog(context,
              title: 'Login Failed', content: 'Wrong password');
          print('================> Wrong password <===================');
        }

        /// other errors ///
        else {
          showAlertDialog(context,
              title: 'Login Failed', content: 'Something went wrong');
          print('============> ${e} <============');
        }
      }
    }
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null)
      return true;
    else
      return false;
  }

  showAlertDialog(BuildContext context, {String title, String content}) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(color: Colors.red),
          ),
          content: Text(content),
          actions: [
            okButton,
          ],
        );
      },
    );
  }
}
