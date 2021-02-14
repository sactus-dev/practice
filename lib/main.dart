import 'package:flutter/material.dart';
import 'package:flutter_app/main_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),

        home: ChangeNotifierProvider<MainModel>(
          create: (_) => MainModel(),

          child: Scaffold(
              appBar: AppBar(
                title: Text('practice'),
              ),

            body: Consumer<MainModel>(
              builder: (context, model, child) {
                return Center(
                  child: Column(
                    children: [
                      Text(model.mainTitle,
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      RaisedButton(
                        child:
                        Text('button'),
                        onPressed: (){
                          model.changeText();
                        },
                      )
                    ],
                  ),
                );
              }
            )
          ),
        )
    );
  }
}
