import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_fab_dialer/flutter_fab_dialer.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ViewPhotos extends StatefulWidget {
  final String imgPath;
  const ViewPhotos({
    Key key,
    this.imgPath,
  }) : super(key: key);

  @override
  _ViewPhotosState createState() => _ViewPhotosState();
}

class _ViewPhotosState extends State<ViewPhotos> {
  var filePath;
  final String imgShare = 'Image.file(File(widget.imgPath),)';

  final LinearGradient backgroundGradient = const LinearGradient(
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
                      padding: const EdgeInsets.all(10.0),
                      child: const CircularProgressIndicator()),
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
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          const Text(
                            'Great, Saved in Gallary',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          Text(str,
                              style: const TextStyle(
                                fontSize: 16.0,
                              )),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          const Text('FileManager > wa_status_saver',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.teal)),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          MaterialButton(
                            child: const Text('Close'),
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
    final _fabMiniMenuItemList = [
      FabMiniMenuItem.withText(
          const Icon(Icons.sd_storage), Colors.teal, 4.0, 'Button menu',
          () async {
        _onLoading(true, '');

        final myUri = Uri.parse(widget.imgPath);
        final originalImageFile = File.fromUri(myUri);
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
            'If Image not available in gallary\n\nYou can find all images at');
      }, 'Save', Colors.black, Colors.white, true),
      FabMiniMenuItem.withText(const Icon(Icons.share), Colors.teal, 4.0,
          'Button menu', () {}, 'Share', Colors.black, Colors.white, true),
      FabMiniMenuItem.withText(const Icon(Icons.reply), Colors.teal, 4.0,
          'Button menu', () {}, 'Repost', Colors.black, Colors.white, true),
      FabMiniMenuItem.withText(const Icon(Icons.wallpaper), Colors.teal, 4.0,
          'Button menu', () {}, 'Set As', Colors.black, Colors.white, true),
      FabMiniMenuItem.withText(
          const Icon(Icons.delete_outline),
          Colors.teal,
          4.0,
          'Button menu',
          () {},
          'Delete',
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
          icon: const Icon(
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
            FabDialer(_fabMiniMenuItemList, Colors.teal, const Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}
