import 'package:firebase_database/firebase_database.dart';

class FreeBoardData {
  String? key;
  String title;
  String content;
  String writer;
  String createAt;
  int heart;
  int comment;

  FreeBoardData(
      {this.key,
      required this.title,
      required this.content,
      required this.writer,
      required this.createAt,
      required this.heart,
      required this.comment});

  factory FreeBoardData.fromJson(Map<String, dynamic> json, String key) {
    return FreeBoardData(
        key: key,
        title: json['title'],
        content: json['content'],
        writer: json['writer'],
        createAt: json['createAt'].toString(),
        heart: json['heart'],
        comment: json['comment']);
  }

  FreeBoardData.fromSnapshot(DataSnapshot snapshot) : key = snapshot.key,
  title = snapshot.value['title'],
  content = snapshot.value['content'],
  writer = snapshot.value['writer'],
  createAt = snapshot.value['createAt'],
  heart = snapshot.value['heart'],
  comment = snapshot.value['comment'];
}

class AddFreeBoardDataDto {
  String title;
  String content;
  String writer;
  String createAt;
  int heart;
  int comment;

  AddFreeBoardDataDto(
      {required this.title,
      required this.content,
      required this.writer,
      required this.createAt,
      this.heart = 0,
      this.comment = 0});

  toJson() {
    return {
      'title': title,
      'content': content,
      'writer': writer,
      'createAt': createAt,
      'heart': heart,
      'comment': comment
    };
  }
}
