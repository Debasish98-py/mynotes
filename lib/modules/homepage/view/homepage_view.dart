import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mynotes/modules/login/controller/login_controller.dart';
import 'package:mynotes/modules/texteditor/controller/add_notes_controller.dart';
import 'package:mynotes/modules/texteditor/controller/get_notes_controller.dart';
import 'package:mynotes/modules/texteditor/model/notes.dart';
import 'package:mynotes/modules/texteditor/view/texteditor_view.dart';

class HomePage extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var _height = Get.context!.height;
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: GetBuilder<AddNotesController>(
          init: AddNotesController(),
          builder: (_notes) {
            return FloatingActionButton(
              onPressed: () {
                print(_notes.save.value);
                _notes.save.value = true;
                _notes.visible.value = false;
                _notes.readOnly.value = false;
                _notes.isNew.value = true;
                Get.to(() => TextEditor(), arguments: Notes());
              },
              backgroundColor: Colors.black87,
              child: Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 30,
              ),
            );
          }),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(40),
                child: Center(
                  child: Text(
                    "MyNotes",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: _height * 0.7,
              ),
              GetBuilder<LoginController>(
                init: LoginController(),
                builder: (_logout) {
                  return MaterialButton(
                    onPressed: () async{
                      await _logout.signOut();
                    },
                    color: Colors.grey[200],
                    child: Text("Log Out"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  );
                }
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                            scaffoldKey.currentState!.openDrawer();
                          },
                          icon: Icon(CupertinoIcons.bars,
                              color: Color(0xff0A1747))),
                    ),
                    Text(
                      "MyNotes",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff0A1747)),
                    ),
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.grey[200],
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(CupertinoIcons.search,
                              color: Color(0xff0A1747))),
                    ),
                  ],
                ),
              ),
              GetX<GetNotesController>(
                init: GetNotesController(),
                builder: (_notes) {
                  print(_notes.notes.length);
                  _notes.notes.sort((first, second) {
                    int b1 = first.isImportant == true ? 1 : 0;
                    int b2 = second.isImportant == true ? 1 : 0;
                    return b2 - b1;
                  });
                  if (_notes.notes.isEmpty) {
                    return Center(
                      child: Text("No notes added"),
                    );
                  } else if (_notes.notes.isNotEmpty) {
                    return ListView.builder(
                      itemCount: _notes.notes.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        Notes _note = _notes.notes[index];
                        // var _date = DateFormat('dd/MM/yyyy')
                        //     .format(_note.dateCreated!.toDate());
                        // var _time = DateFormat('kk:mm')
                        //     .format(_note.dateCreated!.toDate());
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(14.0)
                                  .copyWith(bottom: 8, top: 16),
                              child: GetBuilder<AddNotesController>(
                                init: AddNotesController(),
                                builder: (_notes) {
                                  return Slidable(
                                    actionPane: SlidableDrawerActionPane(),
                                    secondaryActions: [
                                      IconSlideAction(
                                        onTap: () {
                                          _notes.deleteNote(_note.id);
                                        },
                                        icon: CupertinoIcons.delete,
                                        color: Colors.yellow,
                                      ),
                                    ],
                                    child: ListTile(
                                      onTap: () {
                                        _notes.save.value = false;
                                        _notes.visible.value = true;
                                        _notes.readOnly.value = true;
                                        _notes.isNew.value = false;
                                        Get.to(() => TextEditor(),
                                            arguments: _note);
                                        print(_notes.save.value);
                                      },
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        "${_note.title}",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff0A1747),
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${_note.content}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      trailing: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.end,
                                            children: [
                                              GetBuilder<AddNotesController>(
                                                  init: AddNotesController(),
                                                  builder: (_update) {
                                                    return IconButton(
                                                      onPressed: () async {
                                                        _update.isImp.value =
                                                            !_update
                                                                .isImp.value;
                                                        _update.notes
                                                                .isImportant =
                                                            _update.isImp.value;
                                                        await _update
                                                            .isImportantNote(
                                                                _note.id,
                                                                _update.notes
                                                                    .isImportant);
                                                      },
                                                      icon: _note.isImportant ==
                                                              true
                                                          ? Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.orange,
                                                            )
                                                          : Icon(
                                                              Icons
                                                                  .star_border_rounded,
                                                            ),
                                                      constraints:
                                                          BoxConstraints(
                                                              maxHeight:
                                                                  _height *
                                                                      0.05),
                                                    );
                                                  }),
                                              IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.more_vert,
                                                  color: Color(0xff0A1747),
                                                ),
                                                constraints: BoxConstraints(
                                                    maxHeight: _height * 0.05),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Text(
                                              _note.dateCreated!
                                                  .toDate()
                                                  .toLocal()
                                                  .toString()
                                                  .split(".")[0],
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Divider(),
                          ],
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
