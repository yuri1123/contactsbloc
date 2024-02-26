import 'package:contactsbloc/src/cubit/user_list.dart';
import 'package:contactsbloc/src/cubit/user_list_cubit_extends.dart';
import 'package:contactsbloc/src/cubit_copywith/user_list.dart';
import 'package:contactsbloc/src/getx/user_list_controller.dart';
import 'package:contactsbloc/src/set_state/user_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'cubit_copywith/user_list_cubit_copywith.dart';
import 'getx/user_list.dart';

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
                          builder: (context) => UserListPageSetState()));
                },
                child: const Text('SetState 상태관리')),
            ElevatedButton(
                onPressed: () {
                  Get.put(UserListController());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserListGetX()));
                },
                child: const Text('GetX 상태관리')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                            create: (context) => UserListCubitExtends(),
                            child: UserListForCubitExtends()),
                      ));
                },
                child: const Text('Extends 상태관리')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                            create: (context) => UserListCubitCopyWith(),
                            child: UserListForCubitCopyWith()),
                      ));
                },
                child: const Text('Copy With 상태관리')),
          ],
        ),
      ),
    );
  }
}
