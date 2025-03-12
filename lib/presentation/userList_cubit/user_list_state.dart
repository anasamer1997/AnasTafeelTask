part of 'user_list_cubit.dart';

abstract class UserListState extends Equatable {
  const UserListState();

  @override
  List<Object> get props => [];
}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {}

class LoadMoreUsers extends UserListState {}

class LoadMoreUsersError extends UserListState {
  final String message;

  const LoadMoreUsersError({required this.message});
  @override
  List<Object> get props => [message];
}

class UserListLoaded extends UserListState {
  final List<UserModel> users;

  const UserListLoaded({required this.users});

  @override
  List<Object> get props => [users];
}

class UserDetailLoaded extends UserListState {
  final UserModel user;

  const UserDetailLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class UserListError extends UserListState {
  final String message;

  const UserListError({required this.message});

  @override
  List<Object> get props => [message];
}
