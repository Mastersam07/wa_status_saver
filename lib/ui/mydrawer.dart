import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class MyNavigationDrawer extends StatelessWidget {
  final String version = '0.3+2';

  _launchURL() async {
    const url = 'https://github.com/Mastersam07/wa_status_saver';
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
          decoration: BoxDecoration(color: Colors.teal),
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
                child: Icon(Icons.perm_media)),
            title: Text('Downloaded Status'),
            onTap: () {},
          ),
        ),
        Card(
          child: ListTile(
            leading: IconTheme(
                data: new IconThemeData(color: Color(0xff757575)),
                child: Icon(Icons.info)),
            title: Text('About Us'),
            onTap: () {},
          ),
        ),
        Card(
          child: ListTile(
            leading: IconTheme(
                data: new IconThemeData(color: Color(0xff757575)),
                child: Icon(Icons.rate_review)),
            title: Text('Rate Us'),
            onTap: () {
              _launchURL();
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: IconTheme(
                data: new IconThemeData(color: Color(0xff757575)),
                child: Icon(Icons.share)),
            title: Text('Share With Friends'),
            onTap: () {
              Share.share(
                  'check out my wa status downloader https://bit.ly/wa_status_downloader',
                  subject: 'Look what I made!');
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
