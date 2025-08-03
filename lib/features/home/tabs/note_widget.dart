import 'package:flutter/material.dart';
import 'package:foresee_cycles/shared/widgets/custom_app_bar.dart';

class NotesTab extends StatelessWidget {
  const NotesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Notes'),
      body: Center(
        child: Text(
          'Notes Functionality Coming Soon!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
