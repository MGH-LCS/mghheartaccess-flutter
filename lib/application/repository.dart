//  Copyright © 2020 MGH Lab of Computer Science. All rights reserved.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:mghheartaccess/application/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mghheartaccess/application/utils.dart';
import 'package:mghheartaccess/model/exception.dart';
import 'package:mghheartaccess/model/heart_center.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  late MGHHeartDatabase _database;
  //late final SharedPreferences prefs;

  // this is the data structure that holds dynamic data
  HeartCenter? _heartCenter;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localDataFile async {
    final path = await _localPath;
    return File('$path/appData.json');
  }

  Repository() {
    init();
  }

  Future init() async {
    print('Repository: init ...');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs = await SharedPreferences.getInstance();

    DateTime? lastUpdated;
    String? lastUpdatedString = prefs.getString('lastUpdated');
    DateFormat df = DateFormat('yyyy-MM-dd HH:mm');

    if (lastUpdatedString != null) {
      lastUpdated = df.parse(lastUpdatedString);
    }

    print('Repository: lcoal last updated date = $lastUpdated');

    DateTime? fbLastUpdated = await getLastUpdatedFromFirebase();

    // look for document in docs directory
    File localFile = await _localDataFile;

    if (localFile.existsSync() &&
        lastUpdated != null &&
        fbLastUpdated != null &&
        lastUpdated.isAfter(fbLastUpdated)) {
      print(
          'Repository: init: local file exists - lastUpdated $lastUpdated with is after Firebase last updated $fbLastUpdated ...');

      // just use the local data file
    } else {
      print('Repository: init: local file does not exist ...');

      // Mode for opening a file for writing only. The file is overwritten if it already exists. The file is created if it does not already exist
      // writeAsString(String contents, {FileMode mode = FileMode.writeOnly});
    }

    // if def file in documents directlry is null, load from assets directory

    // if def file exists in documents directory load it to get version

    // get version info from firebase

    // get last update date from app properties

    // if new version is available load from firebase
    // else just use current def file

    _database = MGHHeartDatabase.get();
    await _database.init();

    print('Repository: init ... done');
  }

  Future<DateTime?> getLastUpdatedFromFirebase() async {
    final storageRef = FirebaseStorage.instance.ref();

    // Create a reference with an initial file path and name
    final pathReference = storageRef.child("appData.json");

    DateTime? lastUpdated;

    try {
      FullMetadata fullMetadata = await pathReference.getMetadata();
      DateTime? lastUpdated = fullMetadata.updated;
      print('Repository: last updated for data file = $lastUpdated');
    } catch (e) {
      print('Repository: getLastUpdatedFromFirebase: error: $e');
      lastUpdated = null;
    }

    return lastUpdated;
  }

  Future<Map<String, dynamic>> loadJSONFromFireabse() async {
    final storageRef = FirebaseStorage.instance.ref();

    // Create a reference with an initial file path and name
    final pathReference = storageRef.child("appData.json");

    String? jsonString;

    try {
      const oneMegabyte = 1024 * 1024;
      final Uint8List? data = await pathReference.getData(oneMegabyte);
      final docsDir = await getApplicationDocumentsDirectory();
      File file = await File('${docsDir.path}/appData.json').create();
      file.writeAsBytes(data!);
      jsonString = await file.readAsString();
    } on FirebaseException catch (e) {
      print('Repository: fetched data error: $e');
    }

    if (jsonString == null) throw MGHHeartException('Could not load data');

    return jsonDecode(jsonString);
  }

  Future<HeartCenter> getHeartCenter() async {
    if (_heartCenter != null) return _heartCenter!;

    // attempt to get local file from docs directory

    // for now just load local file
    Map<String, dynamic> jsonData =
        await loadJsonFromAssets('assets/data/data.json');

    // initialize the object
    _heartCenter = HeartCenter.fromJson(jsonData);

    if (_heartCenter == null) {
      throw MGHHeartException('data for app has not been loaded');
    }
    return _heartCenter!;
  }
}
