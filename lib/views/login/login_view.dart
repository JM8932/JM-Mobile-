import 'package:flutter/material.dart';
import '../register/register_view.dart';

// Klasa reprezentująca ekran (widok) logowania.
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    // Pobieramy kolor fioletowy przypominający kropkę z Twojego logo
    const Color dotColor = Color(0xFFBB7CE8);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      // Używamy widżetu Stack, aby niezależnie pozycjonować elementy
      body: Stack(
        children: [
          // Logo przypięte sztywno u góry
          Positioned(
            top: screenHeight * 0.05,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/logo.png',
              height: screenHeight * 0.16,
              fit: BoxFit.contain,
            ),
          ),
          
          // Formularz na środku ekranu
          Center(
            // Padding daje marginesy po bokach, by pola tekstowe nie dotykały krawędzi
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              // Column z mainAxisSize.min sprawia, że kolumna zajmuje tylko tyle miejsca, ile potrzebują jej dzieci (i dzięki Center wyśrodkuje się na ekranie)
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Pole do wpisania Emaila
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(), // Ładna ramka dookoła pola
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16), // Odstęp między polami
                  
                  // Pole do wpisania Hasła
                  const TextField(
                    obscureText: true, // Ukrywa wpisywany tekst (kropki zamiast liter)
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 24), // Większy odstęp przed przyciskiem
                  
                  // Główny przycisk Logowania
                  SizedBox(
                    width: double.infinity, // Przycisk rozciągnięty na całą szerokość formularza
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: dotColor, // Kolor tła przycisku
                        foregroundColor: Colors.white, // Kolor czcionki na przycisku
                      ),
                      onPressed: () {
                        // Tutaj w przyszłości dodamy logikę logowania
                        print("Próba logowania...");
                      },
                      child: const Text('Login', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Mniejszy przycisk tekstowy do przejścia na rejestrację
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterView()),
                      );
                    },
                    style: TextButton.styleFrom(foregroundColor: dotColor),
                    child: const Text('Don\'t have an account? Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
