import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazastore/core/routing/routes.dart';
import 'package:lazastore/features/app_controller/logic/app_controller_cubit.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 280.w,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: BlocBuilder<AppControllerCubit, AppControllerState>(
                builder: (context, state) {
                  if (state is Error) {
                    return const Center(child: Text('Error occurred'));
                  }
                  if (state is Authenticated) {
                    return ListView(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              state.userData.profilePicture == null ||
                                      state.userData.profilePicture!.isEmpty
                                  ? "https://www.bigfootdigital.co.uk/wp-content/uploads/2020/07/image-optimisation-scaled.jpg"
                                  : state.userData.profilePicture!,
                            ),
                          ),
                          title: Text(
                            state.userData.fullName,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Text(
                          state.userData.email,
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        Divider(color: Colors.grey),
                        ListTile(
                          leading: Icon(Icons.home, color: Colors.black),
                          title: Text(
                            'Home',
                            style: TextStyle(color: Colors.black),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings, color: Colors.black),
                          title: Text(
                            'Settings',
                            style: TextStyle(color: Colors.black),
                          ),
                          onTap: () {
                            // Navigate to settings
                          },
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Switch(value: true, onChanged: (e) {}),
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: Text('Guest'));
                  }
                },
              ),
            ),

            ListTile(
              leading: Icon(Icons.logout, color: Colors.black),
              title: Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Logout'),
                      content: Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              Routes.onboarding,
                              (route) => false,
                            );

                            await context.read<AppControllerCubit>().logout();
                          },
                          child: Text('Logout'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
