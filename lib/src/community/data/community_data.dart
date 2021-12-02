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

class MyLifeData {
  String title;
  DateTime createTime;
  String writer;
  String content;
  List<Todo> todos;

  MyLifeData(
      this.title, this.createTime, this.writer, this.content, this.todos);

  toJson() {
    return {
      'title': title,
      'createTime': createTime,
      'writer': writer,
      'content': content,
      'todos': todos.map((i) => i.toJson()).toList()
    };
  }

  factory MyLifeData.fromJson(Map<String, dynamic> json) {
    var list = json['todos'] as List;
    List<Todo> dataList = list.map((i) => Todo.fromJson(i)).toList();
    return MyLifeData(json['title'], json['createTime'].toDate(), json['writer'],
        json['content'], dataList);
  }
}

class Todo {
  String title;
  int color;
  DateTime dateTime;
  TimeOfRange timeOfRange;

  Todo(this.title, this.color, this.dateTime, this.timeOfRange);

  toJson() {
    return {
      'title': title,
      'color': color,
      'dateTime': dateTime,
      'timeOfRange': timeOfRange.toJson()
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        json['title'],
        json['color'],
        json['dateTime'].toDate(),
        TimeOfRange.fromJson(json['timeOfRange']),
      );
}

class TimeOfRange {
  int startHour;
  int startMinute;
  int endHour;
  int endMinute;

  TimeOfRange(this.startHour, this.startMinute, this.endHour, this.endMinute);

  toJson() {
    return {
      'startHour': startHour,
      'startMinute': startMinute,
      'endHour': endHour,
      'endMinute': endMinute,
    };
  }

  factory TimeOfRange.fromJson(Map<String, dynamic> json) => TimeOfRange(
      json['startHour'],
      json['startMinute'],
      json['endHour'],
      json['endMinute']);
}
