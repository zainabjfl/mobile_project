import 'package:flutter/material.dart';
import 'animal.dart';

class Level1 extends StatefulWidget {
  const Level1({super.key});

  @override
  State<Level1> createState() => _Level1State();
}

int score = 0;
List<Animal> list1 = [];
List<Animal> list2 = [];

void initLevel() {
  score = 0;
  list1 = [
    Animal(name: 'Camel', img: 'lib/assets/camel.png', voice: 'none'),
    Animal(name: 'Cat', img: 'lib/assets/cat.png', voice: 'none'),
    Animal(name: 'Cow', img: 'lib/assets/cow.png', voice: 'none'),
    Animal(name: 'Dog', img: 'lib/assets/dog.png', voice: 'none'),
    Animal(name: 'Fox', img: 'lib/assets/fox.png', voice: 'none'),
    Animal(name: 'Hen', img: 'lib/assets/hen.png', voice: 'none'),
    Animal(name: 'Horse', img: 'lib/assets/horse.png', voice: 'none'),
    Animal(name: 'Lion', img: 'lib/assets/lion.png', voice: 'none'),
    Animal(name: 'Panda', img: 'lib/assets/panda.png', voice: 'none'),
    Animal(name: 'Sheep', img: 'lib/assets/sheep.png', voice: 'none'),
  ];
  list2 = List<Animal>.from(list1);

  list1.shuffle();
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
    return Center(
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
                children: list1.map((animal1) {
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
                          list1.remove(animal1);
                          list2.remove(animal2);
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
    );
  }
}