import 'package:chat_app/Pages/Login_Page.dart';
import 'package:chat_app/Pages/chat_page.dart';
import 'package:chat_app/Pages/resgister.dart';
import 'package:chat_app/bloc/auth-bloc/auth_bloc.dart';
import 'package:chat_app/cubit/auth-cubit/auth_cubit.dart';
import 'package:chat_app/cubit/chat-cubit/cubit/chat_cubit.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  BlocOverrides.runZoned(
    () {
      runApp(const ScholsrChat());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class ScholsrChat extends StatelessWidget {
  const ScholsrChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => ChatCubit()),
      ],
      child: MaterialApp(
        routes: {
          'LoginPage': (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          ChatPage.id: (context) => ChatPage(),
          LoginPage.id: (context) => LoginPage(),
        },
        debugShowCheckedModeBanner: false,
        initialRoute: LoginPage.id,
      ),
    );
  }
}
