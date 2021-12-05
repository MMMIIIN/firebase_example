import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_example/src/community/data/free_board_data.dart';
import 'package:get/get.dart';

class FreeBoardController extends GetxController {
  var dataList = <FreeBoardData>[].obs;

  void initLoadFreeBoardData() async {
    await FirebaseFirestore.instance
        .collection('FREE_BOARD')
        .get()
        .then((value) => value.docs.forEach((data) {
              dataList.add(FreeBoardData.fromJson(data.data(), data.id));
            }));
  }

  void addFreeBoardData(FreeBoardData freeBoardData) async {
    await FirebaseFirestore.instance
        .collection('FREE_BOARD')
        .add(freeBoardData.toJson()).then((value) => dataList.add(freeBoardData));
  }
}
