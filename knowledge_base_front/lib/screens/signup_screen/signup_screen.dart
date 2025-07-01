import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knowledge_base_front/screens/signup_screen/bloc/signup_screen_bloc.dart';
import 'package:knowledge_base_front/screens/signup_screen/bloc/signup_screen_event.dart';
import 'package:knowledge_base_front/screens/signup_screen/bloc/signup_screen_state.dart';
import 'package:knowledge_base_front/utils/app_theme.dart';
import 'package:knowledge_base_front/utils/strings.dart';
import 'package:knowledge_base_front/widget/button_widget.dart';
import 'package:knowledge_base_front/widget/custom_textfield.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupBloc(),
      child: const _SignupScreenBody(),
    );
  }
}

class _SignupScreenBody extends StatefulWidget {
  const _SignupScreenBody({super.key});

  @override
  State<_SignupScreenBody> createState() => _SignupScreenBodyState();
}

class _SignupScreenBodyState extends State<_SignupScreenBody> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _onSignupPressed() {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty) {
      context.read<SignupBloc>().add(SignupButtonPressed(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
          ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: BlocListener<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state is SignupSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Signup successful! Please log in.")),
              );
              Navigator.pop(context);
            } else if (state is SignupFailure) {
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
                    Image.asset('assets/images/doc_signup_image.png',
                        width: 200),
                    const SizedBox(height: 10),
                    const Text(
                      "Signup Screen",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppStrings.letsGetStarted,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTextField().primaryTextField(
                          context: context,
                          textEditingController: firstNameController,
                          hintText: "First Name",
                        ),
                        const SizedBox(height: 10),
                        CustomTextField().primaryTextField(
                          context: context,
                          textEditingController: lastNameController,
                          hintText: "Last Name",
                        ),
                        const SizedBox(height: 10),
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
                        const SizedBox(height: 20),
                        BlocBuilder<SignupBloc, SignupState>(
                          builder: (context, state) {
                            return CustomButton().primaryButton(
                              height: screenSize.height * 0.07,
                              width: screenSize.width * 0.2,
                              buttonText: state is SignupLoading
                                  ? "Signing up..."
                                  : "Signup",
                              buttonBackgroundColor:
                                  AppTheme.primaryButtonBackgroundColor,
                              buttonTextColor: AppTheme.primaryButtonTextColor,
                              onPressed: state is SignupLoading
                                  ? null
                                  : _onSignupPressed,
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(AppStrings.alreadyHaveAnAccount),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
