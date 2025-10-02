import 'package:alex_messenger/pages/sign_in_page/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'pages/main_page/main_page.dart';
import 'pages/sign_up_page/sign_up_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/main': (context) => const SignInPage(),
        '/sign_up': (context) => const SignUpPage(),
        '/all_dialogs': (context) => const MainPage(),
      },
      initialRoute: 'main',
      home: const SignInPage(),
    );
  }
}
