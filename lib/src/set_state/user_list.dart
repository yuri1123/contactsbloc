import 'package:contactsbloc/src/model/user_info_results.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../components/user_info.dart';

class UserListPageSetState extends StatefulWidget {
  UserListPageSetState({super.key});

  @override
  State<UserListPageSetState> createState() => _UserListPageSetStateState();
}

class _UserListPageSetStateState extends State<UserListPageSetState> {
  late Dio _dio;
  ScrollController scrollController = ScrollController();
  int nextPage = -1;
  late UserInfoResult userInfoResult;

  @override
  void initState() {
    super.initState();
    userInfoResult = UserInfoResult(currentPage: 0, userInfoList: []);
    _dio = Dio(BaseOptions(baseUrl: 'https://randomuser.me/'));
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent * 0.7 <=
              scrollController.offset &&
          nextPage != userInfoResult.currentPage) {
        nextPage = userInfoResult.currentPage;
        setState(() {});
        print('next Page!');
      }
    });
  }

  Future<UserInfoResult> _loadUserList() async {
    var result = await _dio.get(
      'api',
      queryParameters: {
        'results': 10,
        'seed': 'yuri',
        'page': userInfoResult.currentPage
      },
    );
    userInfoResult = userInfoResult.copyWithFromJson(result.data);
    return userInfoResult;
    print(result);
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
        title: const Text('setState 상태관리'),
      ),
      body: FutureBuilder<UserInfoResult>(
          future: _loadUserList(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return _error();
            }
            if (snapshot.hasData) {
              return _userListWidget(snapshot.data!.userInfoList);
            }
            return _loading();
          }),
    );
  }
}
