import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_example/src/community/controller/freeboard_controller.dart';
import 'package:firebase_example/src/community/data/free_board_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final FreeBoardController _freeBoardController = Get.put(FreeBoardController());

class FreeBoardTab extends StatefulWidget {
  @override
  _FreeBoardTabState createState() => _FreeBoardTabState();
}

class _FreeBoardTabState extends State<FreeBoardTab> {
  FirebaseDatabase? _database;
  DatabaseReference? reference;
  DatabaseReference? heartListReference;
  String _databaseURL = 'https://example-f3334-default-rtdb.firebaseio.com/';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _database = FirebaseDatabase(databaseURL: _databaseURL);
    // reference = _database!.reference().child('FREE_BOARD');
    // heartListReference =
    //     _database!.reference().child('HEART_LIST').child('uid');
    //
    // reference!.onChildAdded.listen((event) {
    //   setState(() {
    //     _freeBoardController.dataList
    //         .add(FreeBoardData.fromSnapshot(event.snapshot));
    //   });
    // });

    // heartListReference!.onChildAdded.listen((event) {
    //   setState(() {
    //     _freeBoardController.heartList.add(event.snapshot.key);
    //   });
    // });
    //
    // heartListReference!.onChildRemoved.listen((event) {
    //   setState(() {
    //     _freeBoardController.heartList.remove(event.snapshot.key);
    //   });
    // });
  }

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
        MaterialButton(
          onPressed: () {
            _freeBoardController.plusHeartCount('uid');
          },
          color: Colors.orange,
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
                            )
                          ],
                        )
                      ],
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
