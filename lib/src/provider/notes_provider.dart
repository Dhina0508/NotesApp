import 'package:flutter/material.dart';
import 'package:notesapp/src/models/notes_model.dart';
import 'package:notesapp/src/repo/api_service.dart';

class NoteProvider extends ChangeNotifier {
  NotesListModel? _nlm;
  NotesListModel? get nlm => _nlm;

  Future<void> fetchData() async {
    _nlm = NotesListModel.fromJson(
        await ApiService.fetchData() as Map<String, dynamic>);

    notifyListeners();
  }
}
