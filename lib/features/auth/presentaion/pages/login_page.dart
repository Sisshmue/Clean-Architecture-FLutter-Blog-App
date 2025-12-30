import 'package:blog_app_clean_architecture/core/commom/widgets/loader.dart';
import 'package:blog_app_clean_architecture/core/theme/app_pallete.dart';
import 'package:blog_app_clean_architecture/core/utils/show_snackbar.dart';
import 'package:blog_app_clean_architecture/features/auth/presentaion/bloc/auth_bloc.dart';
import 'package:blog_app_clean_architecture/features/auth/presentaion/pages/signup_page.dart';
import 'package:blog_app_clean_architecture/features/auth/presentaion/widges/auth_field.dart';
import 'package:blog_app_clean_architecture/features/auth/presentaion/widges/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static MaterialPageRoute<dynamic> route() =>
      MaterialPageRoute(builder: (context) => LoginPage());
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //formKey.currentState!.validate();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (BuildContext context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            }
          },
          builder: (BuildContext context, state) {
            if (state is AuthLoading) {
              return Loader();
            }
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign In.',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  AuthField(hintText: 'Email', controller: emailController),
                  SizedBox(height: 15),
                  AuthField(
                    hintText: 'Password',
                    controller: passwordController,
                    isObscureText: true,
                  ),
                  SizedBox(height: 20),
                  AuthGradientButton(
                    buttonText: 'Sign in',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthLogIn(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, SignupPage.route());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t Have an account?  ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Sign Up',
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
            );
          },
        ),
      ),
    );
  }
}
