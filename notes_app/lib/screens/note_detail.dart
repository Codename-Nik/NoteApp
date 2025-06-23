import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/sqlite_db.dart';
import '../services/file_storage.dart';

class NoteDetailScreen extends StatefulWidget {
  final Note? note;

  NoteDetailScreen({this.note});

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _content;
  late DateTime _date;
  late DateTime _time;
  final SQLiteDB db = SQLiteDB.instance;
  final FileStorage fileStorage = FileStorage();
  bool _useFileStorage = false;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _title = widget.note!.title;
      _content = widget.note!.content;
      _date = widget.note!.date;
      _time = widget.note!.time;
    } else {
      _title = '';
      _content = '';
      _date = DateTime.now();
      _time = DateTime.now();
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_time),
    );
    if (picked != null) {
      setState(() {
        _time = DateTime(
          _date.year,
          _date.month,
          _date.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  Future<void> _saveNote() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Note note = Note(
        id: widget.note?.id,
        title: _title,
        content: _content,
        date: _date,
        time: _time,
      );

      if (_useFileStorage) {
        if (note.id == null) {
          // Для новых заметок в файловой системе создаем уникальный ID
          note = note.copy(id: DateTime.now().millisecondsSinceEpoch);
        }
        await fileStorage.saveNoteToFile(note);
      } else {
        if (note.id == null) {
          await db.create(note);
        } else {
          await db.update(note);
        }
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Новая заметка' : 'Редактировать'),
        actions: [
          Switch(
            value: _useFileStorage,
            onChanged: (value) {
              setState(() {
                _useFileStorage = value;
              });
            },
          ),
          Text(_useFileStorage ? 'Файлы' : 'SQLite'),
          IconButton(icon: Icon(Icons.save), onPressed: _saveNote),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(
                  labelText: 'Заголовок',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите заголовок';
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _content,
                decoration: InputDecoration(
                  labelText: 'Содержание',
                  border: OutlineInputBorder(),
                ),
                maxLines: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите содержание заметки';
                  }
                  return null;
                },
                onSaved: (value) => _content = value!,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Дата: ${_date.day}.${_date.month}.${_date.year}',
                      ),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () => _selectDate(context),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text('Время: ${_time.hour}:${_time.minute}'),
                      trailing: Icon(Icons.access_time),
                      onTap: () => _selectTime(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
