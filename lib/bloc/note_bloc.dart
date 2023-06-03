import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app_bloc/model/note_model.dart';
import 'package:note_app_bloc/note_database/note_database.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteDatabase noteDatabase;
  List<Note> notes = [];
  NoteBloc(this.noteDatabase) : super(NoteInitial());

  Stream<NoteState> mapEventToState(NoteEvent event) async* {
    if (event is NoteInitial) {
      yield* mapInitialEventToState();
    }

    if (event is NoteAddEvent) {
      yield* mapNoteAddEventToState(title: event, content: event);
    }
  }

  mapInitialEventToState() async* {
    yield NoteLoading();

    await getNotes();

    yield YourNoteState(notes: notes);
  }

  Future<void> getNotes() async {
    await noteDatabase.getAllNote().then((value) => notes = value);
  }

  mapNoteAddEventToState({required title, required content}) async* {
    yield NoteLoading();
    await addToNotes(title: title, content: content);
  }

  addToNotes({required title, required content}) async {
    await noteDatabase.addToBox(Note(content: content, title: title));
    await getNotes();
  }

  Stream<NoteState> mapNoteEditEventToState(
      {required String title,
      required String content,
      required int index}) async* {
    yield NoteLoading();

    await removeFromNotes(index: index);

    notes.sort((a, b) {
      var aDate = a.title;
      var bDate = b.title;
      return aDate.compareTo(bDate);
    });
    yield YourNoteState(notes: notes);
  }

  removeFromNotes({required int index}) async {
    await noteDatabase.deleteFromBox(index);
    await getNotes();
  }
}
