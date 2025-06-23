import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/sqlite_db.dart';
import '../services/file_storage.dart';
import 'note_detail.dart';

class NoteSearchDelegate extends SearchDelegate<String> {
  final SQLiteDB db = SQLiteDB.instance;
  final FileStorage fileStorage = FileStorage();
  bool _searchInFiles = false;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
      Switch(
        value: _searchInFiles,
        onChanged: (value) {
          _searchInFiles = value;
          showResults(context);
        },
      ),
      Text(_searchInFiles ? 'Файлы' : 'SQLite'),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Note>>(
      future: _searchInFiles
          ? fileStorage.searchInFiles(query)
          : db.searchNotes(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Ошибка поиска'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Ничего не найдено'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            Note note = snapshot.data![index];
            return ListTile(
              title: Text(note.title),
              subtitle: Text(
                note.content.length > 50
                    ? '${note.content.substring(0, 50)}...'
                    : note.content,
              ),
              onTap: () {
                close(context, '');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteDetailScreen(note: note),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
