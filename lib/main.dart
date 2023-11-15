import 'package:flutter/material.dart';
import 'package:notesapp/src/provider/notes_provider.dart';
import 'package:notesapp/src/res/color_theme.dart';
import 'package:notesapp/src/views/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (ctx) => NoteProvider())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              fontFamily: "Nunito",
              useMaterial3: false,
              scaffoldBackgroundColor: AppColor.apptheme),
          home: const Homepage()),
    );
  }
}
