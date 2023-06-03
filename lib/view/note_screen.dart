import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_bloc/bloc/note_bloc.dart';
import 'package:note_app_bloc/view/edit_note_screen.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.orange])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Your Notes",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ))
          ],
        ),
        body: Container(
          child: Column(
            children: [
              BlocBuilder<NoteBloc, NoteState>(
                builder: (context, state) {
                  if (state is NoteInitial) {
                    return Container();
                  }
                  if (state is YourNoteState) {
                    return NoteGrid(state: state);
                  }
                  if (state is NoteLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const EditNoteScreen(
                newNote: true,
              ),
            ));
          },
          backgroundColor: const Color(0xFF560bad),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class NoteGrid extends StatelessWidget {
  final YourNoteState state;

  const NoteGrid({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: state.notes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.72,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10),
      itemBuilder: (context, index) {
        final note = state.notes[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return EditNoteScreen(
                  newNote: false,
                  index: index,
                  note: note,
                );
              },
            ));
          },
          child: NoteCard(
            title: note.title,
            content: note.content,
          ),
        );
      },
    );
  }
}

class NoteCard extends StatelessWidget {
  final String title;
  final String content;
  const NoteCard({super.key, required this.content, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Card(
          child: Padding(
        padding:
            const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5, right: 5),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              height: 0.5,
              width: double.infinity,
              color: Colors.black,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              content,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            )
          ],
        ),
      )),
    );
  }
}
