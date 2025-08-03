import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Corrected import path to align with your project architecture.
// Make sure the SplashScreen file is located at: lib/features/auth/splash.dart
import 'package:foresee_cycles/features/auth/splash.dart'; 

void main() async {
  // Ensure Flutter bindings are initialized before any async operations.
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase for backend services.
  await Firebase.initializeApp();

  // Wrap the entire application in a ProviderScope.
  // This makes all Riverpod providers available to the entire widget tree.
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// MyApp is now a ConsumerWidget to access providers from Riverpod.
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // The 'ref' object allows you to interact with providers.
    // For example: final authState = ref.watch(authProvider);

    return MaterialApp(
      title: 'Foresee Cycles',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // The initial screen of the app.
      home: const SplashScreen(),
    );
  }
}
