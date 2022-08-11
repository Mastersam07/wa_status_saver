import 'dart:io';

import 'package:flutter/material.dart';

import 'viewphotos.dart';

final Directory _newPhotoDir = Directory(
    '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses');

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);
  @override
  ImageScreenState createState() => ImageScreenState();
}

class ImageScreenState extends State<ImageScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!Directory('${_newPhotoDir.path}').existsSync()) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Install WhatsApp\n',
            style: TextStyle(fontSize: 18.0),
          ),
          const Text(
            "Your Friend's Status Will Be Available Here",
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      );
    } else {
      final imageList = _newPhotoDir
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith('.jpg'))
          .toList(growable: false);
      if (imageList.length > 0) {
        return Container(
            margin: const EdgeInsets.all(8.0),
            child: GridView.builder(
              key: PageStorageKey(widget.key),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150),
              itemCount: imageList.length,
              itemBuilder: (BuildContext context, int index) {
                final String imgPath = imageList[index];
                return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewPhotos(
                              imgPath: imgPath,
                            ),
                          ),
                        );
                      },
                      child: Image.file(
                        File(imageList[index]),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.medium,
                      ),
                    ));
              },
            )
            // child: StaggeredGrid.count(
            //   crossAxisCount: 4,
            //   children: [
            //     ...imageList.map((imgPath) => StaggeredGridTile.count(
            //           crossAxisCellCount: 2,
            //           mainAxisCellCount:
            //               imageList.indexOf(imgPath).isEven ? 2 : 3,
            //           child: Material(
            //             elevation: 8.0,
            //             borderRadius: const BorderRadius.all(Radius.circular(8)),
            //             child: InkWell(
            //               onTap: () {
            //                 Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                     builder: (context) => ViewPhotos(
            //                       imgPath: imgPath,
            //                     ),
            //                   ),
            //                 );
            //               },
            //               child: Hero(
            //                   tag: imgPath,
            //                   child: Image.file(
            //                     File(imgPath),
            //                     fit: BoxFit.cover,
            //                   )),
            //             ),
            //           ),
            //         ))
            //   ],
            //   mainAxisSpacing: 8.0,
            //   crossAxisSpacing: 8.0,
            // ),
            );
      } else {
        return Scaffold(
          body: Center(
            child: Container(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: const Text(
                  'Sorry, No Image Found!',
                  style: TextStyle(fontSize: 18.0),
                )),
          ),
        );
      }
    }
  }
}
