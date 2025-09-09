class Note {
  int? id;
  String? content;

  Note({this.id, this.content});

  // map to note
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(id: map['id'] as int, content: map['content'] as String);
  }

  // note to map
  Map<String, dynamic> toMap() {
    return {'content': content};
  }
}
