import 'package:flutter/material.dart';

import '../model/user_info_results.dart';

class UserInfoWidget extends StatelessWidget {
  final UserInfo userInfo;

  const UserInfoWidget({required this.userInfo, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: Image.network(userInfo.profileImage).image,
            radius: 35,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(userInfo.email,
                  style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 15)),
              Text(
                userInfo.name,
                style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: Colors.blueAccent),
              ),
              const SizedBox(
                width: 7,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.phone,
                    size: 20,
                  ),
                  Text(userInfo.phone)
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
