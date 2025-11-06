import 'package:alex_messenger/bloc/sign_in_page_bloc/sign_in_page_bloc.dart';
import 'package:alex_messenger/bloc/sign_up_page_bloc/sign_up_page_bloc.dart';
import 'package:alex_messenger/pages/main_page/main_page.dart';
import 'package:alex_messenger/pages/settings_page/settings_page.dart';
import 'package:alex_messenger/pages/sign_in_page/sign_in_page.dart';
import 'package:alex_messenger/services/auth_services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/sign_up_page/sign_up_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SignInPageBloc()),
        BlocProvider(create: (_) => SignUpPageBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/sign_in': (context) => const SignInPage(),
          '/sign_up': (context) => const SignUpPage(),
          '/settings': (context) => SettingsPage(),
          '/main': (context) => MainPage(),
          //'/all_dialogs': (context) => const MainPage(),
        },
        //initialRoute: 'main',
        home: StreamBuilder<User?>(
          stream: AuthService.userChanges,
          builder: (context, snapshot) {
            print("Stream snapshot: ${snapshot.data}");
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }
            if (snapshot.hasData) {
              return MainPage();
            } else {
              return SignInPage();
            }
          },
        ),
      ),
    );
  }
}
