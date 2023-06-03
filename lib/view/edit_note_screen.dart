import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_bloc/bloc/note_bloc.dart';
import 'package:note_app_bloc/model/note_model.dart';

final formKey = GlobalKey<FormState>();
TextEditingController titleController = TextEditingController();
TextEditingController contentController = TextEditingController();

class EditNoteScreen extends StatelessWidget {
  final bool newNote;
  final Note? note;
  final int? index;
  const EditNoteScreen(
      {super.key, required this.newNote, this.note, this.index});

  @override
  Widget build(BuildContext context) {
    String title = note != null ? note!.title : "";
    String content = note != null ? note!.content : "";
    titleController = TextEditingController(text: title);
    contentController = TextEditingController(text: content);
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.orange, Colors.yellow])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            newNote ? "New Note" : "Edit Note",
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                NoteTitle(controller: titleController, labelText: "Note Title"),
                const SizedBox(
                  height: 20.0,
                ),
                NoteTitle(
                    controller: contentController, labelText: "Note Content")
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(left: 10, bottom: 10),
          child: FloatingActionButton.extended(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                newNote
                    ? BlocProvider.of<NoteBloc>(context).add(NoteAddEvent(
                        title: titleController.text,
                        content: contentController.text))
                    : BlocProvider.of<NoteBloc>(context).add(NoteEditEvent(
                        title: titleController.text,
                        content: contentController.text,
                        index: index!));
              }
            },
            label: Text(newNote ? "ADD" : "UPDATE"),
            icon: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class NoteTitle extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  const NoteTitle(
      {super.key, required this.controller, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Color(0xFFfdffb6)),
        decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.black38),
            border: const OutlineInputBorder(),
            labelText: labelText),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter a valid $labelText";
          }
          return null;
        },
      ),
    );
  }
}
