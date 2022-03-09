import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:health_notes/widgets/notes/note.dart';

/// API class to interact with backend server
/// to fetch/update notes data
class NotesData {
  // Alias host name for android emulator, with server
  // listening at port 3000
  static const SERVER_BASE_URL = "http://10.0.2.2:3000";

  /// Get all notes from database
  static Future<List<Note>> fetchAllNotes() async {
    final response = await http.get(getUri("notes/"));
    List<dynamic> responseData = jsonDecode(response.body);
    return responseData.map((noteData) => Note.fromJSON(noteData)).toList();
  }

  /// Add a new note with given content to database
  static Future<http.Response> addNote(String content) async {
    return postWithData(
        "notes/",
        <String, String> {'content': content,}
    );
  }

  /// Delete a note with matching content from database
  static Future<http.Response> deleteNote(String content) async {
    return postWithData(
        "delete/notes/",
        <String, String> {'content': content,}
    );
  }

  /// Create uri for server with given endpoint
  static Uri getUri(String endpoint) {
    return Uri.parse("$SERVER_BASE_URL/$endpoint");
  }

  /// Wrapper method to post to endpoint with given dictionary data as JSON
  static Future<http.Response> postWithData(String endpoint,
      Map<String, dynamic> data) {
    return http.post(
      getUri(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
  }
}
