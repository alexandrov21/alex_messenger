import 'package:alex_messenger/pages/sign_up_page/sign_up_page.dart';
import 'package:alex_messenger/services/auth_services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/sign_in_page_bloc/sign_in_page_bloc.dart';
import '../../bloc/sign_in_page_bloc/sign_in_page_event.dart';
import '../../bloc/sign_in_page_bloc/sign_in_page_state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  // Future<void> _signIn() async {
  //   final email = _emailController.text.trim();
  //   final password = _passwordController.text.trim();
  //
  //   if (email.isEmpty || password.isEmpty) {
  //     _showErrorDialog('Будь ласка, заповніть усі поля.');
  //     return;
  //   }
  //
  //   setState(() => _isLoading = true);
  //
  //   try {
  //     final user = await AuthService.signIn(email, password);
  //
  //     if (user != null) {
  //       Navigator.of(
  //         context,
  //       ).pushNamedAndRemoveUntil('/main', (route) => false);
  //     }
  //   } catch (e) {
  //     // 🔹 Показуємо AlertDialog із помилкою
  //     _showErrorDialog(e.toString().replaceFirst('Exception: ', ''));
  //   } finally {
  //     setState(() => _isLoading = false);
  //   }
  // }
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Помилка',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK', style: TextStyle(color: Colors.blueAccent)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // 🧹 Звільняємо ресурси контролерів
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInPageBloc, SignInPageState>(
      listener: (context, state) {
        if (state is SignInPageLoadingState) {
          // loading
        } else if (state is SignInPageErrorState) {
          _showErrorDialog(state.errorMessage);
        } else if (state is SignInPageSuccessState) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/main',
            (route) => false,
            arguments: state.user,
          );
        }
      },
      child: Scaffold(
        body: ListView(
          children: [
            const SizedBox(height: 160),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: _buildLoginInfo(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginInfo() {
    return Column(
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
        _buildEmailTextField(),
        SizedBox(height: 20),
        _buildPasswordTextField(),
        SizedBox(height: 40),
        _buildLoginButton(),
        SizedBox(height: 196),
        _buildDontHaveAccount(),
      ],
    );
  }

  Widget _buildEmailTextField() {
    return TextField(
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
    );
  }

  Widget _buildPasswordTextField() {
    return TextField(
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
    );
  }

  Widget _buildLoginButton() {
    return BlocBuilder<SignInPageBloc, SignInPageState>(
      builder: (BuildContext context, SignInPageState state) {
        final isLoading = state is SignInPageLoadingState;

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.blueAccent, Colors.lightBlue],
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
                onPressed: isLoading
                    ? null
                    : () {
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        context.read<SignInPageBloc>().add(
                          CheckingUserInfoEvent(
                            enteringEmail: email,
                            enteringPassword: password,
                          ),
                        );
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
                child: isLoading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Row(
                        children: [
                          Text("LOGIN", style: TextStyle(color: Colors.white)),
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
        );
      },
    );
  }

  Widget _buildDontHaveAccount() {
    return Row(
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
          style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
          child: Text('Sign up', style: TextStyle(fontWeight: FontWeight.w800)),
        ),
      ],
    );
  }
}
