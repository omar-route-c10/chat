import 'package:chat/auth/view/screens/register_screen.dart';
import 'package:chat/auth/view/widgets/default_elevated_button.dart';
import 'package:chat/auth/view/widgets/default_text_form_field.dart';
import 'package:chat/auth/view_model/auth_states.dart';
import 'package:chat/shared/app_theme.dart';
import 'package:chat/shared/app_validator.dart';
import 'package:chat/shared/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/auth/view_model/auth_view_model.dart';
import 'package:chat/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back!',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                DefaultTextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email can not be empty';
                    } else if (!AppValidator.isEmail(value)) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                  labelText: 'Email',
                ),
                DefaultTextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password can not be empty';
                    } else if (value.length < 6) {
                      return 'Should be at least 6 characters';
                    }
                    return null;
                  },
                  labelText: 'Password',
                  isPassword: true,
                ),
                const SizedBox(height: 16),
                BlocListener<AuthViewModel, AuthState>(
                  listener: (_, state) {
                    if (state is LoginLoading) {
                      UIUtils.showLoading(context);
                    } else if (state is LoginSuccess) {
                      UIUtils.hideLoading(context);
                      Navigator.of(context)
                          .pushReplacementNamed(HomeScreen.routeName);
                    } else if (state is LoginError) {
                      UIUtils.hideLoading(context);
                      UIUtils.showMessage(state.message);
                    }
                  },
                  child: DefaultElevatedButton(
                    onPressed: login,
                    child: Row(
                      children: [
                        const Spacer(),
                        Text(
                          'Login',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.whiteColor,
                                    fontSize: 14,
                                  ),
                        ),
                        const Spacer(flex: 8),
                        const Icon(
                          Icons.arrow_forward,
                          color: AppTheme.whiteColor,
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed(RegisterScreen.routeName),
                  child: const Text('Or Create My Account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState?.validate() == true) {
      BlocProvider.of<AuthViewModel>(context).login(
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }
}
