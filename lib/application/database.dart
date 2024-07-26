//  Copyright © 2020 MGH Lab of Computer Science. All rights reserved.

import 'dart:async';
import 'dart:io';
//import 'package:mghheartaccess/application/api.dart';
import 'package:path/path.dart';
//import 'package:mghheartaccess/application/locator.dart';
//import 'package:mghheartaccess/service/authentication_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

enum UpsertResult { error, noAction, update, insert }

class MGHHeartDatabase {
  //late AuthenticationService _authService;
  //late Api _api;

  static final MGHHeartDatabase mghHeartDatabase = MGHHeartDatabase._internal();

  static const String dataBaseName = 'mghheartaccess_sqflite_24072401.db';
  static const int version = 1;

  late Database _db;
  bool didInit = false;

  static MGHHeartDatabase get() {
    return mghHeartDatabase;
  }

  MGHHeartDatabase._internal();

  /// Use this method to access the database, because initialization of the database (it has to go through the method channel)
  Future<Database> _getDb() async {
    if (!didInit) await _init();
    return _db;
  }

  Future init() async {
    return await _init();
  }

  Future _init() async {
    //_authService = locator<AuthenticationService>();
    //_api = locator<Api>();

    // 5/28/20 -- adding internal primary keys to solve syncing problem
    // https://stackoverflow.com/questions/7905859/is-there-an-auto-increment-in-sqlite

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dataBaseName);
    _db = await openDatabase(path,
        version: version,
        onCreate: onCreateDatabase,
        onOpen: onOpenDatabase,
        singleInstance: true);

    didInit = true;
    //print('initialized database ($dataBaseName): version = $version');
  }

  FutureOr<void> onOpenDatabase(Database db) {
    print('initialized database ($dataBaseName): version = $version');
  }

  FutureOr<void> onCreateDatabase(Database db, int version) async {
    /*
    await db.execute("CREATE TABLE user ("
        "id INTEGER PRIMARY KEY,"
        "username TEXT,"
        "first_name TEXT,"
        "last_name TEXT,"
        "middle_initial TEXT,"
        "email TEXT,"
        "profile_image_document_uuid TEXT"
        ")");

    await db.execute("CREATE TABLE conversation ("
        "id INTEGER PRIMARY KEY,"
        "conversation_id INTEGER UNIQUE," // this is the system 'mojo' conversation id
        "type TEXT,"
        "status TEXT DEFAULT 'Open',"
        "title TEXT,"
        "description TEXT,"
        "image_uuid TEXT,"
        "last_modified INTEGER DEFAULT (cast(strftime('%s','now') as int) * 1000),"
        "creation_date INTEGER DEFAULT (cast(strftime('%s','now') as int) * 1000),"
        "active INTEGER DEFAULT 1"
        ")");

    await db.execute("CREATE TABLE message ("
        "id INTEGER PRIMARY KEY,"
        "message_id INTEGER," // this is the external (mojo) message id ... returned upon successful creation
        "conversation_id INTEGER," // this is the internal conversation id, not the backend cid
        "parent_message_id INTEGER,"
        "author_id INTEGER,"
        "text TEXT,"
        "tag TEXT,"
        "data TEXT,"
        "date INTEGER,"
        "document_uuid STRING,"
        //"status_code INTEGER DEFAULT 0,"
        "archive_status TEXT DEFAULT 'Active',"
        "delivery_status TEXT"
        ")");

    await db.execute("CREATE TABLE document ("
        "id INTEGER,"
        "uuid TEXT NOT NULL PRIMARY KEY,"
        "content_type TEXT,"
        "data TEXT," // base64String from Uint8List
        "description TEXT,"
        "name TEXT,"
        "size TEXT,"
        //"path TEXT,"
        "uploaded_date INTEGER DEFAULT (cast(strftime('%s','now') as int) * 1000)"
        ")");

    await db.execute("CREATE TABLE conversation_attribute ("
        "conversation_id INTEGER," // this is the internal conversation id, not the backend cid
        "type TEXT,"
        "value TEXT"
        ")");

    await db.execute("CREATE TABLE conversation_property ("
        "conversation_id INTEGER," // this is the internal conversation id, not the backend cid
        "name TEXT,"
        "value TEXT,"
        "last_modified INTEGER,"
        "creation_date INTEGER"
        ")");

    await db.execute("CREATE TABLE conversation_follow ("
        "conversation_id INTEGER," // this is the internal conversation id, not the backend cid
        "follow_id INTEGER,"
        "user_id INTEGER,"
        "role TEXT,"
        "creation_date INTEGER,"
        "last_modified INTEGER,"
        "active INTEGER DEFAULT 1"
        ")");

    await db.execute("CREATE TABLE conversation_subscription ("
        "conversation_id INTEGER," // this is the internal conversation id, not the backend cid
        "user_id INTEGER"
        ")");

    await db.execute("CREATE TABLE user_message_view ("
        "id INTEGER," // this is the backend user message view id
        //"user_message_view_id INTEGER,"
        "user_id INTEGER NOT NULL,"
        "message_id INTEGER NOT NULL,"
        "emoticon_type INTEGER,"
        "date INTEGER"
        ")");

    await db.execute("CREATE TABLE message_sync ("
        "id INTEGER PRIMARY KEY,"
        "type TEXT,"
        "date INTEGER DEFAULT (cast(strftime('%s','now') as int) * 1000)"
        ")");

    await db.execute("CREATE TABLE recent_patients ("
        "id INTEGER PRIMARY KEY,"
        "mrn TEXT,"
        "display_name TEXT,"
        "gender TEXT,"
        "date_of_birth INTEGER," // base64String from Uint8List
        "last_modified INTEGER DEFAULT (cast(strftime('%s','now') as int) * 1000)"
        ")");
    */
  }

  Future close() async {
    var db = await _getDb();
    return db.close();
  }

/*
class Utility {
  static MemoryImage memoryImageFromBase64String(String base64String) {
    return MemoryImage(base64Decode(base64String));
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
*/
}
