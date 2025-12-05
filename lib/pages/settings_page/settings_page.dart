import 'package:alex_messenger/pages/settings_page/views/settings_section_one.dart';
import 'package:alex_messenger/pages/settings_page/views/settings_section_two.dart';
import 'package:flutter/material.dart';

import '../../models/app_user.dart';
import '../../services/auth_services/auth_service.dart';
import '../../utils/app_colors.dart';

class SettingsPage extends StatefulWidget {
  final AppUser currentUser;

  const SettingsPage({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.indigo, Colors.blue]),
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.keyboard_backspace_outlined, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService.signOut();
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil('/sign_in', (route) => false);
            },
            icon: Icon(Icons.logout_outlined, color: Colors.white),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 28),
            child: Column(
              children: [
                _buildAvatar(
                  widget.currentUser.fullName,
                  widget.currentUser.uid!,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    children: [
                      Text(widget.currentUser.fullName),
                      Text(widget.currentUser.email),
                    ],
                  ),
                ),
                _buildButtonChangePhoto(),
                SizedBox(height: 16),
                _buildButtonMyProfile(),
                SizedBox(height: 16),
                SettingsSectionOne(),
                SizedBox(height: 16),
                SettingsSectionTwo(),
              ],
            ),
          ),
        ],
      ),
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
      radius: 40,
      backgroundColor: bgColor,
      child: Text(
        initials.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
      ),
    );
  }

  Widget _buildButtonChangePhoto() {
    return InkWell(
      onTap: () {
        print('change photo');
      },
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black38,
                blurRadius: 1.0,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.add_a_photo_outlined, color: Colors.blue),
                SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'Change profile`s photo',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right_sharp, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonMyProfile() {
    return InkWell(
      onTap: () {
        print('my profile');
      },
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black38,
                blurRadius: 1.0,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 8,
              top: 8,
            ),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person_pin_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'My profile',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right_sharp,
                  color: Colors.grey,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
