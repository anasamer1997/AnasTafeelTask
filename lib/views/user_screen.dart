import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/userList_cubit/user_list_cubit.dart';

class UserDetailScreen extends StatefulWidget {
  final int userId;

  const UserDetailScreen({required this.userId});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UserListCubit>().fetchSingleUser(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Details")),
      body: BlocBuilder<UserListCubit, UserListState>(
        builder: (context, state) {
          if (state is UserDetailLoaded) {
            final user = state.user;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar),
                    radius: 50,
                  ),
                  const SizedBox(height: 16),
                  Text("Name: ${user.firstName} ${user.lastName}"),
                  Text("Email: ${user.email}"),
                ],
              ),
            );
          } else if (state is UserListError) {
            return Center(child: Text(state.message));
          } else if (state is UserDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
