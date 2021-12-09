import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_example/src/community/controller/freeboard_controller.dart';
import 'package:firebase_example/src/community/data/free_board_comment_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final FreeBoardController _freeBoardController = Get.put(FreeBoardController());

class FreeBoardDetailPage extends StatefulWidget {
  String boardUid;
  String title;
  String content;
  String writer;
  String heartUid;

  FreeBoardDetailPage({
    required this.boardUid,
    required this.title,
    required this.content,
    required this.writer,
    required this.heartUid,
  });

  @override
  _FreeBoardDetailPageState createState() => _FreeBoardDetailPageState();
}

class _FreeBoardDetailPageState extends State<FreeBoardDetailPage> {
  final commentController = TextEditingController();
  var commentStyle = TextStyle(fontSize: 20);
  var writerStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w200);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '${widget.title}',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '${widget.writer}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
                ),
              ],
            ),
            Text(
              '${widget.content}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
            ),
            Row(
              children: [
                Obx(() => _freeBoardController.heartList
                        .contains(widget.heartUid)
                    ? IconButton(
                        icon: Icon(Icons.favorite),
                        color: Colors.red,
                        onPressed: () {
                          _freeBoardController.minusHeartCount(widget.heartUid);
                          _freeBoardController.deleteHeartList(widget.heartUid);
                        })
                    : IconButton(
                        icon: Icon(Icons.favorite_border),
                        onPressed: () {
                          _freeBoardController.plusHeartCount(widget.heartUid);
                          _freeBoardController.addHeartList(widget.heartUid);
                        },
                        color: Colors.red)),
              ],
            ),
            Container(
              height: 50,
              child: TextField(
                controller: commentController,
                decoration: InputDecoration(
                    hintText: '댓글 달기',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add_comment),
                      onPressed: () {
                        _freeBoardController.addComment(
                            widget.heartUid,
                            FreeBoardComment(
                                boardId: widget.boardUid,
                                writer: 'test writer',
                                comment: commentController.value.text,
                                createAt: DateTime.now().toIso8601String(),
                                depth: 0));
                        commentController.clear();
                      },
                    )),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                // print(commentList.length);
              },
              color: Colors.orangeAccent,
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: _freeBoardController.commentList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all()),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                          '${_freeBoardController.commentList[index].writer}',
                                          style: writerStyle),
                                      SizedBox(width: 10),
                                      Text(
                                        '${_freeBoardController.commentList[index].createAt.substring(0, 10)}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                        fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Text(
                                      '${_freeBoardController.commentList[index].comment}',
                                      style: commentStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                              ),
                              Text('답글 달기'),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _freeBoardController.loadCommentList(widget.heartUid);
  }
}
