import 'package:anas_tafeel_task/data/Model/user_model.dart';
import 'package:anas_tafeel_task/data/api/api_services.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'user_list_state.dart';

class UserListCubit extends Cubit<UserListState> {
  final ApiService apiService;
  int page = 1;

  List<UserModel> _users = [];

  UserListCubit({required this.apiService}) : super(UserListInitial());

  void fetchUsers({bool loadNewData = false}) async {
    if (loadNewData) {
      emit(LoadMoreUsers());
    } else {
      emit(UserListLoading());
    }

    try {
      final response = await apiService.getUsers(page);

      if (response.data.isNotEmpty) {
        page++;
        _users.addAll(response.data);
      }
      emit(UserListLoaded(users: _users));
    } on DioException catch (e) {
      if (loadNewData) {
        emit(LoadMoreUsersError(message: e.toString()));
      } else {
        emit(UserListError(message: e.toString()));
      }
    }
  }

  void fetchSingleUser(int id) async {
    emit(UserDetailLoading());
    try {
      final response = await apiService.getUserDetails(id);
      final user = response.data;
      emit(UserDetailLoaded(user: user));
    } catch (e) {
      emit(UserListError(message: e.toString()));
    }
  }
}
