import 'package:flutter/material.dart';
import 'imageScreen.dart';
import 'videoScreen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: [
        ImageScreen(),
        VideoScreen(),
      ],
    );
  }
}
