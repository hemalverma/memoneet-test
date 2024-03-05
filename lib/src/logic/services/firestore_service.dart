import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  static Future<void> setData(
      {required String path, required Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.collection('Notes');
    final ref = await reference.add(data);
  }

  static Future<void> deleteData({required String id}) async {
    final reference = FirebaseFirestore.instance.collection('Notes').doc(id);
    await reference.delete();
  }

  static Future<void> updateData({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.collection('Notes').doc(id);
    await reference.update(data);
  }

  static Future<List<QueryDocumentSnapshot>?> getAllDocuments({
    required String collection,
  }) async {
    final reference = FirebaseFirestore.instance.collection(collection);
    final snapshot = await reference.get();
    return snapshot.docs;
  }
}
