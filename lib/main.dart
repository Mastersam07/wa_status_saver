import 'package:flutter/material.dart';
import 'package:wa_status_saver/ui/dashboard.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('Savvy'),
            backgroundColor: Colors.blueGrey[100],
          ),
          body: Dashboard(),
          backgroundColor: Colors.blueGrey[100],
        ),
      ),
    );
