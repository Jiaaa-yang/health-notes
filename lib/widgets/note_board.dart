import 'package:flutter/material.dart';

import 'package:health_notes/layouts/random_grid.dart';

import 'package:health_notes/widgets/notes/note.dart';
import 'package:health_notes/widgets/notes/trash.dart';
import 'package:health_notes/widgets/util/textbox_popup_button.dart';

import 'package:health_notes/api/notes.dart';

/// Represents the collection of notes to display
class NoteBoard extends StatefulWidget {
  final List<Note> notes;

  final TextEditingController controller = TextEditingController();

  NoteBoard({Key? key, required this.notes}) : super(key: key);

  @override
  _NoteBoardState createState() => _NoteBoardState();
}

class _NoteBoardState extends State<NoteBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: RandomGrid(children: widget.notes, crossAxisCount: 16),
              ),
              flex: 8,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextboxPopupButton(
                    onTextSubmit: addNote,
                    controller: widget.controller,),
                  TrashCan(onAccept: deleteNote,),
                ],
              ),
              flex: 2,
            ),
          ],
        )
    );
  }

  /// Add note to both state model and database
  void addNote() {
    String content = widget.controller.text;
    if (content.length == 0) return;

    setState(() {
      widget.notes.add(new Note(content: content));
    });

    NotesData.addNote(content);
    widget.controller.clear();
  }

  /// Delete note with given content from both state model and database
  void deleteNote(String content) {
    int index = widget.notes.indexWhere((element) => element.content == content);
    setState(() {
      widget.notes.removeAt(index);
    });

    NotesData.deleteNote(content);
  }
}
