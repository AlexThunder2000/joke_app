import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joke_app/cubit/joke_cubit.dart';
import 'package:joke_app/joke_screen.dart';
import 'package:joke_app/services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.deepPurpleAccent,
        hintColor: Colors.tealAccent,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(color: Colors.white70, fontSize: 18),
          bodySmall: TextStyle(color: Colors.white70, fontSize: 16),
        ),
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          buttonColor: Colors.deepPurpleAccent,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: BlocProvider(
        create: (context) => JokeCubit(ApiService())..loadJokeTypes(),
        child: const JokeScreen(),
      ),
    );
  }
}
