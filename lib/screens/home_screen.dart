import 'package:flutter/material.dart';
import '../models/folder_model.dart';
import '../repositories/folder_repository.dart';
import 'folder_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final folderRepo = FolderRepository();
  List<FolderModel> folders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFolders();
  }

  Future<void> _loadFolders() async {
    try {
      await folderRepo.insertDefaultFolders(); // insert Hearts, Spades, etc.
      final data = await folderRepo.getAllFolders();
      setState(() {
        folders = data;
        isLoading = false;
      });
      print("Folders loaded: ${folders.map((f) => f.name).toList()}");
    } catch (e) {
      print("Error loading folders: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Card Organizer')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : folders.isEmpty
              ? const Center(child: Text('No folders found'))
              : ListView.builder(
                  itemCount: folders.length,
                  itemBuilder: (context, index) {
                    final folder = folders[index];
                    return ListTile(
                      title: Text(folder.name),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FolderDetailScreen(folder: folder),
                          ),
                        ).then((_) => _loadFolders());
                      },
                    );
                  },
                ),
    );
  }
}
