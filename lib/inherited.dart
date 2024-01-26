// ignore: file_names
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
      ogrenciler = [...ogrenciler, newStudent];
      // ogrenciler.add(newStudent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ClassInfo(
        sinif: sinif,
        baslik: baslik,
        ogrenciler: ogrenciler,
        addNewStudent: addNewStudent,
        child: const Class(),
      ),
    );
  }
}

class ClassInfo extends InheritedWidget {
  ClassInfo({
    super.key,
    required this.sinif,
    required this.baslik,
    required this.ogrenciler,
    required this.addNewStudent,
    required super.child,
  });

  final int sinif;
  final String baslik;
  final List<String> ogrenciler;
  final void Function(String newStudent) addNewStudent;

  static ClassInfo of(BuildContext context) {
    final ClassInfo? result =
        context.dependOnInheritedWidgetOfExactType<ClassInfo>();
    assert(result != null, 'No ClassInfo found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ClassInfo oldWidget) {
    return oldWidget.sinif != sinif ||
        oldWidget.baslik != baslik ||
        oldWidget.ogrenciler != ogrenciler ||
        oldWidget.addNewStudent != addNewStudent;
  }
}

class Class extends StatelessWidget {
  const Class({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final classInfo = ClassInfo.of(context);
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
                "${classInfo.sinif}.sinif",
              ),
              const Icon(
                Icons.star,
                color: Colors.yellow,
              ),
            ],
          ),
          Text(classInfo.baslik.toString()),
          OgrenciListesi(),
          OgrenciEkleme()
        ],
      ),
    );
  }
}

class OgrenciListesi extends StatelessWidget {
  const OgrenciListesi({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final classInfo = ClassInfo.of(context);
    return Column(
      children: [
        for (final o in classInfo.ogrenciler) Text(o),
      ],
    );
  }
}

class OgrenciEkleme extends StatefulWidget {
  const OgrenciEkleme({
    super.key,
  });

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
    final classInfo = ClassInfo.of(context);
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
                  classInfo.addNewStudent(newStudent);
                  controller.text = "";
                },
          child: const Text("Ekle"),
        ),
      ],
    );
  }
}
