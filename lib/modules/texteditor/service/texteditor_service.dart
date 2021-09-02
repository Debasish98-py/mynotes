import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mynotes/modules/texteditor/model/notes.dart';

class NotesService {
  final db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  Stream<List<Notes>> getNotes() {
    return db.collection(user!.uid).snapshots().map((snapShot) =>
        snapShot.docs.map((doc) => Notes.fromJson(doc.data())).toList());
  }
}
