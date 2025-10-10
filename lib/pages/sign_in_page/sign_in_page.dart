import 'package:alex_messenger/pages/sign_up_page/sign_up_page.dart';
import 'package:alex_messenger/services/auth_services/auth_service.dart';
import 'package:flutter/material.dart';

import '../main_page/main_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  // Future<void> _signIn() async {
  //   try {
  //     await AuthService.signIn(
  //       _emailController.text.trim(),
  //       _passwordController.text.trim(),
  //     );
  //     Navigator.of(context).pushNamedAndRemoveUntil(
  //       '/main',
  //       (route) => false, // видаляє всі попередні сторінки
  //     );
  //   } catch (e) {
  //     _showErrorDialog(e.toString().replaceFirst('Exception: ', ''));
  //   }
  // }
  //
  // void _showErrorDialog(String message) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Помилка'),
  //       content: Text(message),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(),
  //           child: const Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 160),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 40),
                ),
                Text(
                  'Please sign up to continue',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 48),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'EMAIL',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    prefixIcon: Icon(Icons.email_outlined),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12, width: 1.8),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'PASSWORD',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    prefixIcon: Icon(Icons.lock_outline),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12, width: 1.8),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.blueAccent,
                            Colors.lightBlue,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.57),
                            //shadow for button
                            blurRadius: 5,
                          ), //blur radius of shadow
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          final user = await AuthService.signIn(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );

                          if (user != null) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              '/main',
                              (route) =>
                                  false, // видаляє всі попередні сторінки
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "LOGIN",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 16),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 196),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blueAccent,
                      ),
                      child: Text(
                        'Sign up',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
