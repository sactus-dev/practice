

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MemoDetail extends StatelessWidget {
  final documentId;

  MemoDetail(this.documentId);


  @override
  Widget build(BuildContext context) {
    CollectionReference memos = FirebaseFirestore.instance.collection('memos');

    return FutureBuilder<DocumentSnapshot>(
      future: memos.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Center(
              child: Scaffold(
                  appBar: AppBar(
                      title: Text("${data['title']}")
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("${data['memo']}"),
                  )
              )
          );
        }

        return Center(
          child: Scaffold(
              appBar: AppBar(
                title: Text('メモ内容'),
              ),
              body: Text("loading")),
        );
      },
    );
  }
}