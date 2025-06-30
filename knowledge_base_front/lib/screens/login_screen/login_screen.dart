import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knowledge_base_front/screens/login_screen/bloc/login_screen_bloc.dart';
import 'package:knowledge_base_front/screens/login_screen/bloc/login_screen_event.dart';
import 'package:knowledge_base_front/screens/login_screen/bloc/login_screen_state.dart';
import 'package:knowledge_base_front/screens/signup_screen/signup_screen.dart';
import 'package:knowledge_base_front/utils/app_theme.dart';
import 'package:knowledge_base_front/utils/strings.dart';
import 'package:knowledge_base_front/widget/button_widget.dart';
import 'package:knowledge_base_front/widget/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: const _LoginScreenBody(),
    );
  }
}

class _LoginScreenBody extends StatefulWidget {
  const _LoginScreenBody({super.key});

  @override
  State<_LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<_LoginScreenBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _onLoginPressed() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      context.read<LoginBloc>().add(LoginButtonPressed(
            email: email,
            password: password,
          ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email and password cannot be empty")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignupScreen()),
              );
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: Container(
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset('assets/images/doc_login_image.png', width: 200),
                    const SizedBox(height: 10),
                    const Text(
                      "Login Screen",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppStrings.weAreExcited,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTextField().primaryTextField(
                          context: context,
                          textEditingController: emailController,
                          hintText: "Email",
                        ),
                        const SizedBox(height: 10),
                        CustomTextField().primaryTextField(
                          context: context,
                          textEditingController: passwordController,
                          hintText: "Password",
                          obscureText: true,
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              print("Forget Password Link.");
                            },
                            child: const Text("Forgot Password?"),
                          ),
                        ),
                        const SizedBox(height: 20),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return CustomButton().primaryButton(
                              height: screenSize.height * 0.07,
                              width: screenSize.width * 0.2,
                              buttonText: state is LoginLoading
                                  ? "Logging in..."
                                  : "Login",
                              buttonBackgroundColor:
                                  AppTheme.primaryButtonBackgroundColor,
                              buttonTextColor: AppTheme.primaryButtonTextColor,
                              onPressed:
                                  state is LoginLoading ? null : _onLoginPressed,
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(AppStrings.dontHaveAnAccount),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupScreen()),
                                );
                              },
                              child: Text(
                                AppStrings.signup,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}