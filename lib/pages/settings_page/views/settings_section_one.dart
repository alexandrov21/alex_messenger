import 'package:flutter/material.dart';

import '../../../mocks/settings_section_one_mock.dart';
import '../../../models/settings_section_model.dart';

class SettingsSectionOne extends StatefulWidget {
  const SettingsSectionOne({Key? key}) : super(key: key);

  @override
  State<SettingsSectionOne> createState() => _SettingsSectionOneState();
}

class _SettingsSectionOneState extends State<SettingsSectionOne> {
  @override
  Widget build(BuildContext context) {
    final List<SettingsSectionModel> sectionOne =
        SettingsSectionOneMock.settingsSectionOne;
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black38,
              blurRadius: 1.0,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Column(
          children: List.generate(sectionOne.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 8,
                top: 8,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: sectionOne[index].color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Icon(
                                sectionOne[index].icon,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            sectionOne[index].name,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.chevron_right_sharp,
                        color: Colors.grey,
                        size: 24,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildElementOfOptions(sectionOne, int index) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: sectionOne[index].color,
          ),
          child: Icon(sectionOne[index].icon, color: Colors.white),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: _buildNameOfOptionsElement(sectionOne, index),
          ),
        ),
        const Icon(Icons.chevron_right_sharp, color: Colors.grey),
      ],
    );
  }

  Widget _buildNameOfOptionsElement(sectionOne, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionOne[index].name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
