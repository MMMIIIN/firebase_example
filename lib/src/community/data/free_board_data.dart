import 'package:firebase_database/firebase_database.dart';

class FreeBoardData {
  String? key;
  String title;
  String content;
  String writer;
  String createAt;
  int heart;
  int comment;
  String? imagePath;

  FreeBoardData({
    this.key,
    required this.title,
    required this.content,
    required this.writer,
    required this.createAt,
    required this.heart,
    required this.comment,
    this.imagePath,
  });

  FreeBoardData.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value['title'],
        content = snapshot.value['content'],
        writer = snapshot.value['writer'],
        createAt = snapshot.value['createAt'],
        heart = snapshot.value['heart'],
        comment = snapshot.value['comment'],
        imagePath = snapshot.value['imagePath'] ?? '';
}

class AddFreeBoardDataDto {
  String title;
  String content;
  String writer;
  String createAt;
  int heart;
  int comment;
  String? imagePath;

  AddFreeBoardDataDto({
    required this.title,
    required this.content,
    required this.writer,
    required this.createAt,
    this.heart = 0,
    this.comment = 0,
    this.imagePath,
  });

  toJson() {
    return {
      'title': title,
      'content': content,
      'writer': writer,
      'createAt': createAt,
      'heart': heart,
      'comment': comment,
      'imagePath': imagePath,
    };
  }
}
