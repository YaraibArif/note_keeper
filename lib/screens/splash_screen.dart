import 'package:flutter/material.dart';
import 'package:notes_keeper_intern/constants/shared_prefs_keys.dart';
import 'package:notes_keeper_intern/utils/shared_preferences.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkFirstTimeLaunch();
  }

  Future<void> _checkFirstTimeLaunch() async {
    bool isFirstTime = SharedPref.getbool(AppKeys.isFirstTime) ?? true;

    if (isFirstTime) {
      await Future.delayed(const Duration(seconds: 2));
      await SharedPref.setBool(AppKeys.isFirstTime, false);
    } else {
      await Future.delayed(const Duration(seconds: 1));
    }

    await SharedPref.setlastopened(DateTime.now());

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.note_alt_rounded, size: 80, color: Colors.indigo),
            SizedBox(height: 16),
            Text(
              'Notes Keeper',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
