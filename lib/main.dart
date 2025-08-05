import 'package:flutter/material.dart';
import 'package:notes_keeper_intern/utils/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'providers/note_provider.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NoteProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes Keeper',
        theme: ThemeData(primarySwatch:
        Colors.indigo,
        scaffoldBackgroundColor: Colors.white),
        home:  const SplashScreen(),
      ),
    );
  }
}
