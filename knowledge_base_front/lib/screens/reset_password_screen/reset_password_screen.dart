import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_base_front/utils/app_theme.dart';
import 'package:knowledge_base_front/widget/button_widget.dart';
import 'package:knowledge_base_front/widget/custom_textfield.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String token;

  const ResetPasswordScreen({super.key, required this.token});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool _isLoading = false;

  void _resetPassword() async {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmController.text.trim();

    if (password.isEmpty || confirmPassword.isEmpty) {
      _showMessage("Please fill all fields");
      return;
    }

    if (password != confirmPassword) {
      _showMessage("Passwords do not match");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final dio = Dio();
      final response = await dio.post(
        "http://192.168.137.137:8080/reset-password",
        data: jsonEncode({
          "token": widget.token,
          "newPassword": password,
        }),
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      _showMessage("Password changed successfully");
      Navigator.pop(context); // Go back to login
    } on DioException catch (e) {
      _showMessage(e.response?.data["message"] ?? "Failed to reset password");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
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
                    "Reset Password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Enter a new password to reset your account",
                    style: TextStyle(fontWeight: FontWeight.w500),
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
                        textEditingController: _passwordController,
                        hintText: "New Password",
                        obscureText: true,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField().primaryTextField(
                        context: context,
                        textEditingController: _confirmController,
                        hintText: "Confirm Password",
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      CustomButton().primaryButton(
                        height: size.height * 0.07,
                        width: size.width * 0.5,
                        buttonText:
                            _isLoading ? "Resetting..." : "Reset Password",
                        buttonBackgroundColor:
                            AppTheme.primaryButtonBackgroundColor,
                        buttonTextColor: AppTheme.primaryButtonTextColor,
                        onPressed: _isLoading ? null : _resetPassword,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
