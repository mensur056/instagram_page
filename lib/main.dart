import 'package:clone_instagram/responsive/mobile_screen_layout.dart';
import 'package:clone_instagram/responsive/responsive.dart';
import 'package:clone_instagram/responsive/web_screen_layout.dart';
import 'package:clone_instagram/screens/login_screen.dart';
import 'package:clone_instagram/screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyC60Ao4jgr5Z65YwZ9QawY4E1W4qSN2teY',
          appId: '1:797791219070:web:a02b5e5fe5b1536786972f',
          messagingSenderId: '797791219070',
          storageBucket: "myinstagramapp-114b9.appspot.com",
          projectId: 'myinstagramapp-114b9'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home:
      home: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const ResponsiveLayout(
                  webScreenLayout: WebScreenLayout(),
                  mobileScreenLayout: MobileScreenLayout());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  ('${snapshot.error}'),
                ),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          return const LoginScreen();
        },
        stream: FirebaseAuth.instance.authStateChanges(),
      ),
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      title: "Instagram",
      debugShowCheckedModeBanner: false,
    );
  }
}
