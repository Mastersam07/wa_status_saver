import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => new DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: TabBarView(
        children: [
          Icon(Icons.photo),
          Icon(Icons.movie)
        ],
      ),
    );
  }
}
