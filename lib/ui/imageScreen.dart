import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wa_status_saver/ui/viewphotos.dart';

final Directory _photoDir =
    new Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

class ImageScreen extends StatefulWidget {
  @override
  ImageScreenState createState() => new ImageScreenState();
}

class ImageScreenState extends State<ImageScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!Directory("${_photoDir.path}").existsSync()) {
      return Center(
        child: Text(
          "Install WhatsApp\nYour Friend's Status Will Be Available Here",
          style: TextStyle(fontSize: 18.0),
        ),
      );
    } else {
      var imageList = _photoDir
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith(".jpg"))
          .toList(growable: false);
      if (imageList.length > 0) {
        return Container(
          margin: EdgeInsets.all(8.0),
          child: StaggeredGridView.countBuilder(
            itemCount: imageList.length,
            crossAxisCount: 4,
            itemBuilder: (context, index) {
              String imgPath = imageList[index];
              return Material(
                elevation: 8.0,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new ViewPhotos(imgPath)));
                  },
                  child: Hero(
                      tag: imgPath,
                      child: Image.file(
                        File(imgPath),
                        fit: BoxFit.cover,
                      )),
                ),
              );
            },
            staggeredTileBuilder: (i) =>
                StaggeredTile.count(2, i.isEven ? 2 : 3),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
        );
      } else {
        return Scaffold(
          body: Center(
            child: new Container(
                padding: EdgeInsets.only(bottom: 60.0),
                child: Text(
                  'Sorry, No Image Found!',
                  style: TextStyle(fontSize: 18.0),
                )),
          ),
        );
      }
    }
  }
}
