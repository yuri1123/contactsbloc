import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/user_info_results.dart';

class UserListController extends GetxController {
  late Dio _dio;
  ScrollController scrollController = ScrollController();
  int nextPage = -1;
  Rx<UserInfoResult> userInfoResult = UserInfoResult.init().obs;

  @override
  void onInit() {
    super.onInit();

    _dio = Dio(BaseOptions(baseUrl: 'https://randomuser.me/'));
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent * 0.7 <=
              scrollController.offset &&
          nextPage != userInfoResult.value.currentPage) {
        nextPage = userInfoResult.value.currentPage;
        _loadUserList();
      }
    });
    _loadUserList();
  }

  Future<void> _loadUserList() async {
    var result = await _dio.get(
      'api',
      queryParameters: {
        'results': 10,
        'seed': 'yuri',
        'page': userInfoResult.value.currentPage
      },
    );
    userInfoResult(userInfoResult.value.copyWithFromJson(result.data));
  }
}
