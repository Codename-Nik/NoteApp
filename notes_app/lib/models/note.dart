class Note {
  int? id;
  String title;
  String content;
  DateTime date;
  DateTime time;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.time,
  });

  Note copy({
    int? id,
    String? title,
    String? content,
    DateTime? date,
    DateTime? time,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
      'time': time.toIso8601String(),
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      date: DateTime.parse(map['date']),
      time: DateTime.parse(map['time']),
    );
  }
}
