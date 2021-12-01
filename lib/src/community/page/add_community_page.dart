import 'package:firebase_example/src/community/controller/community_controller.dart';
import 'package:firebase_example/src/community/data/community_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final CommunityController _communityController = Get.put(CommunityController());

class AddCommunityPage extends StatelessWidget {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80,
                child: TextField(
                  controller: _titleController,
                ),
              ),
              Container(
                height: 80,
                child: TextField(
                  controller: _contentController,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  _communityController.addData(Data(
                      _titleController.value.text, 'writer',
                      _contentController.value.text,
                      DateTime.now().toIso8601String(),
                    DateTime.now()
                  ));
                  Get.back();
                },
                color: Colors.indigo,
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
