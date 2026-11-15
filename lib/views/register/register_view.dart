import 'package:flutter/material.dart';

// Klasa reprezentująca ekran (widok) rejestracji konta.
class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Kolory z Twojego logo
    const Color dotColor = Color(0xFFBB7CE8); // Jasny fioletowy (kropki/tekst guzika)
    const Color phoneColor = Color(0xFF451A9A); // Ciemny fioletowy (środek telefonu/obramówki)

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Stack(
        children: [
          // Logo przypięte sztywno u góry z animacją Hero
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
          
          // Formularz na środku ekranu
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Pole do wpisania Emaila - z wyszarzonym podpowiadaczem
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'email@test.com', // Wyszarzony przykład dla użytkownika
                      labelStyle: const TextStyle(color: phoneColor),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: phoneColor),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: phoneColor, width: 2.0),
                      ),
                      prefixIcon: const Icon(Icons.email, color: phoneColor),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  
                  // Pole do wpisania Hasła
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: phoneColor),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: phoneColor),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: phoneColor, width: 2.0),
                      ),
                      prefixIcon: const Icon(Icons.lock, color: phoneColor),
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
                        print("Próba rejestracji...");
                      },
                      child: const Text('Sign Up', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Przycisk tekstowy do powrotu do logowania
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
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
