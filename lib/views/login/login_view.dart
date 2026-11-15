import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../register/register_view.dart';
import '../home/home_view.dart'; 

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  final String _mockEmail = 'email@test.com';
  final String _mockPassword = 'password123';

  // Funkcja logowania musi być teraz 'async', bo zapisywanie na dysku telefonu chwilę trwa
  Future<void> _attemptLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    bool isValid = true;

    if (!email.contains('@') || email != _mockEmail) {
      setState(() {
        _emailError = 'Invalid email';
      });
      isValid = false;
    }

    if (password != _mockPassword) {
      setState(() {
        _passwordError = 'Invalid password';
      });
      isValid = false;
    }

    if (isValid) {
      print("Zalogowano pomyślnie jako $_mockEmail!");

      // ----- NOWOŚĆ: Zapis do SharedPreferences -----
      // Otwieramy "notes" telefonu i zapisujemy, że użytkownik zalogował się poprawnie
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      // ----------------------------------------------
      
      _emailController.clear();
      _passwordController.clear();

      // Zabezpieczenie Fluttera - upewniamy się, że po odczekaniu na zapis dyskowy 
      // nasz ekran logowania nadal jest otwarty i możemy nawigować.
      if (!context.mounted) return;

      // Zamieniamy obecny ekran (LoginView) na nowy (HomeView) - pushReplacement!
      // Dzięki temu użytkownik klikając w telefonie sprzętowy przycisk "Wstecz" 
      // nie wróci do ekranu logowania (bo ten został wykasowany ze stosu).
      Navigator.pushReplacement(
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
                  TextField(
                    controller: _emailController, 
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'email@test.com', 
                      errorText: _emailError, 
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
                      prefixIcon: const Icon(Icons.email, color: phoneColor),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: _passwordError, 
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
                  
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: dotColor,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _attemptLogin, 
                      child: const Text('Login', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _emailError = null;
                        _passwordError = null;
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
