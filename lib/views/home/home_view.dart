import 'package:dsw60352test/models/item_model.dart';
import 'package:dsw60352test/services/db_helper.dart';
import 'package:dsw60352test/views/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Zmieniamy na StatefulWidget, aby ekran aktualizował się, gdy dodamy/usuniemy element z bazy
class HomeView extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final Color dotColor = const Color(0xFFBB7CE8);
  final Color phoneColor = const Color(0xFF451A9A);

  List<Item> _itemsList = []; // Lista przechowująca elementy odczytane z bazy
  bool _isLoading = true; // Flaga ładowania

  @override
  void initState() {
    super.initState();
    _refreshItems(); // Pobieramy elementy z bazy od razu po otwarciu ekranu
  }

  // Odświeża widok (Pobiera z bazy SQLite i wpisuje do listy)
  Future<void> _refreshItems() async {
    final items = await DatabaseHelper.instance.getItems();
    setState(() {
      _itemsList = items;
      _isLoading = false;
    });
  }

  // Funkcja pokazująca okno modalne na dole ekranu (służy do dodawania i edycji)
  Future<void> _showForm(int? id) async {
    // Kontrolery dla konkretnego pola
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    // Jeśli otrzymaliśmy 'id', oznacza to, że chcemy zaktualizować (U) istniejący element, a nie stworzyć (C) nowy.
    if (id != null) {
      final existingItem = _itemsList.firstWhere((element) => element.id == id);
      titleController.text = existingItem.title;
      descriptionController.text = existingItem.description;
    }

    // Modal Bottom Sheet - wyjeżdżające z dołu białe menu
    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24,
          // Automatycznie unosi formularz, gdy wysunie się klawiatura na ekranie
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Kurczy formularz
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: phoneColor),
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: phoneColor, width: 2)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: phoneColor),
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: phoneColor, width: 2)),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: phoneColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  // Walidacja, by nie dodawać pustych wpisów
                  if (titleController.text.trim().isEmpty || descriptionController.text.trim().isEmpty) return;

                  // Jeśli id jest równe null, to tworzymy wpis (Create)
                  if (id == null) {
                    await DatabaseHelper.instance.insertItem(
                      Item(title: titleController.text, description: descriptionController.text),
                    );
                  } 
                  // Jeśli id jest podane, edytujemy istniejący wpis (Update)
                  else {
                    await DatabaseHelper.instance.updateItem(
                      Item(id: id, title: titleController.text, description: descriptionController.text),
                    );
                  }

                  // Czyścimy kontrolery, zamykamy okienko modalne i odświeżamy listę
                  titleController.text = '';
                  descriptionController.text = '';
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                  _refreshItems();
                },
                child: Text(id == null ? 'Create New' : 'Update', style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Funkcja usuwająca element z bazy (D - Delete)
  Future<void> _deleteItem(int id) async {
    await DatabaseHelper.instance.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Successfully deleted an item!'), backgroundColor: Colors.redAccent),
    );
    _refreshItems();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[100], // Lekko szare tło dla lepszego kontrastu kart
      appBar: AppBar(
        title: const Text('Dashboard'),
        automaticallyImplyLeading: false, 
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false); 
              
              if (!context.mounted) return;
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const LoginView(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  transitionDuration: const Duration(milliseconds: 400),
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          // Logo na górze, mniejsze po zalogowaniu by dać miejsce na notatki
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            color: Colors.white,
            width: double.infinity,
            child: Hero(
              tag: 'app_logo',
              child: Image.asset(
                'assets/logo.png',
                height: screenHeight * 0.10, // Logo pomniejszone do 10% wysokości
                fit: BoxFit.contain,
              ),
            ),
          ),
          
          const Divider(height: 1, thickness: 1), // Ozdobna linia oddzielająca

          // Lista odczytanych z bazy elementów
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator(color: dotColor))
                : _itemsList.isEmpty
                    ? const Center(child: Text('No items yet. Add one!', style: TextStyle(fontSize: 16)))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _itemsList.length,
                        itemBuilder: (context, index) {
                          final item = _itemsList[index];
                          // Karta (Card) pięknie formatująca każdy pojedynczy wpis
                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(item.description, style: const TextStyle(fontSize: 14)),
                              ),
                              // Ikony edycji i usuwania na końcu karty
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, color: dotColor),
                                    onPressed: () => _showForm(item.id),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                                    onPressed: () => _deleteItem(item.id!),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      
      // Pływający Przycisk Dodawania na dole ekranu
      floatingActionButton: FloatingActionButton(
        backgroundColor: dotColor,
        foregroundColor: Colors.white,
        onPressed: () => _showForm(null), // Null przekazywany, by otworzyć czysty formularz (Create)
        child: const Icon(Icons.add),
      ),
    );
  }
}
