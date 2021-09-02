import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynotes/modules/texteditor/model/notes.dart';

class AddNotesController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final titleFocus = FocusNode().obs;
  final contentFocus = FocusNode().obs;
  final user = FirebaseAuth.instance.currentUser;

  // final collection = FirebaseFirestore.instance.collection(user!.uid);
  RxBool isImp = false.obs;
  RxBool visible = false.obs;
  RxBool save = false.obs;
  RxBool readOnly = true.obs;
  RxBool isNew = true.obs;
  RxInt currentIndex = 0.obs;
  Notes notes = Notes();

  addNotes() async {
    try {
      final collection = FirebaseFirestore.instance.collection(user!.uid);
      final doc = collection.doc();
      var _notes = notes;
      _notes.id = doc.id;
      _notes.isImportant = false;
      collection.doc(_notes.id).set(notes.toJson());
    } catch (e) {
      Get.snackbar("Error", "$e");
    }
  }

  updateNotes(var docId, var title, var content, var dateModified) {
    try {
      final collection = FirebaseFirestore.instance.collection(user!.uid);
      collection.doc(docId).update({"title": title, "content": content, "dateModified":dateModified});
    } catch (e) {
      Get.snackbar("Error", "$e");
    }
  }

  deleteNote(docId) {
    try {
      final collection = FirebaseFirestore.instance.collection(user!.uid);
      collection.doc(docId).delete();
    } catch (e) {
      Get.snackbar("Error", "$e");
    }
  }

  isImportantNote(var docId, var important) {
    try {
      final collection = FirebaseFirestore.instance.collection(user!.uid);
      collection.doc(docId).update({"isImportant": important});
    } catch (e) {
      Get.snackbar("Error", "$e");
    }
  }
}
