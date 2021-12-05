class FreeBoardData {
  String? key;
  String title;
  String content;
  String writer;
  DateTime createAt;

  FreeBoardData(
      {this.key,
      required this.title,
      required this.content,
      required this.writer,
      required this.createAt});

  toJson() {
    return {
      'title': title,
      'content': content,
      'writer': writer,
      'createAt': createAt
    };
  }

  factory FreeBoardData.fromJson(Map<String, dynamic> json, String key) {
    return FreeBoardData(
      key: key,
        title: json['title'],
        content: json['content'],
        writer: json['writer'],
        createAt: json['createAt'].toDate());
  }
}
