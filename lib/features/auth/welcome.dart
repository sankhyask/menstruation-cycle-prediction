import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foresee_cycles/features/auth/login.dart';
import 'package:foresee_cycles/shared/constants/constant_data.dart';
import 'package:foresee_cycles/shared/constants/styles.dart';

// Provider to hold the current page index of the onboarding screen.
final welcomePageProvider = StateProvider<int>((ref) => 0);

// The WelcomeScreen is now a ConsumerWidget.
class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  final int _numPages = 3;

  // Helper method to build the page indicator dots.
  List<Widget> _buildPageIndicator(int currentPage) {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  // Helper method for a single indicator dot's appearance.
  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: CustomColors.secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    // Watch the provider to get the current page and rebuild when it changes.
    final currentPage = ref.watch(welcomePageProvider);

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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Show "Skip" button only if not on the last page.
              if (currentPage != _numPages - 1)
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    ),
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: CustomColors.primaryColor,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: PageView(
                  physics: const ClampingScrollPhysics(),
                  // Update the provider's state when the page changes.
                  onPageChanged: (int page) {
                    ref.read(welcomePageProvider.notifier).state = page;
                  },
                  children: <Widget>[
                    _buildOnboardingPage(
                      screenSize: screenSize,
                      imagePath: ConstantsData.welcomeOne,
                      title: 'Connect people\naround the world',
                      subtitle: 'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                    ),
                    _buildOnboardingPage(
                      screenSize: screenSize,
                      imagePath: ConstantsData.welcomeTwo,
                      title: 'Live your life smarter\nwith us!',
                      subtitle: 'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                    ),
                    _buildOnboardingPage(
                      screenSize: screenSize,
                      imagePath: ConstantsData.welcomeThree,
                      title: 'Get a new experience\nof imagination',
                      subtitle: 'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(currentPage),
              ),
            ],
          ),
        ),
      ),
      // Show "Get started" button only on the last page.
      bottomSheet: currentPage == _numPages - 1
          ? GestureDetector(
              onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              ),
              child: Container(
                height: 80,
                width: double.infinity,
                color: CustomColors.secondaryColor,
                child: const Center(
                  child: Text(
                    'Get started',
                    style: TextStyle(
                      color: CustomColors.primaryColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  // Extracted page content into a reusable helper method.
  Widget _buildOnboardingPage({
    required Size screenSize,
    required String imagePath,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage(imagePath),
              height: screenSize.height * 0.35,
              width: screenSize.height * 0.35,
            ),
          ),
          const SizedBox(height: 30.0),
          Text(
            title,
            style: const TextStyle(
              color: CustomColors.yellowLightColor,
              fontSize: 26.0,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 15.0),
          Text(
            subtitle,
            style: const TextStyle(
              color: CustomColors.yellowLightColor,
              fontSize: 18.0,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
