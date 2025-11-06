import 'package:alex_messenger/pages/sign_in_page/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/sign_up_page_bloc/sign_up_page_bloc.dart';
import '../../bloc/sign_up_page_bloc/sign_up_page_event.dart';
import '../../bloc/sign_up_page_bloc/sign_up_page_state.dart';
import '../../services/auth_services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  //bool _isLoading = false;

  // Future<void> _signUp() async {
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
  //     final user = await AuthService.signUp(email, password);
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
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpPageBloc, SignUpPageState>(
      listener: (context, state) {
        if (state is SignUpPageLoadingState) {
          //loading
        } else if (state is SignUpPageErrorState) {
          _showErrorDialog(state.errorMessage);
        } else if (state is SignUpPageSuccessState) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/main', (route) => false);
        }
      },
      child: Scaffold(
        body: ListView(
          children: [
            SizedBox(height: 160),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: _buildCreateAccountInfo(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateAccountInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Create Account",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 40),
        ),
        SizedBox(height: 28),
        _buildFullNameTextField(),
        SizedBox(height: 20),
        _buildEmailTextField(),
        SizedBox(height: 20),
        _buildPasswordTextField(),
        SizedBox(height: 20),
        _buildConfirmPasswordTextField(),
        SizedBox(height: 40),
        _buildSignUpButton(),
        SizedBox(height: 100),
        _buildAlreadyHaveAccountButton(),
      ],
    );
  }

  Widget _buildFullNameTextField() {
    return TextField(
      controller: _fullNameController,
      decoration: InputDecoration(
        labelText: 'FULL NAME ',
        labelStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        prefixIcon: Icon(Icons.person_outlined),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12, width: 1.8),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
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

  Widget _buildConfirmPasswordTextField() {
    return TextField(
      controller: _confirmPasswordController,
      decoration: InputDecoration(
        labelText: 'CONFIRM PASSWORD',
        labelStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        prefixIcon: Icon(Icons.lock_reset_outlined),
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

  Widget _buildSignUpButton() {
    return BlocBuilder<SignUpPageBloc, SignUpPageState>(
      builder: (BuildContext context, SignUpPageState state) {
        final isLoading = state is SignUpPageLoadingState;

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
                        final fullName = _fullNameController.text;
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        final confirmPassword = _confirmPasswordController.text;
                        context.read<SignUpPageBloc>().add(
                          CheckingFullInfoEvent(
                            enteringEmail: email,
                            enteringPassword: password,
                            enteringFullName: fullName,
                            enteringConfirmPassword: confirmPassword,
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
                    : Row(
                        children: [
                          Text(
                            "SIGN UP",
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
        );
      },
    );
  }

  Widget _buildAlreadyHaveAccountButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
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
              MaterialPageRoute(builder: (context) => SignInPage()),
            );
          },
          style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
          child: Text('Sign in', style: TextStyle(fontWeight: FontWeight.w800)),
        ),
      ],
    );
  }
}
