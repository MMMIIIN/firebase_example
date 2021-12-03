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
  int value;

  Todo(
      {required this.title,
        required this.color,
        required this.dateTime,
        required this.timeOfRange,
        required this.value
      });

  toJson() {
    return {
      'title': title,
      'color': color,
      'dateTime': dateTime,
      'timeOfRange': timeOfRange.toJson()
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    var date1 = DateTime(
        2021,
        1,
        1,
        json['timeOfRange']['startHour'],
      json['timeOfRange']['startMinute']);
    var date2 = DateTime(
        2021,
        1,
        1,
        json['timeOfRange']['endHour'],
      json['timeOfRange']['endMinute']);
    var value = date2.difference(date1).inMinutes;
    if(value < 0) {
      value += 1440;
    }

    return Todo(
      title: json['title'],
      color: json['color'],
      dateTime: json['dateTime'].toDate(),
      timeOfRange: TimeOfRange.fromJson(json['timeOfRange']),
      value: value
    );
  }
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
