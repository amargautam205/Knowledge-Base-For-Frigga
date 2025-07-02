import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knowledge_base_front/screens/forgot_password_screen/bloc/forgot_password_screen_bloc.dart';
import 'package:knowledge_base_front/screens/forgot_password_screen/bloc/forgot_password_screen_event.dart';
import 'package:knowledge_base_front/screens/forgot_password_screen/bloc/forgot_password_screen_state.dart';
import 'package:knowledge_base_front/utils/app_theme.dart';
import 'package:knowledge_base_front/widget/button_widget.dart';
import 'package:knowledge_base_front/widget/custom_textfield.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordBloc(),
      child: const ForgotPasswordBody(),
    );
  }
}

class ForgotPasswordBody extends StatefulWidget {
  const ForgotPasswordBody({super.key});

  @override
  State<ForgotPasswordBody> createState() => _ForgotPasswordBodyState();
}

class _ForgotPasswordBodyState extends State<ForgotPasswordBody> {
  final TextEditingController emailController = TextEditingController();

  void _onSubmit() {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email cannot be empty")),
      );
      return;
    }

    context
        .read<ForgotPasswordBloc>()
        .add(ForgotPasswordSubmitted(email: email));
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text("Forgot Password")),
      body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Reset link sent to your email")),
            );
            Navigator.pop(context);
          } else if (state is ForgotPasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/doc_login_image.png', width: 200),
                  const SizedBox(height: 20),
                  const Text(
                    "Forget Password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField().primaryTextField(
                    context: context,
                    textEditingController: emailController,
                    hintText: "Email",
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                    builder: (context, state) {
                      return CustomButton().primaryButton(
                        height: screenSize.height * 0.07,
                        width: screenSize.width * 0.4,
                        buttonText: state is ForgotPasswordLoading
                            ? "Sending..."
                            : "Send Reset Link",
                        buttonBackgroundColor:
                            AppTheme.primaryButtonBackgroundColor,
                        buttonTextColor: AppTheme.primaryButtonTextColor,
                        onPressed:
                            state is ForgotPasswordLoading ? null : _onSubmit,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
