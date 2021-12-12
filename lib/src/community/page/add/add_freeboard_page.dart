import 'package:firebase_example/src/community/controller/freeboard_controller.dart';
import 'package:firebase_example/src/community/data/free_board_data.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

final FreeBoardController _freeBoardController = Get.put(FreeBoardController());

class AddFreeBoardPage extends StatefulWidget {
  @override
  _AddFreeBoardPageState createState() => _AddFreeBoardPageState();
}

class _AddFreeBoardPageState extends State<AddFreeBoardPage> {
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  final _picker = ImagePicker();
  List<XFile> _pickedImgs = [];

  Future<void> _pickImg() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _pickedImgs = images;
      });
    }
  }

  Future<void> uploadImage() async {
    await FirebaseStorage.instance
        .ref('gs://example-f3334.appspot.com/')
        .child('test')
        .putFile(File(_pickedImgs[0].path))
        .then((img) => print(img.ref.fullPath));
  }

  Future _uploadFile(String imagePath) async {
    try {
      final firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('post')
          .child('${DateTime.now().millisecondsSinceEpoch}.png');

      final uploadTask = firebaseStorageRef.putFile(
          File(imagePath), SettableMetadata(contentType: 'image/png'));

      await uploadTask.whenComplete(() => null);

      final downloadUrl = await firebaseStorageRef.getDownloadURL();
      print(downloadUrl);
    } catch (e) {
      print(e);
    }
  }

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
                  _freeBoardController.uploadFile(
                      _pickedImgs[0].path,
                      AddFreeBoardDataDto(
                        title: titleController.value.text,
                        content: contentController.value.text,
                        writer: '익명',
                        createAt: DateTime.now().toIso8601String(),
                      ));
                  titleController.clear();
                  contentController.clear();
                  Get.back();
                },
                color: Colors.orange,
              ),
              MaterialButton(
                onPressed: () {
                  _pickImg();
                },
                child: Text('사진 선택'),
              ),
              MaterialButton(
                  onPressed: () {
                    // _uploadFile();
                  },
                  color: Colors.purpleAccent),
            ],
          ),
        ),
      ),
    );
  }
}
