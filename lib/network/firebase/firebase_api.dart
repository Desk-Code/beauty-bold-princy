import 'package:firebase_database/firebase_database.dart';

class FirebaseApi {
  static final DatabaseReference db =
      FirebaseDatabase.instance.ref('Appoiment');
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
  }

  static Future<List<Map>> selectAppoimentData(String? email) async {
    Map data =
        await db.once().then((value) => value.snapshot.value as Map? ?? {});
    List<Map> allData = [];
    data.forEach((key, value) {
      allData.add(value);
    });
    List<Map> appoimentData = [];
    for (var ele in allData) {
      if (ele['email'] == email) {
        appoimentData.add(ele);
      }
    }
    return appoimentData;
  }
}
