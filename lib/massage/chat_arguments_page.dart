import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatArguments extends StatelessWidget {
  const ChatArguments({super.key, required this.message});
  final RemoteMessage message;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('data'),
      ),
    );
  }
}
