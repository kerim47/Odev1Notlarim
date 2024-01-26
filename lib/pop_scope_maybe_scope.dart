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
      home: HomePage(
        title: 'Flutter Demo Home Page',
        centerTitle: "Bu Ana Sayfadir.",
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.title, required this.centerTitle});

  final String title;
  final String centerTitle;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (sonuc) {
        debugPrint("onPopInvoked : $sonuc");
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(centerTitle),
              ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.of(context).push<bool>(
                      MaterialPageRoute(
                        builder: (context) {
                          return ViewPage(
                            title: "ViewPage",
                            centerTitle: "This is a View Page",
                          );
                        },
                      ),
                    );
                    debugPrint("Sonuc : $result");
                    if (result == true) {
                      debugPrint("Beğendi");
                    } else {
                      debugPrint("Beğenmedi");
                    }
                  },
                  child: const Text("Goto"))
            ],
          ),
        ),
      ),
    );
  }
}

class ViewPage extends StatelessWidget {
  ViewPage({super.key, required this.title, required this.centerTitle});

  final String title;
  final String centerTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(centerTitle),
            ElevatedButton(
              child: Text("Evet"),
              onPressed: () {
                // Navigator.of(context).pop(true);
                Navigator.of(context).maybePop(true);
              },
            ),
            ElevatedButton(
              child: Text("Hayır"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            ElevatedButton(
                onPressed: () {},

                // onPressed: gotoPage == null
                //     ? () {
                //         Navigator.pop(context);
                //       }
                //     : () {
                //         Navigator.push(context,
                //             MaterialPageRoute(builder: (context) => gotoPage!));
                //         // Navigator.of(context).push(
                //         //   MaterialPageRoute(
                //         //     builder: (context) {
                //         //       return gotoPage!;
                //         //     },
                //         //   ),
                //         // );
                //       },
                child: const Text("Goto"))
          ],
        ),
      ),
    );
  }
}

class PopView extends StatelessWidget {
  PopView(
      {super.key,
      required this.title,
      required this.centerTitle,
      required this.gotoPage});

  final String title;
  final String centerTitle;
  final Widget? gotoPage;
  // final void Function(BuildContext context) gotoPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(centerTitle),
            ElevatedButton(
                onPressed: gotoPage == null
                    ? () {
                        Navigator.pop(context);
                      }
                    : () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => gotoPage!));
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return gotoPage!;
                        //     },
                        //   ),
                        // );
                      },
                child: const Text("Goto"))
          ],
        ),
      ),
    );
  }
}
