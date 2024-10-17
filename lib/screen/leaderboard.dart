import 'package:flutter/material.dart';
//import 'package:projectuts/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});
  
  @override
  State<StatefulWidget> createState() {
    return _LeaderboardState();
  }
}

class _LeaderboardState extends State<Leaderboard> {
  List<List<String>> scores = [];

  @override
  void initState() {
    super.initState();
    loadHighScore();
  }

  Future<void> loadHighScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      List<String>? scoreList = prefs.getStringList('listofscores');

      if (scoreList == null) {
        scores = [];
      }
      else{
        scores = scoreList.map((s) {
        var split = s.split(':');
        return [split[0], split[1]];
        }).toList();
      }
    });
  }

  List<Widget> top3board() {
    List<Widget> temp = [];
    int i = 0;
    if (scores.isEmpty){
      Widget w = Container(
        alignment: Alignment.center,
        child: const Text(
          "There's no Highscore yet",
          style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
        ));
        temp.add(w);
    }
    else if(scores.length < 3){
      while (i < scores.length) {
        Widget w = Container(
          margin:const EdgeInsets.all(15),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: -6,
                blurRadius: 8,
                offset: const Offset(8, 7),
              ),
            ]
          ),
        child:
          Card(
            child: Column(
              children: [
                /*Container (
                  margin: const EdgeInsets.all(15),
                  child: Text( 
                    (i+1).toString(),
                    style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  )
                ),*/
                Image.asset(
                  "../assets/images/R${i + 1}F.png",
                  width: 100.0,  
                  height: 100.0,),
                Container (
                  margin: const EdgeInsets.all(3),
                  child: Text( 
                    scores[i][0],
                    style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  )
                ),
                Container (
                  margin: const EdgeInsets.all(3),
                  child: Text(
                    scores[i][1],
                    style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                    ),
                )            
              ]
            ) 
          )
        );
        temp.add(w);
        i++;
      }
    }
    else{
      while (i < 3) {
        Widget w = Container(
          margin:const EdgeInsets.all(15),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: -6,
                blurRadius: 8,
                offset: const Offset(8, 7),
              ),
            ]
          ),
        child:
          Card(
            child: Column(
              children: [
                /*Container (
                  margin: const EdgeInsets.all(15),
                  child: Text( 
                    (i+1).toString(),
                    style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  )
                ),*/
                Image.asset(
                  "../assets/images/R${i + 1}F.png",
                  width: 100.0,  
                  height: 100.0,),
                Container (
                  margin: const EdgeInsets.all(3),
                  child: Text( 
                    scores[i][0],
                    style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  )
                ),
                Container (
                  margin: const EdgeInsets.all(3),
                  child: Text(
                    scores[i][1],
                    style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                    ),
                )          
              ]
            ) 
          )
        );
        temp.add(w);
        i++;
      }
    }
    return temp;
  }

  List<Widget> aftertop3(){
    List<Widget> temp = [];
    int i = 3;
    if(scores.length > 3){
      while(i < scores.length){
        Widget w = Container(
        padding: const EdgeInsets.all(2.0),
        decoration: const BoxDecoration(
          border: Border(
            //top: BorderSide(width: 1.0, color: Colors.grey),    
            bottom: BorderSide(width: 1.0, color: Colors.grey), 
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${i + 1}. ${scores[i][0]}",  
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "${scores[i][1]}",  
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
          ),);
        temp.add(w);
        i++;
      }
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MemoPattern',  style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container (
                  margin: const EdgeInsets.all(20),
                  child: const Text("Leaderboard", 
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: top3board(),
                ),
                Divider(
                  height: 1,
                ),
                if(scores.length > 3)
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: aftertop3(),
                  ),
                Divider(
                  height: 100,
                ),
        ])),
    );
  }
}
