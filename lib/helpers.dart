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

  // Write the file.
  return file.writeAsString(message);
}

Future<String> readDeviceIdFromFile() async {
  try {
    final file = await _localFileDeviceId;
    String contents = await file.readAsString();

    return contents;
  } catch (e) {
    // If encountering an error, return 0.
    return "";
  }
}