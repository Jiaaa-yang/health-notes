import 'package:flutter/material.dart';

import 'package:health_notes/widgets/note_board.dart';
import 'package:health_notes/widgets/notes/note.dart';
import 'package:health_notes/api/notes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Notes',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final Future<List<Note>> notes = NotesData.fetchAllNotes();

  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9E4D4),
      appBar: AppBar(
        backgroundColor: Color(0xFFD67D3E),
        title: Text("Health Notes"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: FutureBuilder<List<Note>>(
          future: this.notes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return NoteBoard(notes: snapshot.data!);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
