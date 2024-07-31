import 'package:flutter/material.dart';
import 'flags.dart';

class Level2 extends StatefulWidget {
  const Level2({super.key});

  @override
  State<Level2> createState() => _Level2State();
}

int score = 0;
List<Flags> list1 = [];
List<Flags> list2 = [];

void initLevel2() {
  score = 0;
  list1 = [
    Flags(capital: "Beirut", img: ""),
    Flags(capital: "Beirut", img: ""),
    Flags(capital: "Beirut", img: ""),
    Flags(capital: "Beirut", img: ""),
    Flags(capital: "Beirut", img: ""),
    Flags(capital: "Beirut", img: ""),
    Flags(capital: "Beirut", img: ""),
    Flags(capital: "Beirut", img: ""),
    Flags(capital: "Beirut", img: ""),
    Flags(capital: "Beirut", img: ""),

  ];
  list2 = List<Flags>.from(list1);

  list1.shuffle();
  list2.shuffle();
}

class _Level2State extends State<Level2> {
  @override
  void initState() {
    initLevel2();
    super.initState();
  }

  void checkScore() {
    if (score >= 100) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Congratulations!'),
            content: Text('You have completed the level with a score of 100!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text('Level 2',style: TextStyle(fontSize: 20,color: Colors.white),),
      backgroundColor: Colors.yellow,

    ),
      body:
      Center(
        child: SingleChildScrollView(child:
        Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 10),
                Text(
                  'Score: ',
                  style: TextStyle(fontSize: 20,),

                ),
                Text(
                  score.toString(),
                  style: TextStyle(fontSize: 30, color: Colors.green),
                ),
                SizedBox(width: 240),
                IconButton(
                  onPressed: () {
                    initLevel2();
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.restart_alt,
                    color: Colors.white,
                  ),
                  style: IconButton.styleFrom(backgroundColor: Colors.orange),
                ),
              ],
            ),
            Divider(indent: 0, endIndent: 260, color: Colors.orange),
            Row(
              children: [
                Column(
                  children: list1.map((flag1) {
                    return Container(
                      child: Draggable<Flags>(
                        data: flag1,
                        childWhenDragging: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(flag1.img),
                          radius: 50,
                        ),
                        feedback: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(flag1.img),
                          radius: 30,
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(flag1.img),
                          radius: 30,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(width: 200),
                Column(
                  children: list2.map((flag2) {
                    return DragTarget<Flags>(
                      onAcceptWithDetails: (details) {
                        Flags flag1 = details.data;
                        if (flag1.capital == flag2.capital) {
                          setState(() {
                            list1.remove(flag1);
                            list2.remove(flag2);
                            score += 10;
                            checkScore();  // Check score after updating it
                          });
                        }
                        else {
                          setState(() {
                            score -= 5;
                            if (score < 0) score = 0; // Ensure score doesn't go negative
                          });
                        }
                      },
                      builder: (context, candidateData, rejectedData) {
                        return Row(
                          children: [
                            SizedBox(width: 10),
                            Text(
                              flag2.capital,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            SizedBox(height: 70),
                          ],
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
        )
      )
    );
  }
}