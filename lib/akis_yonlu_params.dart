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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var sinif = 5;
  var baslik = 'Öğrenciler';
  var ogrenciler = ['Ali', 'Ayse', 'Can'];

  @override
  void initState() {
    super.initState();
  }

  void addNewStudent(String newStudent) {
    setState(() {
      ogrenciler.add(newStudent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Class(
          sinif: sinif,
          baslik: baslik,
          ogrenciler: ogrenciler,
          addNewStudent: addNewStudent,
        ));
  }
}

class Class extends StatelessWidget {
  const Class(
      {super.key,
      required this.sinif,
      required this.baslik,
      required this.ogrenciler,
      required this.addNewStudent});

  final int sinif;
  final String baslik;
  final List<String> ogrenciler;
  final void Function(String newStudent) addNewStudent;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.star,
                color: Colors.yellow,
              ),
              Text(
                "$sinif.sinif",
              ),
              const Icon(
                Icons.star,
                color: Colors.yellow,
              ),
            ],
          ),
          Text(baslik.toString()),
          OgrenciListesi(ogrenciler: ogrenciler),
          OgrenciEkleme(addNewStudent: addNewStudent)
        ],
      ),
    );
  }
}

class OgrenciListesi extends StatelessWidget {
  const OgrenciListesi({
    super.key,
    required this.ogrenciler,
  });

  final List<String> ogrenciler;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final o in ogrenciler) Text(o),
      ],
    );
  }
}

class OgrenciEkleme extends StatefulWidget {
  const OgrenciEkleme({
    super.key,
    required this.addNewStudent,
  });

  final void Function(String newStudent) addNewStudent;

  @override
  State<OgrenciEkleme> createState() => _OgrenciEklemeState();
}

class _OgrenciEklemeState extends State<OgrenciEkleme> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          onChanged: (value) {
            setState(() {});
          },
        ),
        ElevatedButton(
          onPressed: controller.text.isEmpty
              ? null
              : () {
                  final newStudent = controller.text;
                  widget.addNewStudent(newStudent);
                  controller.text = "";
                },
          child: const Text("Ekle"),
        ),
      ],
    );
  }
}
