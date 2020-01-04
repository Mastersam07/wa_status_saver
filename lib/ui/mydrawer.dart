import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyNavigationDrawer extends StatelessWidget {
  String version = '0.0.1';

  _launchPlayURL() async {
    const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Colors.green),
          accountName: Text(
            'Status Saver',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          accountEmail: Text('Version: $version'),
          currentAccountPicture: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/images/logo.png'),
              ),
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: IconTheme(
                data: new IconThemeData(color: Color(0xff757575)),
                child: Icon(Icons.photo_library)),
            title: Text('Photos'),
            onTap: () {},
          ),
        ),
        Card(
          child: ListTile(
            leading: IconTheme(
                data: new IconThemeData(color: Color(0xff757575)),
                child: Icon(Icons.video_library)),
            title: Text('Videos'),
            onTap: () {},
          ),
        ),
        Card(
          child: ListTile(
            leading: IconTheme(
                data: new IconThemeData(color: Color(0xff757575)),
                child: Icon(Icons.thumb_up)),
            title: Text('Rate Us'),
            onTap: () {
              _launchPlayURL();
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: IconTheme(
                data: new IconThemeData(color: Color(0xff757575)),
                child: Icon(Icons.settings)),
            title: Text('Settings'),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
