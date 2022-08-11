import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);
  final html =
      '<h3><b>How To Use?</b></h3><p>- Check the Desired Status/Story...</p><p>- Come Back to App, Click on any Image or Video to View...</p><p>- Click the Save Button...<br />The Image/Video is Instantly saved to your Galery :)</p><p>- You can also Use Multiple Saving. [to do]</p>';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status Saver'),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.lightbulb_outline),
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
            padding: const EdgeInsets.all(12.0),
            child: const Text(
              'IMAGES',
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12.0),
            child: const Text(
              'VIDEOS',
            ),
          ),
        ]),
      ),
      body: const Dashboard(),
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.about) {
    } else if (choice == Constants.rate) {
    } else if (choice == Constants.share) {}
  }
}

class Constants {
  static const String about = 'About App';
  static const String rate = 'Rate App';
  static const String share = 'Share with friends';

  static const List<String> choices = <String>[about, rate, share];
}
