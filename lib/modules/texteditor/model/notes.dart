import 'package:cloud_firestore/cloud_firestore.dart';

class Notes {
  String? id;
  String? title;
  String? content;
  Timestamp? dateCreated;
  Timestamp? dateModified;
  bool? isImportant;

  Notes({
      this.id, 
      this.title, 
      this.content, 
      this.dateCreated, 
      this.dateModified,
      this.isImportant,
  });

  Notes.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    dateCreated = json['dateCreated'];
    dateModified = json['dateModified'];
    isImportant = json['isImportant'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['content'] = content;
    map['dateCreated'] = dateCreated;
    map['dateModified'] = dateModified;
    map['isImportant'] = isImportant;
    return map;
  }

}