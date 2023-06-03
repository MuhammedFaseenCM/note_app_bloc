part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Note> get props => [];
}

class NoteAddEvent extends NoteEvent {
  final String title, content;
   NoteAddEvent(
      {required this.content, required this.title});
}

class NoteEditEvent extends NoteEvent {
  final String title, content;
  final int index;
  NoteEditEvent(
      {required this.content, required this.index, required this.title});
}

class NoteDeleteEvent extends NoteEvent {
  final int index;
  NoteDeleteEvent({required this.index});
}
