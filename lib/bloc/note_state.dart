part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class EditNoteState extends NoteState {
  final Note note;
  EditNoteState({required this.note});
}

class YourNoteState extends NoteState {
  final List<Note> notes;
  YourNoteState({required this.notes});
}

class NewNoteState extends NoteState {
  
  
}