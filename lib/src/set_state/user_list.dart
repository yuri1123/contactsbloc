import 'package:flutter/material.dart';

class UserListPageSetState extends StatelessWidget {
  const UserListPageSetState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('setState 상태관리'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Row(
              children: [
                CircleAvatar(
                  backgroundImage: Image.network(
                      'https://randomuser.me/api/portraits/thumb/men/75.jpg').image,radius: 35,)
              ],
            );
          },
          separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
              ),
          itemCount: 100),
    );
  }
}
