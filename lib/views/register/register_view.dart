import 'package:flutter/material.dart';

// Klasa reprezentująca ekran (widok) rejestracji konta.
class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Pobieramy kolor fioletowy przypominający kropkę z Twojego logo
    const Color dotColor = Color(0xFFBB7CE8);

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Kurczy kolumnę do wielkości dzieci, by Center mogło ją wyśrodkować
                children: [
                  // Pole do wpisania Emaila
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  
                  // Pole do wpisania Hasła
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Główny przycisk Rejestracji
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: dotColor,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        // Tutaj w przyszłości dodamy logikę rejestracji
                        print("Próba rejestracji...");
                      },
                      child: const Text('Sign Up', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Przycisk tekstowy do powrotu do logowania
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Wraca na poprzedni ekran
                    },
                    style: TextButton.styleFrom(foregroundColor: dotColor),
                    child: const Text('Already have an account? Login'),
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
