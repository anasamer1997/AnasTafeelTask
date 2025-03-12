import 'package:anas_tafeel_task/data/api/api_services.dart';
import 'package:anas_tafeel_task/presentation/userList_cubit/user_list_cubit.dart';
import 'package:anas_tafeel_task/strings.dart';
import 'package:anas_tafeel_task/presentation/views/home_screen.dart';
import 'package:anas_tafeel_task/presentation/views/user_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late ApiService apiService;
  late UserListCubit userListCubit;

  AppRouter() {
    apiService = ApiService(Dio());
    userListCubit = UserListCubit(apiService: apiService);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case userListScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext contxt) => userListCubit,
            child: const UserListScreen(),
          ),
        );

      case userDetailsScreen:
        final userId = settings.arguments as int;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                UserListCubit(apiService: apiService),
            child: UserDetailScreen(
              userId: userId,
            ),
          ),
        );
    }
    return null;
  }
}
