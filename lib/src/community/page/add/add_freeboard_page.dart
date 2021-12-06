import 'package:firebase_example/src/community/controller/freeboard_controller.dart';
import 'package:firebase_example/src/community/data/free_board_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final FreeBoardController _freeBoardController = Get.put(FreeBoardController());

class AddFreeBoardPage extends StatelessWidget {
  var titleController = TextEditingController();
  var contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                child: TextField(
                  controller: titleController,
                ),
              ),
              Container(
                height: 100,
                width: double.infinity,
                child: TextField(
                  controller: contentController,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  _freeBoardController.addFreeBoardData(AddFreeBoardDataDto(
                      title: titleController.value.text,
                      content: contentController.value.text,
                      writer: '익명',
                      createAt: DateTime.now().toIso8601String()));
                  titleController.clear();
                  contentController.clear();
                  Get.back();
                },
                color: Colors.orange,
              )
            ],
          ),
        ),
      ),
    );
  }
}
