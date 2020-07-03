import 'package:flutter/material.dart';
import 'package:wa_status_saver/ui/dashboard.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class MyHome extends StatelessWidget {
  final html =
      "<h3><b>How To Use?</b></h3><p>- Check the Desired Status/Story...</p><p>- Come Back to App, Click on any Image or Video to View...</p><p>- Click the Save Button...<br />The Image/Video is Instantly saved to your Galery :)</p><p>- You can also Use Multiple Saving. [to do]</p>";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status Saver'),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.lightbulb_outline),
              onPressed: () {
                AdaptiveTheme.of(context).toggleThemeMode();
              }),
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
        bottom: TabBar(tabs: [
          Container(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'IMAGES',
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'VIDEOS',
            ),
          ),
        ]),
      ),
      body: Dashboard(),
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.about) {
      print('About App');
    } else if (choice == Constants.rate) {
      print('Rate App');
    } else if (choice == Constants.share) {
      print('Share with friends');
    }
  }
}

class Constants {
  static const String about = 'About App';
  static const String rate = 'Rate App';
  static const String share = 'Share with friends';

  static const List<String> choices = <String>[about, rate, share];
}