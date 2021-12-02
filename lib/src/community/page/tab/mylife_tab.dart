import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_example/src/community/controller/community_controller.dart';
import 'package:firebase_example/src/community/data/community_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final CommunityController _communityController = Get.put(CommunityController());

class MyLifeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //   height: 200,
        //   child: PieChart(
        //     PieChartData(
        //       sections: [
        //         PieChartSectionData(
        //           value: 100,
        //         ),
        //         PieChartSectionData(
        //           value: 150,
        //           color: Colors.indigo
        //         ),
        //         PieChartSectionData(
        //           value: 70,
        //           color: Colors.purple
        //         ),
        //       ]
        //     )
        //   ),
        // )
        MaterialButton(
          onPressed: () async {
            _communityController.myLifeDataList.clear();
            await FirebaseFirestore.instance
                .collection('mylife')
                .get()
                .then((value) {
              value.docs.forEach((element) {
                print('value.size = ${element.data()}');
                _communityController.myLifeDataList
                    .add(MyLifeData.fromJson(element.data()));
                // return print(element['todos'][0]['color']);
              });
            });
          },
          color: Colors.indigo,
        ),
        MaterialButton(
          onPressed: () async {
            await FirebaseFirestore.instance
                .collection('mylife')
                .add(MyLifeData(
                    'good', DateTime.now(), 'mingwan', 'content Test', <Todo>[
                  Todo(
                    'testTodo1',
                    3,
                    DateTime.now(),
                    TimeOfRange(12, 0, 18, 30),
                  ),
                  Todo(
                    'testTodo2',
                    6,
                    DateTime.now(),
                    TimeOfRange(9, 0, 12, 30),
                  ),
              Todo(
                'testTodo3',
                2,
                DateTime.now(),
                TimeOfRange(10, 0, 11, 20),
              ),
              Todo(
                'testTodo4',
                1,
                DateTime.now(),
                TimeOfRange(18, 0, 21, 30),
              ),
                ]).toJson());
          },
          color: Colors.deepOrangeAccent,
        ),
        MaterialButton(onPressed: () {
          print(_communityController.myLifeDataList.length);
        },
        color: Colors.purpleAccent,)
      ],
    );
  }
}
