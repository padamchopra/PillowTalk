import 'package:flutter/material.dart';
import 'package:pillowtalk/presentation/screens/auth/authentication_screen.dart';
import 'package:pillowtalk/presentation/screens/auth/landing_screen.dart';
import 'package:pillowtalk/presentation/screens/home/home_screen.dart';
import 'package:pillowtalk/presentation/screens/new_chat/new_chat_screen.dart';

enum Screens {
  landing,
  authentication,
  home,
  newChat
}

class MyRouter {
  String get initialRoute => Screens.landing.name;

  Map<String, WidgetBuilder> getRoutes(BuildContext context) {
    return {
      Screens.landing.name: (context) => const LandingScreen(),
      Screens.authentication.name: (context) => const AuthenticationScreen(),
      Screens.home.name: (context) => const HomeScreen(),
      Screens.newChat.name: (context) => const NewChatScreen(),
    };
  }
}
