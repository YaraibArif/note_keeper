import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../utils/shared_preferences.dart';
import 'add_note_screen.dart';
import 'edit_note_screen.dart';
import '../widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? _lastOpened;

  @override
  void initState() {
    super.initState();
    _loadLastOpened();
  }

  void _loadLastOpened() {
    setState(() {
      _lastOpened = SharedPref.getLastopened();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("🏠 HomeScreen Loaded");
    final noteProvider = Provider.of<NoteProvider>(context);
    final notes = noteProvider.notes;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FD),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0,
        title: const Text(
          '📒 Notes Keeper',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (_lastOpened != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '📅 Last Opened: ${DateFormat('dd MMM yyyy – hh:mm a').format(_lastOpened!)}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          Expanded(
            child: notes.isEmpty
                ? const Center(
              child: Text(
                '📝 No notes yet.\nTap + to add your first note!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return Dismissible(
                  key: ValueKey(note.timestamp),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    Provider.of<NoteProvider>(context, listen: false)
                        .deleteNote(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('🗑️ Note Deleted')),
                    );
                  },
                  child: NoteCard(
                    note: note,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditNoteScreen(
                            note: note,
                            index: index,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddNoteScreen()),
          );
        },
        child: const Icon(Icons.add, size: 28, color: Colors.white),
      ),
    );
  }
}
