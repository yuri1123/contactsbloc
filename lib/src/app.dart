import 'package:contactsbloc/src/set_state/user_list.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserListPageSetState()));
                },
                child: const Text('SetState 상태관리')),
            ElevatedButton(onPressed: () {}, child: const Text('GetX 상태관리')),
            ElevatedButton(onPressed: () {}, child: const Text('Extends 상태관리')),
            ElevatedButton(onPressed: () {}, child: const Text('Copy With 상태관리')),
          ],
        ),
      ),
    );
  }
}
