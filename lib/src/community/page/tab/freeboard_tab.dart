import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_example/src/community/controller/freeboard_controller.dart';
import 'package:firebase_example/src/community/page/detail_page/freeboard_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final FreeBoardController _freeBoardController = Get.put(FreeBoardController());

class FreeBoardTab extends StatefulWidget {
  @override
  _FreeBoardTabState createState() => _FreeBoardTabState();
}

class _FreeBoardTabState extends State<FreeBoardTab> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(
            () => _freeBoardController.dataList.isEmpty ? Center(child: CircularProgressIndicator()) : ListView.builder(
              itemCount: _freeBoardController.dataList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => FreeBoardDetailPage(
                        boardUid: _freeBoardController.dataList[index].key!,
                        title: _freeBoardController.dataList[index].title,
                        content: _freeBoardController.dataList[index].content,
                        writer: _freeBoardController.dataList[index].writer,
                        heartUid: _freeBoardController.dataList[index].key!,
                        imagePath: _freeBoardController.dataList[index].imagePath,
                      ));
                    },
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
                              Flexible(
                                child: Text(
                                  '${_freeBoardController.dataList[index].createAt}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Obx(() => _freeBoardController.heartList.contains(
                                      _freeBoardController.dataList[index].key)
                                  ? IconButton(
                                      icon: Icon(Icons.favorite),
                                      color: Colors.red,
                                      onPressed: () {
                                        _freeBoardController.minusHeartCount(
                                            _freeBoardController
                                                .dataList[index].key!);
                                        _freeBoardController.deleteHeartList(
                                            _freeBoardController
                                                .dataList[index].key!);
                                      })
                                  : IconButton(
                                      icon: Icon(Icons.favorite_border),
                                      onPressed: () {
                                        _freeBoardController.plusHeartCount(
                                            _freeBoardController
                                                .dataList[index].key!);
                                        _freeBoardController.addHeartList(
                                            _freeBoardController
                                                .dataList[index].key!);
                                      },
                                      color: Colors.red)),
                              Icon(
                                Icons.chat_bubble_outline,
                                color: Colors.blueAccent,
                              ),
                              Text('${_freeBoardController.dataList[index].comment}')
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
