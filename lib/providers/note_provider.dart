import 'package:flutter/cupertino.dart';
import '../models/note.dart';
import 'package:flutter/foundation.dart';

class NoteProvider with ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => _notes;

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void updateNote(int index, Note newNote) {
    _notes[index] = newNote;
    notifyListeners();
  }

  void deleteNote(int index) {
    _notes.removeAt(index);
    notifyListeners();
  }
}
