import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar_app/drawer/drawerr.dart';
import 'package:isar_app/models/note.dart';
import 'package:isar_app/models/note_database.dart';
import 'package:isar_app/pages/noteTile.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
   //text controller to access user input
    final textController = TextEditingController();

    @override
  void initState() {
    super.initState();
    readNote();
  }

  //create a note
  void createNote(){
    showDialog(context: context, builder: (context)=>AlertDialog(
      content: TextField(
        controller: textController,
      ),
      actions: [
        //creating buttons
        MaterialButton(onPressed: (){
          //add to db
          context.read<NoteDataBase>().addNote(textController.text);

          //to clear
          textController.clear();

          //to pop the dialog box
          Navigator.pop(context);
        },
        child: const Text("Create"),)
      ],
    ));
  }

  //read a note
  void readNote(){
    context.read<NoteDataBase>().fetchNotes();
  }

  //update a note
  void updateNote(Note note){
    //for pre-filling current note
    textController.text = note.text;
    showDialog(context: context, builder: (context)=>AlertDialog(
      title:  Text("Update Notes",style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
      content: TextField(
        controller: textController),
        actions: [
           //update Button
          MaterialButton(onPressed: (){

          //update notes in db
          context.read<NoteDataBase>().updateNotes(note.id, textController.text);

          //clear fiels
          textController.clear();

          //pop dialog
          Navigator.pop(context);
          },
          child: const Text("Update"),)
        ],
    ));
  }

  //delete a note
  void deleNote(int id){
    context.read<NoteDataBase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {

    //note Database
    final noteDatabase =  context.watch<NoteDataBase>();

    //Current Notes
    List<Note>currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      centerTitle: true,),
      floatingActionButton: FloatingActionButton(onPressed: createNote,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      child: const Icon(Icons.add),
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child:  Text("Notes",style: GoogleFonts.dmSerifText(fontSize: 40,
                color: Theme.of(context).colorScheme.inversePrimary),),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context,index){

              //get individual notes
              final note =  currentNotes[index];

              //List tile UI
              return NoteTile(text: note.text,
              onEditPressed: ()=>updateNote(note),
              onDeletePressed: ()=>deleNote(note.id),);
            }),
          ),
        ],
      ),
    );
  }
}