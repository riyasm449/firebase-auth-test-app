import 'package:btw_test_app/providers/authProvider.dart';
import 'package:btw_test_app/providers/userProvider.dart';
import 'package:btw_test_app/views/homeScreen.dart';
import 'package:btw_test_app/views/loginScreen.dart';
import 'package:btw_test_app/views/signupScreen.dart';
import 'package:btw_test_app/views/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Vendor App',
          theme: ThemeData(),
          home: SplashScreen(),
          // home: LoginPage(),
          routes: <String, WidgetBuilder>{
            '/login': (BuildContext context) => LoginPage(),
            '/signup': (BuildContext context) => SignUpPage(),
            '/home': (BuildContext context) => HomePage(),
          }),
    );
  }
}
