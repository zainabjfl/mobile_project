import 'package:flutter/material.dart';
import 'package:project/level2.dart';
import 'animal.dart';


class Level1 extends StatefulWidget {
  const Level1({super.key});

  @override
  State<Level1> createState() => _Level1State();
}

int score = 0;

List<Animal> list2 = [];

void initLevel() {
  score = 0;
  list2 = List<Animal>.from(list3);

  list3.shuffle();
  list2.shuffle();
}


class _Level1State extends State<Level1> {
  @override
  void initState() {
    initLevel();
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
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>Level2())
                  );
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
    return
      Scaffold(
        appBar: AppBar(
        title: Text('Level 1',style: TextStyle(fontSize: 20,color: Colors.white),),
    backgroundColor: Colors.yellow,

    ),
    body:Center(
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
                  initLevel();
                  playRestart();
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
                children: list3.map((animal1) {
                  return Container(
                    child: Draggable<Animal>(
                      data: animal1,
                      childWhenDragging: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(animal1.img),
                        radius: 50,
                      ),
                      feedback: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(animal1.img),
                        radius: 30,
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(animal1.img),
                        radius: 30,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(width: 200),
              Column(
                children: list2.map((animal2) {
                  return DragTarget<Animal>(
                    onAcceptWithDetails: (details) {
                      Animal animal1 = details.data;
                      if (animal1.name == animal2.name) {
                        setState(() {
                          list3.remove(animal1);
                          list2.remove(animal2);
                          score += 10;
                          checkScore();  // Check score after updating it
                        });
                        platSuccess();
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
                            animal2.name,
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


