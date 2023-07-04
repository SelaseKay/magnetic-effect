import 'package:flutter/material.dart';
import 'package:grid_draggable/magnet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Magnetic Effect Demo'),
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
  final GlobalKey _magnet1Key = GlobalKey();
  final GlobalKey _magnet2Key = GlobalKey();

  double left1 = 100.0, left2 = 200.0, top1 = 200.0, top2 = 200.0;
  late double left1Prev;
  late double left2Prev;
  late double top1Prev;
  late double top2Prev;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.brown,
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Magnet(
              magnetKey: _magnet1Key,
              top: top1,
              left: left1,
              color: const Color(0xFFC0C0C0),
              onPanDown: (d) {
                left1Prev = left1;
                top1Prev = top1;
              },
              onPanUpdate: (details) {
                if (_checkCollision()) {
                  setState(() {
                    left2 = left1;
                    top2 = top1;
                  });
                }
                setState(() {
                  left1 = details.localPosition.dx + left1Prev - 50;
                  top1 = details.localPosition.dy + top1Prev - 50;
                });
              },
            ),
            Magnet(
              magnetKey: _magnet2Key,
              top: top2,
              left: left2,
              color: Colors.black,
              onPanDown: (details) {
                left2Prev = left2;
                top2Prev = top2;
              },
              onPanUpdate: (details) {
                if (_checkCollision()) {
                  setState(() {
                    left1 = left2;
                    top1 = top2;
                  });
                }
                setState(() {
                  left2 = details.localPosition.dx + left2Prev - 50;
                  top2 = details.localPosition.dy + top2Prev - 50;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  bool _checkCollision() {
    RenderBox magnet1 =
        _magnet1Key.currentContext?.findRenderObject() as RenderBox;
    RenderBox magnet2 =
        _magnet2Key.currentContext?.findRenderObject() as RenderBox;

    final size1 = magnet1.size;
    final size2 = magnet2.size;

    final position1 = magnet1.localToGlobal(Offset.zero);
    final position2 = magnet2.localToGlobal(Offset.zero);

    final collide = (position1.dx < position2.dx + size2.width &&
        position1.dx + size1.width > position2.dx &&
        position1.dy < position2.dy + size2.height &&
        position1.dy + size1.height > position2.dy);

    return collide;
  }
}
