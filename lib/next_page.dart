
import 'package:flutter/material.dart';


class NextPage extends StatelessWidget{
  NextPage(this.name);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('next page'),
      ),
      body: Container(
        child:
        Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Enter your username',
              ),
              autofocus: true,
            ),
            RaisedButton(
              child:
              Text('send'),
              onPressed:(){

            },
            )
          ],
        ),

      )
      ,

    );
  }

}