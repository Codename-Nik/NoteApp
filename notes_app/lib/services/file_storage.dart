import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../models/note.dart';

class FileStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _getFile(String filename) async {
    final path = await _localPath;
    return File('$path/$filename');
  }

  Future<void> saveNoteToFile(Note note) async {
    final file = await _getFile('note_${note.id}.json');
    await file.writeAsString(jsonEncode(note.toMap()));
  }

  Future<Note?> readNoteFromFile(int id) async {
    try {
      final file = await _getFile('note_$id.json');
      final contents = await file.readAsString();
      return Note.fromMap(jsonDecode(contents));
    } catch (e) {
      return null;
    }
  }

  Future<List<Note>> readAllNotesFromFiles() async {
    final path = await _localPath;
    final dir = Directory(path);
    final files = await dir
        .list()
        .where((file) => file.path.endsWith('.json'))
        .toList();

    List<Note> notes = [];
    for (var file in files) {
      final contents = await File(file.path).readAsString();
      notes.add(Note.fromMap(jsonDecode(contents)));
    }

    return notes;
  }

  Future<void> deleteNoteFile(int id) async {
    final file = await _getFile('note_$id.json');
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<List<Note>> searchInFiles(String query) async {
    final notes = await readAllNotesFromFiles();
    return notes
        .where(
          (note) =>
              note.title.toLowerCase().contains(query.toLowerCase()) ||
              note.content.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
