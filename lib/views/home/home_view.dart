import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login/login_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    const Color phoneColor = Color(0xFF451A9A); 

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        automaticallyImplyLeading: false, 
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            // Przycisk wylogowania teraz musi być async
            onPressed: () async {
              // ----- NOWOŚĆ: Usuwanie zapisu z SharedPreferences -----
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false); // Nadpisujemy zmienną na fałsz
              
              if (!context.mounted) return;

              // Podmieniamy ekran domowy na logowanie
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
      body: Stack(
        children: [
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
          
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Witamy w Mobile Login System',
                textAlign: TextAlign.center, 
                style: TextStyle(
                  fontSize: 28, 
                  fontWeight: FontWeight.bold, 
                  color: phoneColor, 
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
