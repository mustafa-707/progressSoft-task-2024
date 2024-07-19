import 'package:cloud_firestore/cloud_firestore.dart';

typedef CollectionType = CollectionReference<Map<String, dynamic>>;

class FirebaseCollections {
  static final _firebase = FirebaseFirestore.instance;

  static const _config = "config";
  static const _users = "users";

  static CollectionType get config => _firebase.collection(
        _config,
      );

  static CollectionType get users => _firebase.collection(
        _users,
      );
}
