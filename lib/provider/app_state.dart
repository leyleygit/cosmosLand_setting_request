import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class AppState extends ChangeNotifier {
  mongo.Db? db;
  var box = Hive.box('myBox');
  var userAppState;
  //For restart app and check ID
  getIdFromBox() {
    userAppState = box.get("id");
  }

  setDb(value) {
    db = value;
    notifyListeners();
  }

  //For UI for Navigator
  setUser(value) {
    userAppState = value;
    notifyListeners();
  }
}
