import 'package:flutter/material.dart';
import 'package:nassignment/views/registrarionscreen_2.dart';
import 'package:nassignment/views/welcome_screen.dart';
import 'package:nassignment/views/login_screen.dart';
import 'package:nassignment/views/registration_screen.dart';

import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'views/registraion_screen1.dart';
import 'views/displaypage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: "root",
      theme: ThemeData.dark().copyWith(
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white, //<-- SEE HERE
              displayColor: Colors.white, //<-- SEE HERE
            ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        "/": (context) => WelcomeScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen1.id: (context) => RegistrationScreen1(),
        RegistrationScreen2.id: (context) => RegistrationScreen2(),
        ProfilePage.id: (context) => ProfilePage(),
      },
    );
  }
}
