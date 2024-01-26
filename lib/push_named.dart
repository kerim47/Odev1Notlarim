import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const HomePage(
      //   title: 'Flutter Demo Home Page',
      //   centerTitle: "Bu Ana Sayfadir.",
      // ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(
            title: 'Flutter Demo Home Page', centerTitle: "Bu Ana Sayfadir."),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title, required this.centerTitle});

  final String title;
  final String centerTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(centerTitle),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/settings");
              },
              child: const Text("Evet"),
            ),
          ],
        ),
      ),
    );
  }
}
