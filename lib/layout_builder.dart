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
    final mq = MediaQuery.of(context);
    final screenSize = mq.size;
    final desiredWidth = 300.0;
    final ratio = screenSize.width / desiredWidth;
    return FractionallySizedBox(
      widthFactor: 1 / ratio,
      heightFactor: 1 / ratio,
      child: Transform.scale(
        scale: ratio,
        child: MediaQuery(
          data: mq.copyWith(
            viewInsets:
                mq.viewInsets.copyWith(bottom: mq.viewInsets.bottom / ratio),
          ),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
            ),
            body: ClassInfo(
              sinif: sinif,
              baslik: baslik,
              ogrenciler: ogrenciler,
              addNewStudent: addNewStudent,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  BoxInBox(),
                  Positioned(
                    top: 100,
                    left: 10,
                    right: 10,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        var width_ = constraints.maxWidth;
                        print("constraints.maxWidth:$width_");
                        if (width_ > 450) {
                          return const Row(
                            children: [
                              Class(),
                              Text("Secili ogrenci detayları")
                            ],
                          );
                        } else {
                          return const Class();
                        }
                      },
                    ),
                  ),
                  const Positioned(
                    // top: 550, Top kullanmak doğru değildir.
                    bottom: 20,
                    left: 10,
                    right: 10,
                    child: OgrenciEkleme(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ClassInfo extends InheritedWidget {
  const ClassInfo({
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
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
        const OgrenciListesi(),
      ],
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
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: controller.text.isEmpty
                ? null
                : () {
                    final newStudent = controller.text;
                    classInfo.addNewStudent(newStudent);
                    controller.text = "";
                  },
            child: const Text("Ekle"),
          ),
        ),
      ],
    );
  }
}

class BoxInBox extends StatelessWidget {
  const BoxInBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 200,
      child: Container(
        // color: Colors.yellow,
        child: Center(
          child: Container(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 50,
                height: 100,
                color: Colors.red,
                child: const Center(
                  child: Text("ABDU"),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
