class TestData {
  String? key;
  String title;
  String memo;
  String createTime;

  TestData(this.title, this.memo, this.createTime);

  toJson() {
    return {
      'title': title,
      'memo': memo,
      'createTime': createTime
    };
  }
}