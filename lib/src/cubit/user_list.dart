import 'package:contactsbloc/src/cubit/user_list_cubit_extends.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/user_info.dart';
import '../model/user_info_results.dart';

class UserListForCubitExtends extends StatefulWidget {
  const UserListForCubitExtends({super.key});

  @override
  State<UserListForCubitExtends> createState() =>
      _UserListForCubitExtendsState();
}

class _UserListForCubitExtendsState extends State<UserListForCubitExtends> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent -200 <=
          scrollController.offset) {
        context.read<UserListCubitExtends>().loadUserList();
      }
    });
  }

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
        controller: scrollController,
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
        title: const Text('Cubit extends 상태관리'),
      ),
      body: BlocBuilder<UserListCubitExtends, UserListCubitState>(
          builder: (context, state) {
        if(state is ErrorUserListCubitState){
          return _error();
        }
        if (state is LoadedUserListCubitState || state is LoadedUserListCubitState) {
          return _userListWidget(state.userInfoResult.userInfoList);
        }
        return Container();
      }),
    );
  }
}
