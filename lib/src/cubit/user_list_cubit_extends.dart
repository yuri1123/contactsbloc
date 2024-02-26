import 'package:bloc/bloc.dart';
import 'package:contactsbloc/src/model/user_info_results.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class UserListCubitExtends extends Cubit<UserListCubitState> {
  late Dio _dio;

  UserListCubitExtends() : super(InitUserListCubitState()) {
    _dio = Dio(BaseOptions(baseUrl: 'https://randomuser.me/'));
    loadUserList();
  }

  loadUserList() async {
    try {
      if (state is LoadingUserListCubitState ||
          state is ErrorUserListCubitState) {
        return;
      }
      emit(LoadingUserListCubitState(userInfoResult: state.userInfoResult));
      var result = await _dio.get(
        'api',
        queryParameters: {
          'results': 10,
          'seed': 'yuri',
          'page': state.userInfoResult.currentPage
        },
      );
      emit(LoadedUserListCubitState(
          userInfoResult: state.userInfoResult.copyWithFromJson(result.data)));
    } catch (e) {
      emit(ErrorUserListCubitState(
          errorMessage: e.toString(), userInfoResult: state.userInfoResult));
    }
  }
}

abstract class UserListCubitState extends Equatable {
  UserInfoResult userInfoResult;

  UserListCubitState({required this.userInfoResult});
}
//로딩
//오류
//완료
//초기상태

class InitUserListCubitState extends UserListCubitState {
  InitUserListCubitState() : super(userInfoResult: UserInfoResult.init());

  @override
  List<Object?> get props => [userInfoResult];
}

class LoadingUserListCubitState extends UserListCubitState {
  LoadingUserListCubitState({required super.userInfoResult});

  @override
  List<Object?> get props => [userInfoResult];
}

class LoadedUserListCubitState extends UserListCubitState {
  LoadedUserListCubitState({required super.userInfoResult});

  @override
  List<Object?> get props => [userInfoResult];
}

class ErrorUserListCubitState extends UserListCubitState {
  String errorMessage;

  ErrorUserListCubitState(
      {required this.errorMessage, required super.userInfoResult});

  @override
  List<Object?> get props => [errorMessage, userInfoResult];
}
