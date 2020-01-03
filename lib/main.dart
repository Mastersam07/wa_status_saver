import 'package:flutter/material.dart';
import 'package:wa_status_saver/ui/dashboard.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.menu),
            title: Text('Status Saver'),
            backgroundColor: Colors.green[10],
            actions: <Widget>[
              IconButton(icon: Icon(Icons.share), onPressed: (){}),
              IconButton(icon: Icon(Icons.help_outline), onPressed: (){})
            ],
          ),
          body: Dashboard(),
          backgroundColor: Colors.blueGrey[100],
        ),
      ),
    );
