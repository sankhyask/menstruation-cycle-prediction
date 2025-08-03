import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foresee_cycles/core/services/auth_service.dart';
import 'package:foresee_cycles/features/auth/login.dart';
import 'package:foresee_cycles/shared/constants/styles.dart';

// 1. Provider to manage the loading state for the signup button.
final signupLoadingProvider = StateProvider<bool>((ref) => false);

// 2. Convert the widget to a ConsumerStatefulWidget to use Riverpod.
class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // 3. Refactored signup logic. It's now clean and separated from the UI.
  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Set loading state to true.
    ref.read(signupLoadingProvider.notifier).state = true;

    try {
      // Call the signup method from our AuthService.
      await ref.read(authServiceProvider).createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
      
      // On success, show a confirmation and navigate to the login screen.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully! Please log in.')),
      );
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()), 
          (route) => false,
      );

    } on FirebaseAuthException catch (e) {
      // On failure, show a user-friendly error message.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "An unknown error occurred")),
      );
    } finally {
      // Always set loading state back to false.
      ref.read(signupLoadingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // 4. Watch the loading provider to rebuild the button when the state changes.
    final isLoading = ref.watch(signupLoadingProvider);

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
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.07),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Let's Get Started",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: 'Name',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        hintText: 'Phone',
                        prefixIcon: Icon(Icons.phone_android_outlined),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.alternate_email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) => value!.length < 6 ? 'Password must be at least 6 characters' : null,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _signUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                'SIGN UP',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          child: const Text('LOGIN'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
