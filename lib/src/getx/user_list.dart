import 'package:contactsbloc/src/getx/user_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/user_info.dart';
import '../model/user_info_results.dart';

class UserListGetX extends GetView<UserListController> {
  const UserListGetX({super.key});

  Widget _loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _error() {
    return const Center(
      child: Text('오류 발생!!'),
    );
  }

  Widget _userListWidget(List<UserInfo> userInfoList) {
    return ListView.separated(
        controller: controller.scrollController,
        itemBuilder: (context, index) {
          if (index == userInfoList.length) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return UserInfoWidget(userInfo: userInfoList[index]);
        },
        separatorBuilder: (context, index) => const Divider(
              color: Colors.grey,
            ),
        itemCount: userInfoList.length + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('GetX 상태관리'),
        ),
        body: Obx(() =>
            _userListWidget(controller.userInfoResult.value.userInfoList)));
  }
}
