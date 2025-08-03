import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Corrected import paths based on your project architecture
import 'package:foresee_cycles/features/auth/welcome.dart';
import 'package:foresee_cycles/features/home/home_page.dart';
import 'package:foresee_cycles/shared/constants/constant_data.dart';

// 1. Create a provider for the Firebase Auth state stream.
// This provider will be watched by the UI to react to auth changes.
// It's best practice to move this to your `auth_service.dart` file later.
final authStateChangesProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

// 2. The SplashScreen is now a ConsumerWidget.
// This allows it to listen to providers. It no longer needs to be stateful.
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Set preferred orientations
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Watch the auth state provider. Riverpod will automatically rebuild
    // this widget when the user's auth state changes.
    final authState = ref.watch(authStateChangesProvider);

    // Use `when` to handle loading, error, and data states gracefully.
    // This replaces the manual Timer and Navigator logic from initState.
    return authState.when(
      data: (user) {
        // After a short delay to show the splash screen, navigate.
        return FutureBuilder(
          future: Future.delayed(const Duration(seconds: 2)),
          builder: (context, snapshot) {
            // When the delay is complete, navigate to the correct screen.
            if (snapshot.connectionState == ConnectionState.done) {
              return user != null ? const HomeScreen() : const WelcomeScreen();
            }
            // While waiting, show the splash screen UI.
            return const _SplashScreenContent();
          },
        );
      },
      // While the auth state is being determined, show the splash screen UI.
      loading: () => const _SplashScreenContent(),
      // If there's an error fetching the auth state, show an error message.
      error: (err, stack) => Scaffold(
        body: Center(
          child: Text('An error occurred: $err'),
        ),
      ),
    );
  }
}

// 3. The UI of the splash screen is extracted into its own stateless widget.
// This keeps the code clean and reusable.
class _SplashScreenContent extends StatelessWidget {
  const _SplashScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Find screen width and height for responsive UI.
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.4, 0.7, 0.9],
            colors: [
              Color(0xFFffebbb),
              Color(0xFFfbceac),
              Color(0xFFf48988),
              Color(0xFFef6786),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(ConstantsData.splashImage),
                radius: screenSize.width * 0.15,
              ),
              SizedBox(height: screenSize.height * 0.03),
              Text(
                "Foresee Cycle",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenSize.width * 0.07,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
