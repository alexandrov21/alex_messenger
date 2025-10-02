import 'package:alex_messenger/models/all_dialogs_model.dart';
import 'package:flutter/material.dart';

import '../../mocks/all_dialogs_mock.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final List<AllDialogsModel> dialogs = AllDialogsMock.allDialogs;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
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
        centerTitle: true,
        leading: BackButton(color: Colors.white),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [Text('Chatroom', style: TextStyle(color: Colors.white))],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.indigo, Colors.blue]),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: dialogs.length,
        itemBuilder: (context, index) {
          final dialog = dialogs[index];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: dialog.color,
                      ),
                      child: Text(dialog.avatar),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(dialog.name), Text(dialog.lastMessege)],
                      ),
                    ),
                  ],
                ),
              ),
              _buildDivider(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 3,
      color: Colors.grey,
      indent: 67,
      endIndent: 20,
    );
  }
}
