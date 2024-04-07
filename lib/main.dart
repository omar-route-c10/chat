import 'package:chat/auth/view_model/auth_view_model.dart';
import 'package:chat/auth/view/screens/login_screen.dart';
import 'package:chat/auth/view/screens/register_screen.dart';
import 'package:chat/chat/view/screens/chat_screen.dart';
import 'package:chat/firebase_options.dart';
import 'package:chat/home_screen.dart';
import 'package:chat/rooms/view/screens/create_room_screen.dart';
import 'package:chat/shared/app_bloc_observer.dart';
import 'package:chat/shared/app_theme.dart';
import 'package:chat/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = AppBlocObserver();
  runApp(
    BlocProvider(
      create: (_) => AuthViewModel(),
      child: ChatApp(),
    ),
  );
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        CreateRoomScreen.routeName: (_) => CreateRoomScreen(),
        ChatScreen.routeName: (_) => ChatScreen(),
      },
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
    );
  }
}
