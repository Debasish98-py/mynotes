import 'package:get/get.dart';
import 'package:mynotes/modules/texteditor/model/notes.dart';
import 'package:mynotes/modules/texteditor/service/texteditor_service.dart';

class GetNotesController extends GetxController {
  Rx<List<Notes>> _notes = Rx<List<Notes>>([]);

  List<Notes> get notes => _notes.value;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    isLoading.value = true;
    _notes.bindStream(NotesService().getNotes());
    isLoading.value = false;
    super.onInit();
  }
}