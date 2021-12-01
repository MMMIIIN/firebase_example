class Data {
  String? key;
  String title;
  String writer;
  String content;
  DateTime createTime;

  Data(this.title, this.writer, this.content, this.createTime);

  toJson() {
    return {
      'title': title,
      'writer': writer,
      'content': content,
      'createTime': createTime
    };
  }

  factory Data.fromJson(Map<String, dynamic> json) => Data(json['title'],
      json['writer'], json['content'], json['createTime'].toDate());
}
