import 'package:flutter/material.dart';

// Klasa reprezentująca główny ekran po zalogowaniu.
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Proporcje ekranu
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Paleta kolorów
    const Color dotColor = Color(0xFFBB7CE8); // Jasny fiolet
    const Color phoneColor = Color(0xFF451A9A); // Ciemny fiolet

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        // Zapobiega automatycznemu wstawieniu strzałki "wstecz" na górnym pasku
        automaticallyImplyLeading: false, 
        actions: [
          // Przycisk do wylogowywania (w prawym rogu paska)
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Powrót do ekranu logowania (zrzucenie wszystkiego ze stosu)
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Stack(
        children: [
          // Ponownie wykorzystujemy naszą animację Hero z logiem!
          // Logo poleci na górę po zalogowaniu
          Positioned(
            top: screenHeight * 0.05,
            left: 0,
            right: 0,
            child: Hero(
              tag: 'app_logo',
              child: Image.asset(
                'assets/logo.png',
                height: screenHeight * 0.16,
                fit: BoxFit.contain,
              ),
            ),
          ),
          
          // Główny napis na środku ekranu
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Witamy w Mobile Login System',
                textAlign: TextAlign.center, // Wyśrodkowanie samego tekstu
                style: TextStyle(
                  fontSize: 28, // Duża czcionka
                  fontWeight: FontWeight.bold, // Pogrubiona
                  color: phoneColor, // Ciemnofioletowy kolor z logo
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
