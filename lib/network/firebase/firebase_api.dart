import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

class FirebaseApi {
  static final DatabaseReference db =
      FirebaseDatabase.instance.ref('Appoiment');

  static List<Map<dynamic, dynamic>> appoimentData = [];
  static int dataLength = 0;

  static Future<void> setAppoimentData({
    required String email,
    required String userName,
    required String pickDate,
    required String pickTime,
    required String cost,
    required String name,
    required String time,
  }) async {
    String key = db.push().key!;
    await db.child(key).set({
      'key': key,
      'email': email,
      'username': userName,
      'pickDate': pickDate,
      'pickTime': pickTime,
      'cost': cost,
      'name': name,
      'time': time,
    });
    dataLength += 1;
  }

  static Future<List<Map>> selectAppoimentData(String? email) async {
    appoimentData.clear();
    int index = 0;

    Map data =
        await db.once().then((value) => value.snapshot.value as Map? ?? {});
    List<Map> allData = [];
    data.forEach((key, value) {
      allData.add(value);
    });

    for (var ele in allData) {
      if (ele['email'] == email) {
        appoimentData.add(ele);
        dataLength = index++;
      }
    }
    log("-------------------------------------\n");
    log("${appoimentData}");
    return appoimentData;
  }

  static Future<void> appoimentDeleteData({required String selectedkey}) async {
    dataLength -= 1;
    await db.child(selectedkey).remove();
  }

  static Future<void> updateAppoimentData({
    required String key,
    required String pickDate,
    required String pickTime,
  }) async {
    await db.child(key).update({
      'key': key,
      'pickDate': pickDate,
      'pickTime': pickTime,
    });
  }
}
