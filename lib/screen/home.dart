import 'package:flutter/material.dart';
import 'package:projectuts/screen/game.dart';
import 'dart:math' as math;

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          alignment: Alignment.centerLeft,
          child: const Text(
            "How to Play MemoPattern: ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          alignment: Alignment.centerLeft,
          child: const Text(
            "1. A group of blocks will appear and some will be highlighted for a few seconds \n2. You'll need to memorize those highlighted blocks \n3. Soon after the pattern disappears, you need to click on the blocks that were highlighted \n4. As level increased, so does the size of the group of blocks and the numbers of the highlighted blocks",
            style: TextStyle(fontSize: 15),
          )),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          alignment: Alignment.centerLeft,
          child: const Text(
            "\nCara bermain MemoPattern: ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          alignment: Alignment.centerLeft,
          child: const Text(
            "1. Sekelompok blok akan muncul dan beberapa blok akan tersorot \n2. Kamu akan butuh untuk menghapalkan blok yang tersorot \n3. Tak lama setelah pola menghilang, kamu butuh untuk menekan blok yang tadi tersorot \n4. Seiring level meningkat, ukuran kelompok blok dan banyak blok yang akan disorot juga akan meningkat",
            style: TextStyle(fontSize: 15),
          )),
          Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          alignment: Alignment.center,
          child: const Text(
            "\nPlay",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
            alignment: Alignment.center,
            child: TweenAnimationBuilder(
                    duration: const Duration(seconds: 40),
                    tween: Tween<double>(begin: 0, end: 5 * math.pi), 
                    builder: (_, double angle, __) {
                    return Transform.rotate(
                      angle: angle,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Game()),
                          );},
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                        backgroundColor: const Color.fromARGB(255, 68, 71, 97),
                        foregroundColor: const Color.fromARGB(255, 235, 232, 243),
                      ),
                      child: const Icon(Icons.play_arrow, size: 30.0,),),
                    );},
                  ),
            ),
      ]),
    ));
  }
}
