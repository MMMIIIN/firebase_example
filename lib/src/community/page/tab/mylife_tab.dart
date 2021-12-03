import 'package:firebase_example/src/community/controller/community_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final CommunityController _communityController = Get.put(CommunityController());

class MyLifeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _communityController.myLifeDataList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(10),
                  height: 300,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${_communityController.myLifeDataList[index].title}',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '${_communityController.myLifeDataList[index].writer}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w200),
                          )
                        ],
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: PieChart(
                            PieChartData(
                              centerSpaceRadius: 40,
                              sections: List<PieChartSectionData>.generate(
                                _communityController
                                    .myLifeDataList[index].todos.length,
                                (todoIndex) {
                                  return PieChartSectionData(
                                      value: _communityController
                                          .myLifeDataList[index]
                                          .todos[todoIndex]
                                          .value
                                          .toDouble());
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                              '${_communityController.myLifeDataList[index].content}'),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
