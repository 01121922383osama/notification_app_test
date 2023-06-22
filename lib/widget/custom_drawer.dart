import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../resources/auth_method.dart';

class CustomDrawerPage extends StatefulWidget {
  const CustomDrawerPage({super.key});

  @override
  State<CustomDrawerPage> createState() => _CustomDrawerPageState();
}

class _CustomDrawerPageState extends State<CustomDrawerPage> {
  bool isSetPhoto = true;
  final AuthMethods authMethods = AuthMethods();
  var user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final a = user!.photoURL;

    return Drawer(
      elevation: 0,
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                color: Colors.grey,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: isSetPhoto
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(a!,
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.width),
                          )
                        : const Icon(
                            Icons.person,
                            size: 70,
                            color: Colors.red,
                          ),
                  ),
                ),
              ),
              buildListTile('test', () => null),
            ],
          );
        },
      ),
    );
  }

  Widget buildListTile(String text, Function() tapFunction) {
    return Column(
      children: [
        ListTile(
          trailing: const Icon(Icons.arrow_forward_ios),
          title: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: tapFunction,
        ),
      ],
    );
  }
}
