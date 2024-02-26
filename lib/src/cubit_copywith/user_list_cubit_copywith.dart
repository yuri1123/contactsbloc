import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../model/user_info_results.dart';

class UserListCubitCopyWith extends Cubit<UserListCubitcopyState> {
  late Dio _dio;

  UserListCubitCopyWith() : super(UserListCubitcopyState.init()) {
    _dio = Dio(BaseOptions(baseUrl: 'https://randomuser.me/'));
    loadUserList();
  }

  loadUserList() async {
    try {
      if (state.status == UserListCubitStatus.loading ||
          state.status == UserListCubitStatus.error) {
        return;
      }
      emit(state.copyWith(status: UserListCubitStatus.loading));
      var result = await _dio.get(
        'api',
        queryParameters: {
          'results': 10,
          'seed': 'yuri',
          'page': state.userInfoResult.currentPage
        },
      );
      emit(state.copyWith(
          status: UserListCubitStatus.loaded,
          userInfoResult: state.userInfoResult.copyWithFromJson(result.data)));
    } catch (e) {
      emit(state.copyWith(
          status: UserListCubitStatus.error, errorMessage: e.toString()));
    }
  }
}

enum UserListCubitStatus { init, loading, loaded, error }

class UserListCubitcopyState extends Equatable {
  final UserListCubitStatus status;
  final UserInfoResult userInfoResult;
  final String? errorMessage;

  const UserListCubitcopyState(
      {required this.status, required this.userInfoResult, this.errorMessage});

  UserListCubitcopyState.init()
      : this(
            status: UserListCubitStatus.init,
            userInfoResult: UserInfoResult.init());

  UserListCubitcopyState copyWith({
    UserListCubitStatus? status,
    UserInfoResult? userInfoResult,
    String? errorMessage,
  }) {
    return UserListCubitcopyState(
        status: status ?? this.status,
        userInfoResult: userInfoResult ?? this.userInfoResult,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, userInfoResult, errorMessage];
}
