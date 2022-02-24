import 'package:flutter/material.dart';
import 'package:health_notes/layouts/random_grid.dart';
import 'package:health_notes/widgets/notes/note.dart';
import 'package:health_notes/widgets/notes/trash.dart';

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
  const MyHomePage({Key? key}) : super(key: key);

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
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: RandomGrid(
                    children: this.buildStubNotes(),
                    crossAxisCount: 12,
                  ),
                ),
                flex: 8,
              ),
              Expanded(
                child: Align(
                  child: TrashCan(),
                  alignment: Alignment.centerRight,
                ),
                flex: 2,
              ),
            ],
          )
      ),
    );
  }

  /// Stub method to generate placeholder notes data
  List<Widget> buildStubNotes() {
    List<String> contents = [
      "note 1",
      "note 2",
      "note 3",
      "note 4",
      "note 5",
    ];

    return List.generate(contents.length, (index) => Note(content: contents[index]));
  }
}
