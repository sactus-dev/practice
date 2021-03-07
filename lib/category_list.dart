import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/add_memo.dart';
import 'package:flutter_app/per_category_title_list.dart';

import 'add_memo.dart';

class CategoryList extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    CollectionReference categories = FirebaseFirestore.instance.collection('categories');

    return Scaffold(
      appBar: AppBar(
        title: Text('カテゴリ一覧'),
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
        stream: categories.snapshots(),
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
                    title:  Text(document.data()['name']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PerCategoryTitleList(document.data()['id']),
                      ));
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

