import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/add_memo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'category_list.dart';
import 'memo_detail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CookApp());
}

class CookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    CollectionReference memos = FirebaseFirestore.instance.collection('memos'); // QuerySna

    return Scaffold(
        appBar: AppBar(
          title: Text('メモ'),
          centerTitle: true,
          //右側のアイコン
          actions: [
            Row(
              children: [
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
          ],
            // 左側のアイコン
            leading: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(icon: Icon(Icons.tag),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CategoryList()),
                        );
                      }
                  ),
                ]
            ),
        ),

      body: StreamBuilder<QuerySnapshot>(
        stream: memos.orderBy('id').snapshots(),
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
                  subtitle:  Text(document.data()['category']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MemoDetail(document.id)),
                    );
                  },

                  // trailing: Text(document.data()['category']),
                );
              }).toList(),
            ),
          ),
        );
      },)
    );
  }
}
