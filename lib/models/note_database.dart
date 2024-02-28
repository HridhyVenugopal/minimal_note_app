import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:isar_app/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDataBase extends ChangeNotifier{

  static late Isar isar; //object of isar

  //INITIALIZE DATABASE
  static Future<void>initialize() async{
    final dir =  await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }
  //creating a list of notes
  final List<Note>currentNotes = [];

  //CREATE - creating a note and save it to db
  Future<void> addNote(String textFromUser) async{

     //creating a new note app
     final newNote = Note()..text = textFromUser;

     //saving it to db
     await isar.writeTxn(() => isar.notes.put(newNote));

     //re-read from db

  }

  //READ - a note from db
  Future<void> fetchNotes() async{
    List<Note> fetchNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNotes);
    notifyListeners();
  }

  //UPDATE - a note in db
  Future<void> updateNotes(int id,String newText) async{
    final existingNote = await isar.notes.get(id);
    if(existingNote != null){
      existingNote.text = newText; 
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  //DELETE -  a note from db
  Future<void> deleteNote (int id) async{
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}