import 'package:firebase_example/src/community/controller/community_controller.dart';
import 'package:firebase_example/src/community/page/tab/freeboard_tab.dart';
import 'package:firebase_example/src/community/page/tab/motivation_tab.dart';
import 'package:firebase_example/src/community/page/tab/mylife_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final CommunityController _communityController = Get.put(CommunityController());

class CommunityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0,
        title: Obx(
          () => Text(
              '${COMMUNITY_LIST.values[_communityController.communityTabIndex.value].communityName}'),
        ),
      ),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: COMMUNITY_LIST.values.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              _communityController.communityTabIndex(index);
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerLeft,
              height: 50,
              child: Text(
                '${COMMUNITY_LIST.values[index].communityName}',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        switch (_communityController.communityTabIndex.value) {
          case 0:
            return FreeBoardTab();
          case 1:
            return MyLifeTab();
          case 2:
            return MotivationTab();
        }
        return Container();
      }),
      // child: Obx(
      //   () => CustomScrollView(
      //     slivers: [
      //       SliverAppBar(
      //         backgroundColor: Colors.indigo,
      //         floating: true,
      //         flexibleSpace: Center(
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
      //             children: [
      //               SizedBox(),
      //               Text(
      //                 'Community',
      //                 style: TextStyle(fontSize: 20, color: Colors.white),
      //               ),
      //               IconButton(
      //                 icon: Icon(Icons.paste),
      //                 color: Colors.white,
      //                 onPressed: () {
      //                   Get.to(() => AddCommunityPage());
      //                 },
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       SliverFixedExtentList(
      //         itemExtent: 100,
      //         delegate: SliverChildBuilderDelegate(
      //           (context, index) => customList(index),
      //           childCount: _communityController.dataList.length,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget customList(int index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    '${_communityController.getDifferenceTime(_communityController.dataList[index].createTime)}'),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.redAccent,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
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
  }
}
