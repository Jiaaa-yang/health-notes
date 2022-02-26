import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:health_notes/layouts/random_grid.dart';
import 'package:health_notes/widgets/notes/note.dart';
import 'package:health_notes/widgets/notes/trash.dart';
import 'package:health_notes/widgets/util/textbox_popup_button.dart';

// Alias host name for android emulator, with server
// listening at port 3000
const SERVER_BASE_URL = "http://10.0.2.2:3000";

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static final TextEditingController controller = TextEditingController();

  late Future<List<Widget>> notes;

  @override
  void initState() {
    super.initState();
    this.notes = fetchAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    void addNewNote() {
      addNote(controller.text);
      controller.clear();
      setState(() {
        this.notes = fetchAllNotes();
      });
    }

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
                  child: FutureBuilder<List<Widget>>(
                    future: this.notes,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return RandomGrid(children: snapshot.data!, crossAxisCount: 16);
                      } else {
                        return Center(child: Text("Loading data"),);
                      }
                    },
                  ),
                ),
                flex: 8,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextboxPopupButton(
                      onTextSubmit: addNewNote,
                      controller: controller,),
                    TrashCan(),
                  ],
                ),
                flex: 2,
              ),
            ],
          )
      ),
    );
  }

  static Future<List<Widget>> fetchAllNotes() async {
    final response = await http.get(getUri("notes/"));
    List<dynamic> responseData = jsonDecode(response.body);
    return responseData.map((noteData) => Note.fromJSON(noteData)).toList();
  }

  /// Add a new note with given content to database
  static Future<http.Response> addNote(String content) async {
    return http.post(getUri("notes/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'content': content,
      }),
    );
  }

  /// Create uri for server with given endpoint
  static Uri getUri(String endpoint) {
    return Uri.parse("$SERVER_BASE_URL/$endpoint");
  }
}
