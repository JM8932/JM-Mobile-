import 'package:flutter/material.dart';
import 'views/login/login_view.dart';

// Główna funkcja uruchamiająca aplikację. Zawsze musi nazywać się 'main'.
void main() {
  runApp(const MyApp());
}

// Główny widget aplikacji. Konfiguruje podstawowe ustawienia,
// takie jak motyw graficzny (ThemeData) czy początkowy ekran.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // Właściwość 'home' decyduje, jaki ekran zostanie załadowany jako pierwszy
      // po uruchomieniu aplikacji. W tym przypadku ustawiamy go na LoginView.
      home: const LoginView(),
    );
  }
}
