

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
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
                  body: Text("${data['full_name']}")
              )
          );
        }

        return Center(
          child: Scaffold(
              appBar: AppBar(
                title: Text('practice'),
              ),
              body: Text("loading")),
        );
      },
    );
  }
}