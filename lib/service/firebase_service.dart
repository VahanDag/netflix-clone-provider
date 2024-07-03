import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/models/user_model.dart';

class FirebaseService {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  Future<bool> createUser(String email, String password, String name) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final model = UserModel(email: email, movieList: [], name: name, uid: credential.user?.uid);
      await _firestore.collection("users").doc(model.uid).set(model.toMap());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<QueryDocumentSnapshot>> fetchMovies() async {
    final snapshot = await _firestore.collection("movies").get();

    return snapshot.docs;
  }

  Future<UserModel?> fetchUserData() async {
    if (_auth.currentUser != null) {
      final snapshot = await _firestore.collection("users").doc(_auth.currentUser!.uid).get();
      final userData = snapshot.data();
      return UserModel.fromMap(userData!);
    } else {
      return null;
    }
  }
}
