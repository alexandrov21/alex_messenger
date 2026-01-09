import 'package:alex_messenger/bloc/chat_page_bloc/chat_page_bloc.dart';
import 'package:alex_messenger/bloc/chat_page_bloc/chat_page_event.dart';
import 'package:alex_messenger/models/all_dialogs_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../mocks/all_dialogs_mock.dart';
import '../../models/app_user.dart';
import '../../services/chat_service/chat_service.dart';
import '../../services/user_service/user_firestore_service.dart';
import '../../utils/app_colors.dart';
import '../chat_page/chat_page.dart';

class MainPage extends StatefulWidget {
  final AppUser currentUser;

  const MainPage({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<List<AppUser>> _otherUsers;

  @override
  void initState() {
    super.initState();
    _otherUsers = FirestoreService.getAllUsersExcept(widget.currentUser.uid!);
  }

  @override
  Widget build(BuildContext context) {
    final List<AllDialogsModel> dialogs = AllDialogsMock.allDialogs;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) async {
          if (index == 2) {
            Navigator.of(
              context,
            ).pushNamed('/settings', arguments: widget.currentUser);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.messenger_outline),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Welcome, ${widget.currentUser.fullName}',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.indigo, Colors.blue]),
          ),
        ),
      ),
      body: FutureBuilder<List<AppUser>>(
        future: _otherUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final users = snapshot.data ?? [];
          if (users.isEmpty) {
            return const Center(child: Text('No other users found'));
          }
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => ChatPageBloc()
                              ..add(
                                ChatPageOpened(
                                  currentUser: widget.currentUser,
                                  otherUser: user,
                                ),
                              ),
                            child: ChatPage(),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Row(
                        children: [
                          _buildAvatar(user.fullName, user.uid!),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text(user.fullName), Text(user.email)],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildDivider(),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.only(left: 84),
      child: Divider(height: 0, thickness: 1, color: Color(0xFFD0D0D0)),
    );
  }

  Widget _buildAvatar(String fullName, String uid) {
    final parts = fullName.trim().split(" ");

    String initials = "";
    if (parts.isNotEmpty) initials += parts[0][0];
    if (parts.length > 1) initials += parts[1][0];

    final color = AppColors.generateStableColor(uid);
    final bgColor = AppColors.adjustColorForText(color);

    return CircleAvatar(
      radius: 32,
      backgroundColor: bgColor,
      child: Text(
        initials.toUpperCase(),
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}
