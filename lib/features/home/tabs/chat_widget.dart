import 'package:flutter/material.dart';
import 'package:foresee_cycles/shared/widgets/custom_app_bar.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Chat'),
      body: Center(
        child: Text(
          'Chat Functionality Coming Soon!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
