import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_example/src/data.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  var testDataList = <TestData>[].obs;

  void addData(TestData testData) {
    FirebaseFirestore.instance.collection('data').add(testData.toJson());
  }

  readData() async {
    await FirebaseFirestore.instance
        .collection('data')
        .where('title', isEqualTo: 'mingwan')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print(element['memo']);
      });
    });
  }
}
