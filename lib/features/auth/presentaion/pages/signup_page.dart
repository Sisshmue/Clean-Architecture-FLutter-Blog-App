import 'package:blog_app_clean_architecture/core/theme/app_pallete.dart';
import 'package:blog_app_clean_architecture/features/auth/presentaion/bloc/auth_bloc.dart';
import 'package:blog_app_clean_architecture/features/auth/presentaion/pages/login_page.dart';
import 'package:blog_app_clean_architecture/features/auth/presentaion/widges/auth_field.dart';
import 'package:blog_app_clean_architecture/features/auth/presentaion/widges/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  static MaterialPageRoute<dynamic> route() =>
      MaterialPageRoute(builder: (context) => const SignupPage());

  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //formKey.currentState!.validate();
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign Up.',
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30),
                        AuthField(hintText: 'Name', controller: nameController),
                        SizedBox(height: 15),
                        AuthField(
                          hintText: 'Email',
                          controller: emailController,
                        ),
                        SizedBox(height: 15),
                        AuthField(
                          hintText: 'Password',
                          controller: passwordController,
                          isObscureText: true,
                        ),
                        SizedBox(height: 20),
                        AuthGradientButton(
                          buttonText: 'Sign up',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              print(nameController.text);
                              print(emailController.text);
                              print(passwordController.text);
                              context.read<AuthBloc>().add(
                                AuthSignUp(
                                  nameController.text,
                                  emailController.text,
                                  passwordController.text,
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, LoginPage.route());
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Already Have an account?  ',
                              style: Theme.of(context).textTheme.titleMedium,
                              children: [
                                TextSpan(
                                  text: 'Sign In',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: AppPallete.gradient2,
                                        fontWeight: FontWeight.bold,
                                      ),
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
            ),
          );
        },
      ),
    );
  }
}
