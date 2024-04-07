import 'package:chat/auth/view/screens/login_screen.dart';
import 'package:chat/auth/view_model/auth_states.dart';
import 'package:chat/auth/view_model/auth_view_model.dart';
import 'package:chat/home_screen.dart';
import 'package:chat/shared/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthViewModel>(context).getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthViewModel, AuthState>(
      listener: (_, state) {
        if (state is IsLoggedIn) {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        } else if (state is NotLoggedIn) {
          Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
        }
      },
      child: const Scaffold(
        body: LoadingIndicator(),
      ),
    );
  }
}
