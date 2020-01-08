import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wa_status_saver/utils/video_controller.dart';

class PlayStatus extends StatefulWidget {
  final String videoFile;
  PlayStatus(this.videoFile);
  @override
  _PlayStatusState createState() => new _PlayStatusState();
}

class _PlayStatusState extends State<PlayStatus> {

  @override
  void initState() {
    super.initState();
    print('Video file you are looking for:'+widget.videoFile);
  }

  void dispose() {
    super.dispose();
  }

  void _onLoading(bool t,String str){
    if(t){
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context){
            return SimpleDialog(
              children: <Widget>[
                Center(
                  child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: CircularProgressIndicator()),
                ),
              ],
            );
          }
      );
    }else{
      Navigator.pop(context);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SimpleDialog(
                children: <Widget>[
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          Text("Great, Saved in Gallary", style: TextStyle(
                              fontSize:20,
                              fontWeight: FontWeight.bold
                          ),
                          ),
                          Padding(padding: EdgeInsets.all(10.0),),
                          Text(str,style:TextStyle( fontSize:16.0, )),
                          Padding(padding: EdgeInsets.all(10.0),),
                          Text("FileManager > Downloaded Status",style:TextStyle( fontSize:16.0, color: Colors.teal )),
                          Padding(padding: EdgeInsets.all(10.0),),
                          MaterialButton(
                            child: Text("Close"),
                            color:Colors.teal,
                            textColor: Colors.white,
                            onPressed:  ()=> Navigator.pop(context),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.indigo,
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: ()=> Navigator.of(context).pop(),
        ),
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
          child:  FlatButton.icon(
            color:Colors.indigo,
            textColor: Colors.white,
            icon: Icon(Icons.file_download),
            padding: EdgeInsets.all(10.0),
            label: Text('Download', style: TextStyle(
                fontSize:16.0
            ),), //`Text` to display
            onPressed: () async{
              _onLoading(true,"");

              File originalVideoFile = File(widget.videoFile);
              Directory directory = await getExternalStorageDirectory();
              if(!Directory("${directory.path}/Downloaded Status/Videos").existsSync()){
                Directory("${directory.path}/Downloaded Status/Videos").createSync(recursive: true);
              }
              String path = directory.path;
              String curDate = DateTime.now().toString();
              String newFileName = "$path/Downloaded Status/Videos/VIDEO-$curDate.mp4";
              print(newFileName);
              await originalVideoFile.copy(newFileName);

              _onLoading(false,"If Video not available in gallary\n\nYou can find all videos at");
            },
          ),
        ),
      ),
      body: Container(
        child: StatusVideo(
          videoPlayerController: VideoPlayerController.file(File(widget.videoFile)),
          looping: true,
          videoSrc: widget.videoFile,
        ),
      ),
    );
  }
}