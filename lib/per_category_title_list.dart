import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/add_memo.dart';

import 'add_memo.dart';
import 'memo_detail.dart';

class PerCategoryTitleList extends StatelessWidget{
  final categoryId;

  PerCategoryTitleList(this.categoryId);

  @override
  Widget build(BuildContext context) {

    CollectionReference memos = FirebaseFirestore.instance.collection('memos');

    return Scaffold(
      appBar: AppBar(
        title: Text('カテゴリ別タイトルリスト'),
        centerTitle: true,
        //右側のアイコン
        actions: [
          IconButton(icon: Icon(Icons.create_sharp),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddMemo()),
                );
              }
          ),
        ],

      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: memos.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return Center(
            child: Scaffold(
              body:  ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return  ListTile(
                    title:  Text(document.data()['title']),
                    subtitle:  Text(document.data()['memo']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MemoDetail(document.id)),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          );
        },
      )
      ,
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}

