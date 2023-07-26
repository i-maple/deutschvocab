import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deutschvocab/provider/login_provider.dart';
import 'package:deutschvocab/provider/vocabulary_list_provider.dart';
import 'package:deutschvocab/screens/login_onboarding_screen.dart';
import 'package:deutschvocab/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => VocabularyListProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/login',
        routes: {
          '/home': (context) => const HomeScreen(),
          '/login-onboarding': (context) => const LoginOnboardingScreen(),
          '/login':(context) => const LoginScreen(),
        },
      ),
    );
  }
}
