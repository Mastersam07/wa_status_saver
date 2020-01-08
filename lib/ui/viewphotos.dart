import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter_fab_dialer/flutter_fab_dialer.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart' as eshare;

class ViewPhotos extends StatefulWidget {
  final String imgPath;
  ViewPhotos(this.imgPath);

  @override
  _ViewPhotosState createState() => _ViewPhotosState();
}

class _ViewPhotosState extends State<ViewPhotos> {
  var filePath;
  final String imgShare="Image.file(File(widget.imgPath),)";

  Future<void> _shareImage() async {
    try {
      final ByteData bytes = await rootBundle.load(
        "Image.file(File(widget.imgPath),)",
      );
      await eshare.Share.file(
        'esys image',
        'esys.png',
        bytes.buffer.asUint8List(),
        imgShare,
      );
    } catch (e) {
      print('error: $e');
    }
  }

  final LinearGradient backgroundGradient = new LinearGradient(
    colors: [
      Color(0x00000000),
      Color(0x00333333),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  void _onLoading(bool t, String str) {
    if (t) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SimpleDialog(
              children: <Widget>[
                Center(
                  child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: CircularProgressIndicator()),
                ),
              ],
            );
          });
    } else {
      Navigator.pop(context);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SimpleDialog(
                children: <Widget>[
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Great, Saved in Gallary",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          Text(str,
                              style: TextStyle(
                                fontSize: 16.0,
                              )),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          Text("FileManager > Downloaded Status",
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.teal)),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          MaterialButton(
                            child: Text("Close"),
                            color: Colors.teal,
                            textColor: Colors.white,
                            onPressed: () => Navigator.pop(context),
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
    //The list of FabMiniMenuItems that we are going to use
    var _fabMiniMenuItemList = [
      new FabMiniMenuItem.withText(
          new Icon(Icons.sd_storage), Colors.teal, 4.0, "Button menu",
          () async {
        _onLoading(true, "");
//                File originalImageFile1 = File(widget.imgPath);
//
//                Directory directory = await getExternalStorageDirectory();
//                if(!Directory("${directory.path}/Downloaded Status/Images").existsSync()){
//                  Directory("${directory.path}/Downloaded Status/Images").createSync(recursive: true);
//                }
//                String path = directory.path;
//                String curDate = DateTime.now().toString();
//                String newFileName = "$path/Downloaded Status/Images/IMG-$curDate.jpg";
//                print(newFileName);
//                await originalImageFile1.copy(newFileName);

        Uri myUri = Uri.parse(widget.imgPath);
        File originalImageFile = new File.fromUri(myUri);
        Uint8List bytes;
        await originalImageFile.readAsBytes().then((value) {
          bytes = Uint8List.fromList(value);
          print('reading of bytes is completed');
        }).catchError((onError) {
          print('Exception Error while reading audio from path:' +
              onError.toString());
        });
        final result =
            await ImageGallerySaver.saveImage(Uint8List.fromList(bytes));
        print(result);
        _onLoading(false,
            "If Image not available in gallary\n\nYou can find all images at");
      }, "Save", Colors.black, Colors.white, true),
      new FabMiniMenuItem.withText(
          new Icon(Icons.share), Colors.teal, 4.0, "Button menu", () {
        _shareImage();
      }, "Share", Colors.black, Colors.white, true),
      new FabMiniMenuItem.withText(new Icon(Icons.reply), Colors.teal, 4.0,
          "Button menu", () {}, "Repost", Colors.black, Colors.white, true),
      new FabMiniMenuItem.withText(new Icon(Icons.wallpaper), Colors.teal, 4.0,
          "Button menu", () {}, "Set As", Colors.black, Colors.white, true),
      new FabMiniMenuItem.withText(
          new Icon(Icons.delete_outline),
          Colors.teal,
          4.0,
          "Button menu",
          () {},
          "Delete",
          Colors.black,
          Colors.white,
          true),
    ];

    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.indigo,
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Hero(
                tag: widget.imgPath,
                child: Image.file(
                  File(widget.imgPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            new FabDialer(
                _fabMiniMenuItemList, Colors.teal, new Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}
