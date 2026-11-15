import 'package:flutter/material.dart';

// Klasa RegisterView odpowiada za ekran zakładania nowego konta.
class RegisterView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    // Proporcje ekranu
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Paleta kolorów
    const dotColor = Color(0xFFBB7CE8); // Jasny fiolet
    const phoneColor = Color(0xFF451A9A); // Ciemny fiolet

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Stack(
        children: [
          // Logo na stałej pozycji z animacją Hero
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
          
          // Formularz rejestracji
          Center(
            // Opakowujemy całość w SingleChildScrollView! 
            // Dzięki temu, gdy dodamy więcej pól i otworzy się klawiatura, ekran nie wyrzuci błędu "Overflow", tylko pozwoli się przewijać.
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Dodatkowy pusty odstęp na górze formularza, żeby przy wielu polach nie wjechały one pod logo
                    SizedBox(height: screenHeight * 0.18),

                    // --- POLE IMIĘ I NAZWISKO (FULL NAME) ---
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Full name',
                        hintText: 'John Doe', // Przykładowe imię
                        labelStyle: TextStyle(color: phoneColor),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: phoneColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: phoneColor, width: 2),
                        ),
                        prefixIcon: Icon(Icons.person, color: phoneColor), // Ikonka osoby
                      ),
                      keyboardType: TextInputType.name, // Podpowiada klawiaturę z dużymi literami
                    ),
                    
                    const SizedBox(height: 16),

                    // --- POLE EMAIL ---
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Email', 
                        hintText: 'email@test.com', 
                        labelStyle: TextStyle(color: phoneColor),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: phoneColor), 
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: phoneColor, width: 2), 
                        ),
                        prefixIcon: Icon(Icons.email, color: phoneColor),
                      ),
                      keyboardType: TextInputType.emailAddress, 
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // --- POLE HASŁO ---
                    const TextField(
                      obscureText: true, 
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: phoneColor),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: phoneColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: phoneColor, width: 2),
                        ),
                        prefixIcon: Icon(Icons.lock, color: phoneColor),
                      ),
                    ),
                    
                    const SizedBox(height: 16),

                    // --- POLE POTWIERDŹ HASŁO (CONFIRM PASSWORD) ---
                    const TextField(
                      obscureText: true, // Ukrywa wpisywane hasło (kropki)
                      decoration: InputDecoration(
                        labelText: 'Confirm password',
                        labelStyle: TextStyle(color: phoneColor),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: phoneColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: phoneColor, width: 2),
                        ),
                        prefixIcon: Icon(Icons.lock_outline, color: phoneColor), // Zmieniona ikonka kłódki na "obrys" dla odróżnienia
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // --- GŁÓWNY PRZYCISK REJESTRACJI ---
                    SizedBox(
                      width: double.infinity, 
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: dotColor, 
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          print('Próba rejestracji...');
                        },
                        child: const Text('Sign Up', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // --- DOLNY LINK POWROTU ---
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); 
                      },
                      style: TextButton.styleFrom(foregroundColor: dotColor),
                      child: const Text('Already have an account? Login'),
                    ),
                    
                    const SizedBox(height: 20), // Dodatkowy margines na dole ułatwiający przewijanie
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
