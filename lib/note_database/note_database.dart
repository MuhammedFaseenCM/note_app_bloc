import 'package:hive/hive.dart';
import 'package:note_app_bloc/model/note_model.dart';

class NoteDatabase {
  String boxName = 'Note';
  Future<Box> noteBox() {
    var box = Hive.openBox<Note>(boxName);

    return box;
  }

  Future<List<Note>> getAllNote() async {
    final box = await noteBox();
    List<Note> notes = box.values.toList() as List<Note>;
    return notes;
  }

  Future<void> addToBox(Note note) async {
    final box = await noteBox();
    await box.add(note);
  }

  Future<void> deleteFromBox(int index) async {
    final box = await noteBox();
    await box.deleteAt(index);
  }

  Future<void> deleteAll() async {
    final box = await noteBox();
    await box.clear();
  }

  Future<void> updateNote(int index, Note note) async {
    final box = await noteBox();
    box.putAt(index, note);
  }
}
