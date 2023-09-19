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
  }

  static Future<List<Map>> selectAppoimentData(String? email) async {
    Map data =
        await db.once().then((value) => value.snapshot.value as Map? ?? {});
    List<Map> allData = [];
    int index = 0;
    data.forEach((key, value) {
      allData.add(value);
    });

    for (var ele in allData) {
      if (ele['email'] == email) {
        appoimentData.add(ele);
        dataLength = index++;
      }
    }
    return appoimentData;
  }

  static Future<void> appoimentDeleteData({required String selectedkey}) async {
    await db.child(selectedkey).remove();
  }
}
