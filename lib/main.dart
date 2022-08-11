import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'ui/homepage.dart';
import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter_html/flutter_html.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int? _storagePermissionCheck;
  Future<int>? _storagePermissionChecker;

  int? androidSDK;

  Future<int> _loadPermission() async {
    //Get phone SDK version first inorder to request correct permissions.

    final androidInfo = await DeviceInfoPlugin().androidInfo;
    setState(() {
      androidSDK = androidInfo.version.sdkInt;
    });
    //
    if (androidSDK! >= 30) {
      //Check first if we already have the permissions
      final _currentStatusManaged =
          await Permission.manageExternalStorage.status;
      if (_currentStatusManaged.isGranted) {
        //Update
        return 1;
      } else {
        return 0;
      }
    } else {
      //For older phones simply request the typical storage permissions
      //Check first if we already have the permissions
      final _currentStatusStorage = await Permission.storage.status;
      if (_currentStatusStorage.isGranted) {
        //Update provider
        return 1;
      } else {
        return 0;
      }
    }
  }

  Future<int> requestPermission() async {
    if (androidSDK! >= 30) {
      //request management permissions for android 11 and higher devices
      final _requestStatusManaged =
          await Permission.manageExternalStorage.request();
      //Update Provider model
      if (_requestStatusManaged.isGranted) {
        return 1;
      } else {
        return 0;
      }
    } else {
      final _requestStatusStorage = await Permission.storage.request();
      //Update provider model
      if (_requestStatusStorage.isGranted) {
        return 1;
      } else {
        return 0;
      }
    }
  }

  Future<int> requestStoragePermission() async {
    /// PermissionStatus result = await
    /// SimplePermissions.requestPermission(Permission.ReadExternalStorage);
    final result = await [Permission.storage].request();
    setState(() {});
    if (result[Permission.storage]!.isDenied) {
      return 0;
    } else if (result[Permission.storage]!.isGranted) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    _storagePermissionChecker = (() async {
      int storagePermissionCheckInt;
      int finalPermission;

      if (_storagePermissionCheck == null || _storagePermissionCheck == 0) {
        _storagePermissionCheck = await _loadPermission();
      } else {
        _storagePermissionCheck = 1;
      }
      if (_storagePermissionCheck == 1) {
        storagePermissionCheckInt = 1;
      } else {
        storagePermissionCheckInt = 0;
      }

      if (storagePermissionCheckInt == 1) {
        finalPermission = 1;
      } else {
        finalPermission = 0;
      }

      return finalPermission;
    })();
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
        // accentColor: Colors.amber,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        // accentColor: Colors.amber,
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Savvy',
        theme: theme,
        darkTheme: darkTheme,
        home: DefaultTabController(
          length: 2,
          child: FutureBuilder(
            future: _storagePermissionChecker,
            builder: (context, status) {
              if (status.connectionState == ConnectionState.done) {
                if (status.hasData) {
                  if (status.data == 1) {
                    return const MyHome();
                  } else {
                    return Scaffold(
                      body: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Colors.lightBlue[100]!,
                            Colors.lightBlue[200]!,
                            Colors.lightBlue[300]!,
                            Colors.lightBlue[200]!,
                            Colors.lightBlue[100]!,
                          ],
                        )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                'Storage Permission Required',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                            FlatButton(
                              padding: const EdgeInsets.all(15.0),
                              child: const Text(
                                'Allow Storage Permission',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              color: Colors.indigo,
                              textColor: Colors.white,
                              onPressed: () {
                                _storagePermissionChecker = requestPermission();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  }
                } else {
                  return Scaffold(
                    body: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Colors.lightBlue[100]!,
                          Colors.lightBlue[200]!,
                          Colors.lightBlue[300]!,
                          Colors.lightBlue[200]!,
                          Colors.lightBlue[100]!,
                        ],
                      )),
                      child: const Center(
                        child: Text(
                          '''
Something went wrong.. Please uninstall and Install Again.''',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  );
                }
              } else {
                return const Scaffold(
                  body: SizedBox(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
