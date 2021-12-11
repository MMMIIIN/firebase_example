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
  final recommentController = TextEditingController();
  var currentUid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                            _freeBoardController
                                .minusHeartCount(widget.heartUid);
                            _freeBoardController
                                .deleteHeartList(widget.heartUid);
                          })
                      : IconButton(
                          icon: Icon(Icons.favorite_border),
                          onPressed: () {
                            _freeBoardController
                                .plusHeartCount(widget.heartUid);
                            _freeBoardController.addHeartList(widget.heartUid);
                          },
                          color: Colors.red)),
                ],
              ),
              Obx(
                () => Expanded(
                  child: _freeBoardController.isCommentPage.value
                      ? commentWidget()
                      : Obx(
                          () => Column(
                            children: [
                              Container(
                                height: 50,
                                child: TextField(
                                  controller: commentController,
                                  decoration: InputDecoration(
                                      hintText: '공개 댓글 달기',
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.add_comment),
                                        onPressed: () {
                                          _freeBoardController.addComment(
                                              widget.heartUid,
                                              FreeBoardComment(
                                                  boardId: widget.boardUid,
                                                  writer: 'test writer',
                                                  comment: commentController
                                                      .value.text,
                                                  createAt: DateTime.now()
                                                      .toIso8601String(),
                                                  depth: 0));
                                          _freeBoardController.plusCommentCount(
                                              widget.heartUid);
                                          commentController.clear();
                                        },
                                      )),
                                ),
                              ),
                              SizedBox(height: 30),
                              Expanded(
                                child: ListView.builder(
                                  itemCount:
                                      _freeBoardController.commentList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all()),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '${_freeBoardController.commentList[index].writer}',
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        '${_freeBoardController.commentList[index].createAt.substring(0, 10)}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 12),
                                                      )
                                                    ],
                                                  ),
                                                  Text(
                                                    '${_freeBoardController.commentList[index].comment}',
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
                                              MaterialButton(
                                                onPressed: () {
                                                  _freeBoardController
                                                      .loadRecommentData(
                                                          widget.boardUid,
                                                          _freeBoardController
                                                              .commentList[
                                                                  index]
                                                              .key!);
                                                  setState(() {
                                                    _freeBoardController
                                                        .isCommentPage(true);
                                                  });
                                                  currentUid =
                                                      _freeBoardController
                                                          .commentList[index]
                                                          .key;
                                                },
                                                child: Text('답글 달기'),
                                              ),
                                            ],
                                          ),
                                          _freeBoardController
                                                      .commentList[index]
                                                      .recommentCount !=
                                                  0
                                              ? MaterialButton(
                                                  onPressed: () {
                                                    _freeBoardController
                                                        .loadRecommentData(
                                                            widget.boardUid,
                                                            _freeBoardController
                                                                .commentList[
                                                                    index]
                                                                .key!);
                                                    setState(() {
                                                      _freeBoardController
                                                          .isCommentPage(true);
                                                    });
                                                    currentUid =
                                                        _freeBoardController
                                                            .commentList[index]
                                                            .key;
                                                  },
                                                  child: Text(
                                                      '답글 ${_freeBoardController.commentList[index].recommentCount}개'),
                                                )
                                              : Container()
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget commentWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_outlined),
                onPressed: () {
                  _freeBoardController.isCommentPage(false);
                },
              ),
              Text('답글')
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 60,
            child: TextField(
              controller: recommentController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () {
                    _freeBoardController.addComment(
                      widget.boardUid,
                      FreeBoardComment(
                          boardId: widget.boardUid,
                          writer: 'writer',
                          comment: recommentController.value.text,
                          createAt: DateTime.now().toIso8601String(),
                          parentId: currentUid.toString(),
                          depth: 1),
                    );
                    recommentController.clear();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _freeBoardController.recommentList.length,
              itemBuilder: (context, index) {
                return Text(
                    '${_freeBoardController.recommentList[index].comment}');
              },
            ),
          ),
        ],
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
