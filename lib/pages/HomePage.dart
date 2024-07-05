import 'package:flutter/material.dart';

import 'package:hey_app/appColors.dart';
import 'package:hey_app/services/auth/authService.dart';
import 'package:hey_app/pages/SettingsPage.dart';
import 'package:hey_app/services/chat/chatService.dart';


import '../components/userTile.dart';
import 'LoginPage.dart';
import 'chatPage.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void logout(BuildContext context) async {
    await _authService.signout();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) =>
              LoginPage()), // Ensure this leads to your login page.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        iconTheme: const IconThemeData(color: AppColors.white),
        actions: [
          IconButton(
            onPressed: () => logout(context),
            icon: const Icon(Icons.logout, color: AppColors.white),
          ),
        ],
        backgroundColor: AppColors.appbar,
        title: const Text('Home', style: TextStyle(color: AppColors.white)),
        centerTitle: true,
      ),
      body: _buildUserList(),
      drawer: Drawer(
        backgroundColor: AppColors.black,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 45.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.message_outlined,
                    size: 40,
                    color: AppColors.white,
                  ),
                  const SizedBox(height: 20),
                  const Divider(
                      endIndent: 10,
                      indent: 10,
                      thickness: 0.2,
                      color: AppColors.white),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ListTile(
                      title: const Text("H O M E",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.white)),
                      leading: const Icon(
                        Icons.home,
                        color: AppColors.white,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ListTile(
                      title: const Text("S E T T I N G S",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.white)),
                      leading: const Icon(
                        Icons.settings,
                        color: AppColors.white,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsPage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ListTile(
                  title: const Text("Log Out",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: AppColors.white)),
                  leading: const Icon(
                    Icons.logout,
                    color: AppColors.white,
                  ),
                  onTap: () => logout(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error", style: TextStyle(color: AppColors.white)),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text("No users found",
                style: TextStyle(color: AppColors.white,fontSize: 20)),
          );
        }

        final users = snapshot.data!;

        return ListView(
          children: users.map((userdata) {
            return _buildUserListItem(userdata, context);
          }).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    final currentUser = _authService.getCurrentUser();

    if (currentUser == null) {
      return const SizedBox.shrink(); // or handle this case accordingly
    }

    if (userData["email"] != currentUser.email) {
      return UserTile(
        text: userData["email"].substring(0,userData["email"].indexOf('@')) ?? 'No Email',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                recieverEmail: userData["email"]!,
                recieverId: userData["uid"],
              ),
            ),
          );
        },
      );
    }

    return const SizedBox
        .shrink(); // Return an empty container or widget for the current user
  }
}
