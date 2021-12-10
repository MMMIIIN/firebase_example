import 'package:firebase_database/firebase_database.dart';

class FreeBoardComment {
  String? key;
  String boardId;
  String writer;
  String comment;
  String createAt;
  int depth;
  String parentId;
  bool isRecomment;
  int recommentCount;

  FreeBoardComment({
    required this.boardId,
    required this.writer,
    required this.comment,
    required this.createAt,
    required this.depth,
    this.parentId = '',
    this.isRecomment = false,
    this.recommentCount = 0,
  });

  toJson() {
    return {
      'boardId': boardId,
      'writer': writer,
      'comment': comment,
      'createAt': createAt,
      'depth': depth,
      'parentId': parentId
    };
  }

  FreeBoardComment.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        boardId = snapshot.value['boardId'],
        writer = snapshot.value['writer'],
        comment = snapshot.value['comment'],
        createAt = snapshot.value['createAt'],
        depth = snapshot.value['depth'],
        parentId = snapshot.value['parentId'],
        isRecomment = false,
        recommentCount = snapshot.value['recommentCount'] ?? 0;
}
