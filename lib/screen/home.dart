import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});


 @override
 Widget build(BuildContext context) {
  return Scaffold(
   body: SingleChildScrollView(
    child: Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Text("How to Play M'rize: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: const Text("1. A group of blocks will appear and some will be highlighted for a few seconds \n2. You'll need to memorize those highlighted blocks \n3. Soon after the pattern disappears, you need to click on the blocks that were highlighted \n4. As level increased, so does the size of the group of blocks and the numbers of the highlighted blocks", style: TextStyle(fontSize: 15),)
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: const Text("\nCara bermain M'rize: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: const Text("1. Sekelompok blok akan muncul dan beberapa blok akan tersorot \n2. Kamu akan butuh untuk menghapalkan blok yang tersorot \n3. Tak lama setelah pola menghilang, kamu butuh untuk menekan blok yang tadi tersorot \n4. Seiring level meningkat, ukuran kelompok blok dan banyak blok yang akan disorot juga akan meningkat", style: TextStyle(fontSize: 15),)
        ),
      ]
    ),
   )
  );
 }
}
