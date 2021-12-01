import 'package:firebase_example/src/community/page/community_page.dart';
import 'package:firebase_example/src/data.dart';
import 'package:firebase_example/src/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final DataController _dataController = Get.put(DataController());

class FirebaseStoreTestPage extends StatelessWidget {
  String test = '2021-11-30T20:35:50.814231';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(),
            MaterialButton(
              onPressed: () {
                _dataController.addData(TestData(
                    'mingwan', 'selecto', DateTime.now().toIso8601String()));
              },
              color: Colors.blueAccent,
            ),
            MaterialButton(
                onPressed: () {
                  _dataController.readData();
                },
                color: Colors.indigo),
            MaterialButton(
              onPressed: () {
                print(DateTime.now());
              },
              color: Colors.deepOrangeAccent,
            ),
            MaterialButton(onPressed: () {
              Get.to(() => CommunityPage());
            },
              color: Colors.purple,
            ),
          // 2021-11-30T20:35:50.814231
            Text('${int.parse(test.substring(14,16))}'),
            Text(test),
            Text('${DateTime.now().add(Duration(days: 3,hours: 10,minutes: 10)).toIso8601String()}')
          ],
        ),
      ),
    );
  }
}
