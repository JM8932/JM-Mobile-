import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'views/login/login_view.dart';
import 'views/home/home_view.dart';

// Zmieniamy funkcję main na 'async', ponieważ musimy poczekać 
// na odczyt z pamięci telefonu PRZED uruchomieniem aplikacji.
void main() async {
  // Ważne we Flutterze: Gwarantuje, że komunikacja z natywnym kodem telefonu
  // (np. z modułem zapisu danych) działa zanim włączymy widgety.
  WidgetsFlutterBinding.ensureInitialized();

  // Zaglądamy do "notesu" z danymi aplikacji
  final prefs = await SharedPreferences.getInstance();
  
  // Odczytujemy zapisaną wcześniej flagę 'isLoggedIn'. 
  // Jeżeli zmiennej tam nie ma (bo aplikacja jest świeża), to domyślnie przyjmujemy false (niezalogowany).
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  // Przekazujemy odczytany stan logowania bezpośrednio do naszej aplikacji
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

// Główny widget aplikacji.
class MyApp extends StatelessWidget {
  // Przechowujemy informację czy użytkownik był wcześniej zalogowany
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFBB7CE8)),
      ),
      // Mądry wybór ekranu głównego (Ternary operator: warunek ? PRAWDA : FAŁSZ)
      // Jeśli isLoggedIn = true, odpalamy HomeView. W przeciwnym razie - LoginView.
      home: isLoggedIn ? const HomeView() : const LoginView(),
    );
  }
}
