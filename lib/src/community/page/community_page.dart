import 'package:firebase_example/src/community/controller/community_controller.dart';
import 'package:firebase_example/src/community/page/add_community_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final CommunityController _communityController = Get.put(CommunityController());

class CommunityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.indigo,
                floating: true,
                flexibleSpace: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(),
                      Text(
                        'Community',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      IconButton(
                        icon: Icon(Icons.paste),
                        color: Colors.white,
                        onPressed: () {
                          Get.to(() => AddCommunityPage());
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SliverFixedExtentList(
                itemExtent: 100,
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  _communityController.dataList[index].title,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                _communityController.dataList[index].writer,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w200),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  _communityController.dataList[index].content,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                    '${_communityController.getDifferenceTime(_communityController.dataList[index].time)}'),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Icon(
                                      Icons.chat_bubble_outline,
                                      color: Colors.indigo,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: _communityController.dataList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
