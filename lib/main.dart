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
                child: const Text("Get String To File"),
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
