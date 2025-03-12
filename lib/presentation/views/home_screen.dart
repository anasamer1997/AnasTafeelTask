import 'package:anas_tafeel_task/data/api/api_services.dart';
import 'package:anas_tafeel_task/presentation/userList_cubit/user_list_cubit.dart';

import 'package:anas_tafeel_task/views/user_screen.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// original code

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserListCubit>().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Users")),
      body: BlocBuilder<UserListCubit, UserListState>(
        buildWhen: (previous, current) =>
            current is! LoadMoreUsers && current is! LoadMoreUsersError,
        builder: (context, state) {
          if (state is UserListInitial || state is UserListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserListError) {
            return Center(child: Text(state.message));
          } else if (state is UserListLoaded) {
            final allUsers = state.users;
            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.pixels ==
                        notification.metrics.maxScrollExtent &&
                    notification is ScrollUpdateNotification) {
                  UserListCubit cubit = BlocProvider.of<UserListCubit>(context);
                  cubit.fetchUsers(loadNewData: true);
                }
                return true;
              },
              child: ListView.separated(
                separatorBuilder: (ctx, _) => const SizedBox(
                  height: 55,
                ),
                itemCount: allUsers.length,
                itemBuilder: (context, index) {
                  final user = allUsers[index];
                  return ListTile(
                    title: Text("${user.firstName} ${user.lastName}"),
                    subtitle: Text(user.email),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => BlocProvider(
                                create: (context) => UserListCubit(
                                    apiService: ApiService(Dio())),
                                child: UserDetailScreen(userId: user.id),
                              )));
                    },
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 50,
          child: BlocBuilder<UserListCubit, UserListState>(
              buildWhen: (previous, current) =>
                  current is LoadMoreUsers || current is UserListLoaded,
              builder: (ctx, state) {
                if (state is LoadMoreUsers) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadMoreUsersError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
        ),
      ),
    );
  }
}
