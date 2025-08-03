import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import the new, separated page widgets
import 'package:foresee_cycles/features/home/tabs/home_tab.dart';
import 'package:foresee_cycles/features/home/tabs/calendar_tab.dart';
import 'package:foresee_cycles/features/home/tabs/chat_tab.dart';
import 'package:foresee_cycles/features/home/tabs/notes_tab.dart';
import 'package:foresee_cycles/features/home/tabs/profile_tab.dart';
import 'package:foresee_cycles/shared/constants/styles.dart';

// Provider to hold the currently selected index of the bottom navigation bar.
final homeNavigationProvider = StateProvider<int>((ref) => 2);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  // A list of the widgets to display for each tab.
  final List<Widget> _pages = const [
    CalendarTab(),
    ChatTab(),
    HomeTab(),
    NotesTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the provider to get the current index.
    final currentIndex = ref.watch(homeNavigationProvider);

    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.4],
            colors: [
              Color(0xFFf48988),
              Color(0xFFef6786),
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black26, spreadRadius: 1)
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(context, ref, icon: Icons.calendar_today, index: 0),
            _buildNavItem(context, ref, icon: Icons.message, index: 1),
            _buildNavItem(context, ref, icon: Icons.home, index: 2),
            _buildNavItem(context, ref, icon: Icons.note_add, index: 3),
            _buildNavItem(context, ref, icon: Icons.person, index: 4),
          ],
        ),
      ),
    );
  }

  // Helper widget to build each navigation item.
  Widget _buildNavItem(BuildContext context, WidgetRef ref, {required IconData icon, required int index}) {
    final isSelected = ref.watch(homeNavigationProvider) == index;
    return InkWell(
      onTap: () {
        // When tapped, update the provider's state with the new index.
        ref.read(homeNavigationProvider.notifier).state = index;
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: isSelected
              ? [const BoxShadow(color: Colors.grey, blurRadius: 10, spreadRadius: 1)]
              : [],
        ),
        height: 50,
        width: 50,
        child: Icon(
          icon,
          color: isSelected ? CustomColors.primaryColor : Colors.white,
        ),
      ),
    );
  }
}
