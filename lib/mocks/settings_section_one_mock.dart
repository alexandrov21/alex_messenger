import 'package:flutter/material.dart';

import '../models/settings_section_model.dart';

abstract class SettingsSectionOneMock {
  static final List<SettingsSectionModel> settingsSectionOne = [
    SettingsSectionModel(Icons.bookmark, 'Saved Messages', Colors.blueAccent),
    SettingsSectionModel(Icons.call, 'Recent Call', Colors.green),
    SettingsSectionModel(Icons.devices, 'Devices', Colors.orange),
    SettingsSectionModel(Icons.folder, 'Chat Folders', Colors.lightBlueAccent),
  ];
}
