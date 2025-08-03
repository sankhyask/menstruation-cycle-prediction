import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foresee_cycles/core/services/auth_service.dart';
//import 'package:foresee_cycles/shared/widgets/custom_app_bar.dart';

// Provider to manage the loading state for the "Send" button.
final forgotPasswordLoadingProvider = StateProvider<bool>((ref) => false);

// Convert to a ConsumerStatefulWidget to use Riverpod.
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // Refactored logic to send the password reset email.
  Future<void> _sendResetEmail() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ref.read(forgotPasswordLoadingProvider.notifier).state = true;

    try {
      // Call the method from our AuthService.
      await ref.read(authServiceProvider).sendPasswordResetEmail(
            email: _emailController.text.trim(),
          );

      // On success, show a confirmation message and pop the screen.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent! Please check your inbox.')),
      );
      Navigator.of(context).pop();

    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "An unknown error occurred")),
      );
    } finally {
      ref.read(forgotPasswordLoadingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch the loading provider.
    final isLoading = ref.watch(forgotPasswordLoadingProvider);

    return Scaffold(
      // Use the reusable CustomAppBar we created earlier.
      //appBar: const CustomAppBar(title: 'Forgot Password'),
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                "Forgot password",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                "Enter your email address below and we'll send you an email with instructions on how to change your password.",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 50),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _sendResetEmail,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('SEND'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
