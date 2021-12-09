import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_example/src/community/data/free_board_comment_data.dart';
import 'package:firebase_example/src/community/data/free_board_data.dart';
import 'package:get/get.dart';

class FreeBoardController extends GetxController {
  var dataList = <FreeBoardData>[].obs;
  var heartList = [].obs;
  var commentList = <FreeBoardComment>[].obs;

  FirebaseDatabase? _database;
  DatabaseReference? reference;
  DatabaseReference? heartListReference;
  String _databaseURL = 'https://example-f3334-default-rtdb.firebaseio.com/';

  void plusHeartCount(String uid) async {
    var currentCount = 0;
    await FirebaseDatabase.instance
        .reference()
        .child('FREE_BOARD')
        .child(uid)
        .once()
        .then((value) {
      currentCount = value.value['heart'];
    });
    await FirebaseDatabase.instance
        .reference()
        .child('FREE_BOARD')
        .child(uid)
        .update({'heart': ++currentCount});
  }

  void minusHeartCount(String uid) async {
    var currentCount = 0;
    await FirebaseDatabase.instance
        .reference()
        .child('FREE_BOARD')
        .child(uid)
        .once()
        .then((value) {
      currentCount = value.value['heart'];
    });

    await FirebaseDatabase.instance
        .reference()
        .child('FREE_BOARD')
        .child(uid)
        .update({'heart': --currentCount});
  }

  void addFreeBoardData(AddFreeBoardDataDto _data) async {
    await FirebaseDatabase.instance
        .reference()
        .child('FREE_BOARD')
        .push()
        .set(_data.toJson());
  }

  void addHeartList(String uid) async {
    await FirebaseDatabase.instance
        .reference()
        .child('HEART_LIST')
        .child('uid')
        .child(uid)
        .set({
      '$uid': uid,
    }).then((value) {
      heartList.add(uid);
    });
  }

  void deleteHeartList(String uid) async {
    await FirebaseDatabase.instance
        .reference()
        .child('HEART_LIST')
        .child('uid')
        .child(uid)
        .remove()
        .then((value) {
      heartList.removeWhere((element) => element == uid);
    });
  }

  void addComment(String uid, FreeBoardComment comment) async {
    await FirebaseDatabase.instance
        .reference()
        .child('FREE_BOARD')
        .child(uid)
        .child('comment_list')
        .push()
        .set(comment.toJson());
  }

  void loadCommentList(String uid) {
    commentList.clear();
    FirebaseDatabase.instance
        .reference()
        .child('FREE_BOARD')
        .child(uid)
        .child('comment_list')
        .onChildAdded
        .listen((event) {
      commentList.add(FreeBoardComment.fromSnapshot(event.snapshot));
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database!.reference().child('FREE_BOARD');
    heartListReference =
        _database!.reference().child('HEART_LIST').child('uid');

    reference!.onChildAdded.listen((event) {
      dataList.add(FreeBoardData.fromSnapshot(event.snapshot));
    });

    heartListReference!.onChildAdded.listen((event) {
      heartList.add(event.snapshot.key);
    });
  }
}
