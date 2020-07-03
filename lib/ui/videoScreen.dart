import 'package:flutter/material.dart';
import 'dart:io';
import 'package:thumbnails/thumbnails.dart';
import 'package:wa_status_saver/utils/video_play.dart';

final Directory _videoDir =
    new Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

class VideoScreen extends StatefulWidget {
  @override
  VideoScreenState createState() => new VideoScreenState();
}

class VideoScreenState extends State<VideoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!Directory("${_videoDir.path}").existsSync()) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Install WhatsApp\n",
            style: TextStyle(fontSize: 18.0),
          ),
          Text(
            "Your Friend's Status Will Be Available Here",
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      );
    } else {
      return VideoGrid(directory: _videoDir);
    }
  }
}

class VideoGrid extends StatefulWidget {
  final Directory directory;

  const VideoGrid({Key key, this.directory}) : super(key: key);

  @override
  _VideoGridState createState() => _VideoGridState();
}

class _VideoGridState extends State<VideoGrid> {
  _getImage(videoPathUrl) async {
    //await Future.delayed(Duration(milliseconds: 500));
    String thumb = await Thumbnails.getThumbnail(
        videoFile: videoPathUrl,
        imageType:
            ThumbFormat.PNG, //this image will store in created folderpath
        quality: 10);
    return thumb;
  }

  @override
  Widget build(BuildContext context) {
    var videoList = widget.directory
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith(".mp4"))
        .toList(growable: false);

    if (videoList != null) {
      if (videoList.length > 0) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: GridView.builder(
            itemCount: videoList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1.0,
              mainAxisSpacing: 8.0,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new PlayStatus(videoList[index])),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        // Where the linear gradient begins and ends
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        // Add one stop for each color. Stops should increase from 0 to 1
                        stops: [0.1, 0.3, 0.5, 0.7, 0.9],
                        colors: [
                          // Colors are easy thanks to Flutter's Colors class.
                          Color(0xffb7d8cf),
                          Color(0xffb7d8cf),
                          Color(0xffb7d8cf),
                          Color(0xffb7d8cf),
                          Color(0xffb7d8cf),
                        ],
                      ),
                    ),
                    child: FutureBuilder(
                        future: _getImage(videoList[index]),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              return Hero(
                                tag: videoList[index],
                                child: Image.file(
                                  File(snapshot.data),
                                  fit: BoxFit.cover,
                                ),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          } else {
                            return Hero(
                              tag: videoList[index],
                              child: Container(
                                height: 280.0,
                                child: Image.asset(
                                    "assets/images/video_loader.gif"),
                              ),
                            );
                          }
                        }),
                    //new cod
                  ),
                ),
              );
            },
          ),
        );
      } else {
        return Center(
          child: Text(
            "Sorry, No Videos Found.",
            style: TextStyle(fontSize: 18.0),
          ),
        );
      }
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
