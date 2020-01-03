import 'package:flutter/material.dart';


class MyNavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text('Status Saver'),
          decoration: BoxDecoration(
            color: Colors.green,
            // image: DecorationImage(fit: BoxFit.contain ,image: AssetImage('assets/images/logo.png'))
          ),
        ),
        Card(
          child: ListTile(
            leading: IconTheme(data: new IconThemeData(color: Color(0xff757575)),
                child: Icon(Icons.photo)),
            title: Text('Photos'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: IconTheme(data: new IconThemeData(color: Color(0xff757575)),
                child: Icon(Icons.movie)),
            title: Text('Videos'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: IconTheme(data: new IconThemeData(color: Color(0xff757575)),
                child: Icon(Icons.thumb_up)),
            title: Text('Rate Us'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: IconTheme(data: new IconThemeData(color: Color(0xff757575)),
                child: Icon(Icons.settings)),
            title: Text('Settings'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ),
      ],
    );
  }
}
