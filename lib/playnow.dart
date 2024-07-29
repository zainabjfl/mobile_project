import 'package:flutter/material.dart';
import 'level1.dart';
class PlayNow extends StatefulWidget {
  const PlayNow({super.key});

  @override
  State<PlayNow> createState() => _PlayNowState();
}

class _PlayNowState extends State<PlayNow> {
  bool showLevels = false;
  String playerName="";
  int score=0;
  bool level1Complet=false;

  void _onPlayButtonPressed() {
    setState(() {
      showLevels = true;
    });
  }
  void _enterPlayerName() {
    showDialog(
        context: context,
        builder: (BuildContext context)
    {
      String tempName=playerName;
      return AlertDialog(
        title: Text('Enter Player Name'),
        content: TextField(
          onChanged: (value) {
            tempName = value;
          },
          decoration: InputDecoration(hintText: "Player Name"),
          controller: TextEditingController(text: playerName),
        ),
        actions: <Widget>[
          ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                setState(() {
                  playerName=tempName;
                });
                Navigator.of(context).pop();
              }
          ),
        ],
      );

  },
    );
          }
void _completeLevel1(){
    setState(() {
      score=100;
      level1Complet=true;
    });
}
@override
Widget build (BuildContext context) {
                        return Scaffold(
                          appBar: AppBar(
                              title: Text('MATCHING GAME!',style: TextStyle(color: Colors.white),),
                              centerTitle: true,
                              backgroundColor: Colors.orange,

                              actions: <Widget>[
                                PopupMenuButton<String>(
                                  onSelected: (String result) {
                                    if (result == 'Enter Player Name') {
                                      _enterPlayerName();
                                    }
                                  },
                                  itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                    const PopupMenuItem<String>(
                                      value: 'Enter Player Name',
                                      child: Text('Enter Player Name'),
                                    ),
                                  ],
                                ),
                              ]
                          ),
                          body:
                          Center(
                            child: showLevels
                                ? _buildLevels()
                                : _buildPlayButton(),
                          ),
                        );
                      }

                      Widget _buildPlayButton() {
                        return Center(child: Column(
                        children: [
                          SizedBox(height: 50,),
                          Text('Welcom $playerName ',style: TextStyle(fontSize: 20,color: Colors.blue),),
                          SizedBox(height: 50,),
                          ElevatedButton(
                          onPressed: _onPlayButtonPressed,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.amber,
                          ),
                            child:Text('Play'),
                        )
                      ]
                        )
                        );
                      }

                      Widget _buildLevels() {
                        return  Column(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder:(context)=> Level1()));
                               _completeLevel1();
                              },
                              child: Text('Level 1'),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed:level1Complet?() {
                                // Add your Level 2 navigation or functionality here
                              }:null,
                              child: Text('Level 2'),
                            ),
                          ],
                        );
                      }
                    }











