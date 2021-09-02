import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynotes/modules/texteditor/controller/add_notes_controller.dart';
import 'package:mynotes/modules/texteditor/model/notes.dart';

class TextEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Notes _n = Get.arguments;
    var _height = Get.context!.height;
    return GetX<AddNotesController>(
        init: AddNotesController(),
        builder: (_editor) {
          return Scaffold(
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: Colors.grey[200],
                              child: IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: Icon(CupertinoIcons.back,
                                      color: Color(0xff0A1747))),
                            ),
                            Visibility(
                              visible: _editor.save.value == true,
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.grey[200],
                                child: MaterialButton(
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                      color: Color(0xff0A1747),
                                    ),
                                  ),
                                  onPressed: () async {
                                    _editor.formKey.currentState!.save();
                                    if (_editor.isNew.value == true) {
                                      _editor.notes.dateCreated =
                                          Timestamp.now();
                                      await _editor.addNotes();
                                      await Get.showSnackbar(
                                        GetBar(
                                          title: "Success",
                                          message: "Note Saved",
                                          duration: Duration(seconds: 2),
                                          snackStyle: SnackStyle.FLOATING,
                                          snackPosition: SnackPosition.TOP,
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                      Get.back();
                                    } else {
                                      await _editor.updateNotes(
                                          _n.id, _editor.notes.title, _editor.notes.content, Timestamp.now());
                                      await Get.showSnackbar(
                                        GetBar(
                                          title: "Success",
                                          message: "Note Updated",
                                          duration: Duration(seconds: 2),
                                          snackStyle: SnackStyle.FLOATING,
                                          snackPosition: SnackPosition.TOP,
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                      Get.back();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: _height * 0.07,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.grey[200],
                        elevation: 0,
                        margin: EdgeInsets.zero,
                        child: Form(
                          key: _editor.formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.all(25.0)
                                    .copyWith(bottom: 10, top: 34),
                                child: TextFormField(
                                  initialValue: _editor.isNew.value == false
                                      ? _n.title
                                      : '',
                                  readOnly: _editor.readOnly.value,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Title",
                                      hintStyle: TextStyle(color: Colors.grey)),
                                  focusNode: _editor.titleFocus.value,
                                  maxLines: null,
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Color(0xff0A1747),
                                      fontWeight: FontWeight.w700),
                                  cursorColor: Colors.blue,
                                  onSaved: (value) {
                                    _editor.notes.title = value;
                                  },
                                ),
                              ),
                              Divider(),
                              Container(
                                padding: EdgeInsets.all(25.0)
                                    .copyWith(bottom: 10, top: 34),
                                child: TextFormField(
                                  initialValue: _editor.isNew.value == false
                                      ? _n.content
                                      : '',
                                  readOnly: _editor.readOnly.value,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Body",
                                      hintStyle: TextStyle(color: Colors.grey)),
                                  focusNode: _editor.contentFocus.value,
                                  maxLines: 12,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff0A1747),
                                  ),
                                  cursorColor: Colors.blue,
                                  onSaved: (value) {
                                    _editor.notes.content = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      ListTile(
                        contentPadding:
                            EdgeInsets.all(14).copyWith(top: 0, bottom: 0),
                        title: _editor.isNew.value == true
                            ? Text("")
                            : Text(
                                _n.dateCreated!
                                    .toDate()
                                    .toLocal()
                                    .toString()
                                    .split(".")[0],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                ),
                              ),
                        trailing: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: [
                            GetBuilder<AddNotesController>(
                                init: AddNotesController(),
                                builder: (_update) {
                                  return IconButton(
                                    onPressed: () async {},
                                    icon: Icon(
                                      CupertinoIcons.photo,
                                      color: Colors.grey,
                                    ),
                                    constraints: BoxConstraints(
                                        maxHeight: _height * 0.05),
                                  );
                                }),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                CupertinoIcons.mic_solid,
                                color: Colors.grey,
                              ),
                              constraints:
                                  BoxConstraints(maxHeight: _height * 0.05),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Visibility(
              visible: _editor.visible.value == true,
              child: BottomNavigationBar(
                selectedItemColor: Color(0xff0A1747),
                unselectedItemColor: Color(0xff0A1747),
                type: BottomNavigationBarType.fixed,
                // currentIndex: _editor.currentIndex.value,
                // onTap: (int index) {
                //   _editor.currentIndex.value = index;
                // },
                items: [
                  BottomNavigationBarItem(
                      icon: IconButton(
                          onPressed: () {
                            _editor.save.value = !_editor.save.value;
                            _editor.readOnly.value = !_editor.readOnly.value;
                          },
                          icon: Icon(
                            Icons.edit_outlined,
                          )),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: _n.isImportant == true
                          ? Icon(
                              Icons.star,
                              color: Colors.orange,
                            )
                          : Icon(Icons.star_border_rounded),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.share_outlined), label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.more_vert), label: ''),
                ],
              ),
            ),
          );
        });
  }
}
