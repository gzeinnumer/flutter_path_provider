# flutter_path_provider

|<img src="/preview/preview1.png" width="300"/>|<img src="/preview/preview2.png" width="300"/>|
|--|--|

```
path_provider: ^2.0.11
```

- helpers.dart
```dart
import 'dart:io';
import 'dart:math';

import 'package:path_provider/path_provider.dart';

String generateRandomString(int len) {
  var r = Random();
  const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

Future<String> createFolderInAppDocDir(String folderName) async {
  //Get this App Document Directory
  final Directory? appDocDir = Platform.isAndroid
      ? await getExternalStorageDirectory() //FOR ANDROID
      : await getApplicationSupportDirectory();
  //App Document Directory + folder name
  final Directory appDocDirFolder = Directory('${appDocDir!.path}/$folderName/');
  if (await appDocDirFolder.exists()) {
    //if folder already exists return path
    return appDocDirFolder.path;
  } else {
    //if folder not exists create folder and then return its path
    final Directory appDocDirNewFolder = await appDocDirFolder.create(recursive: true);
    return appDocDirNewFolder.path;
  }
}

Future<File> get _localFileDeviceId async {
  final path = await createFolderInAppDocDir("my_folder");
  String pahtFile = "${path}device_id.txt";
  return File(pahtFile);
}

Future<File> setDeviceIdToFile(String message) async {
  final file = await _localFileDeviceId;
  return file.writeAsString(message);
}

Future<String> readDeviceIdFromFile() async {
  try {
    final file = await _localFileDeviceId;
    String contents = await file.readAsString();
    return contents;
  } catch (e) {
    return "";
  }
}
```

- main.dart
```dart
// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_path_provider/helpers.dart';
import 'package:path_provider/path_provider.dart';

//https://pub.dev/packages/path_provider
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Path Provider',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Path Provider'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String newDeviceId = "";
  String oldDeviceId = "";

  @override
  void initState() {
    super.initState();
    readDeviceId();
  }

  void generateNewString() async {
    var value = generateRandomString(20);
    setState(() {
      newDeviceId = value;
    });
  }

  void readDeviceId() async {
    var value = await readDeviceIdFromFile();
    setState(() {
      oldDeviceId = value;
    });
  }

  void setDeviceId() {
    setDeviceIdToFile(newDeviceId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('New Device Id: $newDeviceId'),
            const SizedBox(height: 10,),
            ElevatedButton(
                child: const Text("Generate New Random String"),
                onPressed: () {
                  generateNewString();
                },
            ),
            ElevatedButton(
                child: const Text("Set String To File"),
                onPressed: () {
                  setDeviceId();
                },
            ),
            ElevatedButton(
                child: const Text("Get String From File"),
                onPressed: () {
                  readDeviceId();
                },
            ),
            const SizedBox(height: 10,),
            Text('Old Device Id: $oldDeviceId'),
          ],
        ),
      ),
    );
  }
}
```

---

```
Copyright 2022 M. Fadli Zein
```
