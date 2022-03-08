import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_page/providers/user_provider.dart';
import 'package:instagram_page/responsive/mobile_screen_layout.dart';
import 'package:instagram_page/responsive/responsive.dart';
import 'package:instagram_page/responsive/web_screen_layout.dart';
import 'package:instagram_page/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAa92qUhBPRhZs2hBvWl4Q2mKKGTLD-VtI",
          projectId: "instagramapp-8f716",
          storageBucket: "instagramapp-8f716.appspot.com",
          messagingSenderId: "792440481173",
          appId: "1:792440481173:web:b1a934c6c497cdfe4d829c"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
