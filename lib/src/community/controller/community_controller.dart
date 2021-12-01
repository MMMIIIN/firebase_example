import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_example/src/community/data/community_data.dart';
import 'package:get/get.dart';

class CommunityController extends GetxController {
  var dataList = <Data>[].obs;

  void initLoadDataList() async {
    dataList.clear();
    await FirebaseFirestore.instance
        .collection('community')
        .get()
        .then((value) {
      value.docs.forEach((data) {
        dataList.add(Data.fromJson(data.data()));
      });
    });
  }

  void addData(Data addData) async {
    await FirebaseFirestore.instance
        .collection('community')
        .add(addData.toJson());
  }

  String getDifferenceTime(DateTime _time) {
    var now = DateTime.now().add(Duration(minutes: 0, days: 0));
    if (now.difference(_time).inDays == 0) {
      if (now.difference(_time).inHours == 0) {
        return '${now.difference(_time).inMinutes}분 전';
      } else {
        return '${now.difference(_time).inHours}시간 전';
      }
    } else if (now.difference(_time).inDays < 30) {
      return '${now.difference(_time).inDays}일 전';
    } else if (now.difference(_time).inDays / 30 < 12) {
      return '${now.difference(_time).inDays ~/ 30}달 전';
    } else {
      return '${_time.toString().substring(0, 10)}';
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoadDataList();
  }
}
