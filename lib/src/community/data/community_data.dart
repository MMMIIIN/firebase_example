class Data {
  String? key;
  String title;
  String writer;
  String content;
  String createTime;
  DateTime time;

  Data(this.title, this.writer, this.content, this.createTime, this.time);

  toJson() {
    return {
      'title': title,
      'writer': writer,
      'content': content,
      'createTime': createTime
    };
  }

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        json['title'],
        json['writer'],
        json['content'],
        json['createTime'],
        DateTime(
          int.parse(json['createTime'].toString().substring(0, 4)),
          int.parse(json['createTime'].toString().substring(5, 7)),
          int.parse(json['createTime'].toString().substring(8, 10)),
          int.parse(json['createTime'].toString().substring(11, 13)),
          int.parse(json['createTime'].toString().substring(14, 16)),
        ),
      );
}
