import 'package:flutter/material.dart';
import 'package:knowledge_base_front/screens/login_screen/login_screen.dart';
import 'package:knowledge_base_front/utils/app_theme.dart';
import 'package:knowledge_base_front/utils/strings.dart';
import 'package:knowledge_base_front/widget/button_widget.dart';
import 'package:knowledge_base_front/widget/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(children: [
              Image.asset(
                'assets/images/doc_signup_image.png',
                width: 200,
                height: 200,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Welcome to Signup Page",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                AppStrings.weAreExcited,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
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
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(height: 20),
                    CustomButton().primaryButton(
                      height: screenSize.height * 0.07,
                      width: screenSize.width * 0.2,
                      buttonText: "Signup",
                      buttonBackgroundColor:
                          AppTheme.primaryButtonBackgroundColor,
                      buttonTextColor: AppTheme.primaryButtonTextColor,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppStrings.haveAnAccount),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            AppStrings.login,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ))
            ])),
      ),
    );
  }
}
