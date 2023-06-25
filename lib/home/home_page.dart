import 'dart:async';

import 'package:flutter/material.dart';

import '../Services/notifi_service.dart';
import '../resources/auth_method.dart';
import '../widget/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  void startTimer() {
    Timer.periodic(const Duration(seconds: 5), (_) {
      NotificationService().showNotification(
        title: 'عزيزي العميل لقد تم اختراقك😊',
        body: 'It works!',
      );
    });
  }

  final AuthMethods authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                authMethods.signOut(context);
              },
              icon: const Icon(Icons.power_settings_new_outlined))
        ],
      ),
      drawer: const CustomDrawerPage(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                spaceWidget(),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Send Notification every 5 second'),
                ),
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    startTimer();
                  },
                  child: const Text('send Automatically'),
                ),
                spaceWidget(),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Send 1 Notification'),
                ),
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    NotificationService().showNotification(
                      title: 'عزيزي العميل لقد تم اختراقك😊',
                      body: 'It works!',
                    );
                  },
                  child: const Text('send 1 Notification'),
                ),
                spaceWidget(),
                textFormFaildWidget('title', title),
                textFormFaildWidget('body', body),
                spaceWidget(),
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      NotificationService().showNotification(
                        title: title.text.trim(),
                        body: body.text.trim(),
                      );
                    }

                    title.clear();
                    body.clear();
                  },
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textFormFaildWidget(
      String text, TextEditingController textEditingController) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: const BorderSide(width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(width: 1),
          ),
          alignLabelWithHint: true,
          floatingLabelAlignment: FloatingLabelAlignment.center,
          hintText: text,
          isDense: true,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'write the message';
          }
          return null;
        },
      ),
    );
  }

  Widget spaceWidget() {
    return const SizedBox(height: 20);
  }

  ButtonStyle buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.teal),
    elevation: MaterialStateProperty.all(0),
    animationDuration: const Duration(seconds: 1),
  );
}
