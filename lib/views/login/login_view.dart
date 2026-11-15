import 'package:flutter/material.dart';
import '../register/register_view.dart';
import '../home/home_view.dart'; // Importujemy nowy widok ekranu głównego

// Zmieniamy LoginView na StatefulWidget, ponieważ teraz nasz ekran 
// musi reagować na wpisywany tekst i zmieniać swój STAN (wyświetlać błędy).
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Kontrolery służą do odczytywania tego, co użytkownik wpisał w pola tekstowe
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Zmienne przechowujące komunikaty o błędach (jeśli null - błędu nie ma)
  String? _emailError;
  String? _passwordError;

  // Przykładowe (testowe) dane logowania wymagane w zadaniu
  final String _mockEmail = 'email@test.com';
  final String _mockPassword = 'password123';

  // Funkcja wywoływana po kliknięciu przycisku Login
  void _attemptLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Najpierw resetujemy błędy przed każdą nową próbą
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    bool isValid = true;

    // Walidacja e-maila: sprawdzamy czy ma '@' oraz czy zgadza się z naszym testowym
    if (!email.contains('@') || email != _mockEmail) {
      setState(() {
        _emailError = 'Invalid email';
      });
      isValid = false;
    }

    // Walidacja hasła: sprawdzamy czy zgadza się z testowym
    if (password != _mockPassword) {
      setState(() {
        _passwordError = 'Invalid password';
      });
      isValid = false;
    }

    // Jeśli wszystko się zgadza
    if (isValid) {
      print("Zalogowano pomyślnie jako $_mockEmail!");
      
      // Czyszczenie pól po poprawnym zalogowaniu, by po wylogowaniu ekran był pusty
      _emailController.clear();
      _passwordController.clear();

      // Przejście do głównego ekranu aplikacji (HomeView) z animacją
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const HomeView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 400),
        ),
      );
    }
  }

  // Ważne: Zwalniamy pamięć po kontrolerach, gdy ekran jest zamykany
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    const Color dotColor = Color(0xFFBB7CE8);
    const Color phoneColor = Color(0xFF451A9A);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
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
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // --- POLE EMAIL ---
                  TextField(
                    controller: _emailController, // Podpinamy kontroler
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'email@test.com',
                      errorText: _emailError, // Automatycznie wyświetla czerwony tekst błędu pod polem!
                      labelStyle: const TextStyle(color: phoneColor),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: phoneColor),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: phoneColor, width: 2.0),
                      ),
                      // Dodajemy też obramówkę dla stanu błędu, żeby była czerwona
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                      ),
                      prefixIcon: const Icon(Icons.email, color: phoneColor),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  
                  // --- POLE HASŁO ---
                  TextField(
                    controller: _passwordController, // Podpinamy kontroler
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: _passwordError, // Wyświetlanie błędu hasła
                      labelStyle: const TextStyle(color: phoneColor),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: phoneColor),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: phoneColor, width: 2.0),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                      ),
                      prefixIcon: const Icon(Icons.lock, color: phoneColor),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // --- PRZYCISK LOGOWANIA ---
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: dotColor,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _attemptLogin, // Podpinamy naszą funkcję walidującą
                      child: const Text('Login', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  TextButton(
                    onPressed: () {
                      // Przejście na ekran rejestracji też zdejmujemy błędy, by ekran był czysty po powrocie
                      setState(() {
                        _emailError = null;
                        _passwordError = null;
                        // Czyścimy też pola z błędnymi danymi
                        _emailController.clear();
                        _passwordController.clear();
                      });
                      
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const RegisterView(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(opacity: animation, child: child);
                          },
                          transitionDuration: const Duration(milliseconds: 400),
                        ),
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
