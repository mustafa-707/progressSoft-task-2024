import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:progressofttask/logic/firebase/firebase_collections.dart';

class QueryData {
  final String id;
  final Object? value;

  QueryData({
    required this.id,
    required this.value,
  });
}

abstract class FireStoreServiceImpl<T> {
  Future<List<T>?> get([String? id]);
  Future<void> delete(String id);
  Future<void> upsert(T data, [String? id]);
}

class FireStoreService<T> implements FireStoreServiceImpl<T> {
  final CollectionType path;
  final T Function(Map<String, dynamic> json) fromJsonT;
  final Map<String, dynamic> Function(T value) toJsonT;
  late final CollectionReference<T> ref;
  FireStoreService({
    required this.path,
    required this.fromJsonT,
    required this.toJsonT,
  }) {
    ref = path.withConverter<T>(
      fromFirestore: (snapshot, _) => fromJsonT(snapshot.data()!),
      toFirestore: (object, _) => toJsonT(object),
    );
  }

  @override
  Future<List<T>?> get([String? id]) async {
    if (id != null) {
      final data = await ref.doc(id).get();
      return [data.data() as T];
    } else {
      final data = await ref.get();
      return data.docs.map((d) => d.data()).toList();
    }
  }

  @override
  Future<void> delete(String id) async {
    await ref.doc(id).delete();
  }

  @override
  Future<void> upsert(T data, [String? id]) async {
    await ref.doc(id).set(data);
  }
}
