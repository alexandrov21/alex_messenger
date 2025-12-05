import 'package:flutter/material.dart';

import '../models/settings_section_model.dart';

abstract class SettingsSectionTwoMock {
  static final List<SettingsSectionModel> settingsSectionTwo = [
    SettingsSectionModel(
      Icons.notifications_active,
      'Notifications and Sounds',
      Colors.red,
    ),
    SettingsSectionModel(Icons.lock, 'Privacy and Security', Colors.black12),
    SettingsSectionModel(Icons.storage, 'Data and Storage', Colors.green),
    SettingsSectionModel(Icons.circle_outlined, 'Appearance', Colors.lightBlue),
    SettingsSectionModel(Icons.battery_2_bar, 'Power Saving', Colors.orange),
    SettingsSectionModel(Icons.language, 'Language', Colors.purple),
  ];
}
