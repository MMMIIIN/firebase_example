import 'package:firebase_example/src/community/controller/freeboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final FreeBoardController _freeBoardController = Get.put(FreeBoardController());

class FreeBoardTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          onPressed: () {
            _freeBoardController.dataList.clear();
            _freeBoardController.initLoadFreeBoardData();
          },
          color: Colors.indigo,
        ),
        Expanded(
          child: Obx(
            () => ListView.builder(
                itemCount: _freeBoardController.dataList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      height: context.mediaQuery.size.height * 0.1,
                      width: double.infinity,
                      decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                  '${_freeBoardController.dataList[index].title}'),
                              Text(
                                  '${_freeBoardController.dataList[index].createAt}')
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.favorite_border, color: Colors.red),
                              Icon(
                                Icons.chat_bubble_outline,
                                color: Colors.blueAccent,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
