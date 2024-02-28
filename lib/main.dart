import 'package:flutter/material.dart';
import 'package:isar_app/models/note_database.dart';
import 'package:isar_app/pages/notepage.dart';
import 'package:isar_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  //initializing the isar databse
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDataBase.initialize();

  runApp(
     MultiProvider(providers: [
       ChangeNotifierProvider(create: (create)=> NoteDataBase()),
       ChangeNotifierProvider(create: (create)=> ThemeProvider()),
     ],
     child: const MyApp(),),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
      home:const NotePage(),
    );
  }
}

