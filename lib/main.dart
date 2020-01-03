import 'package:flutter/material.dart';
import 'package:wa_status_saver/ui/dashboard.dart';
import 'package:wa_status_saver/ui/mydrawer.dart';
import 'package:share/share.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => _scaffoldKey.currentState.openDrawer()),
            title: Text('Status Saver'),
            backgroundColor: Colors.green,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.share), onPressed: (){
                Share.share('check out my wa status downloader https://mastersam.io', subject: 'Look what I made!');
              }),
              IconButton(icon: Icon(Icons.help_outline), onPressed: () {})
            ],
          ),
          body: Dashboard(),
          backgroundColor: Colors.blueGrey[100],
          drawer: Drawer(
            child: MyNavigationDrawer(),
          ),
        ),
      ),
    );
