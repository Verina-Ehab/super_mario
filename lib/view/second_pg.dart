import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:super_mario/view/best_score.dart';

class SecondPG extends StatefulWidget {
  const SecondPG({Key? key}) : super(key: key);

  @override
  State<SecondPG> createState() => _SecondPGState();
}

class _SecondPGState extends State<SecondPG> {
  getBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      bestScore = prefs.getInt('bestScore') ?? 0;
      secScore = prefs.getInt('secScore') ?? 0;
      thirdScore = prefs.getInt('thirdScore') ?? 0;
    });
  }

  @override
  void initState() { 
    super.initState();
    getBestScore();
  }

  List scores = [0, 0, 0];
  // bool jump = false;
  int score = 0;
  var bestScore;
  var secScore;
  var thirdScore;
  bool gameStarted = false;
  bool gameOver = false;
  bool centralJump = false;
  bool marioPassedMonster = false;

  double gravity = 13;
  double height = 0;
  double time = 0;
  double velocity = 5;

  double marioX = -0.85;
  double marioY = 0.73;
  double marioWidth = 0.2;
  double marioHeight = 0.4;

  double monsterX = 0.5;
  double monsterY = 0.7;
  double monsterWidth = 0.2;
  double monsterHeight = 0.1;

  void jumpMario() {
    centralJump = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      height = -gravity / 2 * time * time + velocity * time;
      // print('====================================');
      // print(height);
      setState(() {
        if (0.73 - height > 0.73) {
          resetJumpMario();
          marioY = 0.73;
          timer.cancel();
        } else {
          marioY = 0.73 - height;
        }
      });
      if (gameOver) {
        timer.cancel();
      }
      time += 0.01;
    });
  }

  void resetJumpMario() {
    centralJump = false;
    time = 0;
  }

  void updateScore() {
    if (monsterX < marioX && marioPassedMonster == false) {
      setState(() {
        marioPassedMonster = true;
        score++;
      });
    }
  }

  void loopMonster() {
    setState(() {
      if (monsterX <= -1.2) {
        monsterX = 1.2;
        marioPassedMonster = false;
      }
    });
  }

  bool detectCollision() {
    if (monsterX <= marioX + marioWidth &&
        monsterX + monsterWidth >= marioX &&
        marioY >= monsterY - monsterHeight) {
      return true;
    }
    return false;
  }

  void startGame() {
    setState(() {
      gameStarted = true;
    });

    Timer.periodic(const Duration(milliseconds: 5), (timer) {
      if (detectCollision()) {
        gameOver = true;
        timer.cancel();
        setState(() async {
          final prefs = await SharedPreferences.getInstance();
          if (score > thirdScore) {
            if (score > bestScore) {
              if (score > secScore) {
                thirdScore = secScore;
                await prefs.setInt('thirdScore', thirdScore);
              }
            } else if (score < bestScore) {
              if (score > secScore) {
                thirdScore = secScore;
                await prefs.setInt('thirdScore', thirdScore);
              } else if (score < secScore) {
                thirdScore = score;
                await prefs.setInt('thirdScore', thirdScore);
              }
            }
          }
          if (score > secScore) {
            if (score > bestScore) {
              secScore = bestScore;
              await prefs.setInt('secScore', secScore);
            } else if (score < bestScore) {
              secScore = score;
              await prefs.setInt('secScore', secScore);
            }
          }
          if (score > bestScore) {
            bestScore = score;
            await prefs.setInt('bestScore', bestScore);
          }

          // if(score.compareTo(bestScore) == 1){
          //   await prefs.setInt('secScore', bestScore);
          //   await prefs.setInt('bestScore', score);
          // }
          // else if(score.compareTo(secScore) == 1){
          //   await prefs.setInt('thirdScore', secScore);
          //   await prefs.setInt('secScore', score);
          // }
          // else if(score.compareTo(thirdScore) == 1){
          //   await prefs.setInt('thirdScore', score);
          // }

          // final prefs = await SharedPreferences.getInstance();
          // scores.add(score);
          // scores.sort((b, a) => a.compareTo(b));
          // prefs.setInt('bestScore', scores[0]);
          // prefs.setInt('secScore', scores[1]);
          // prefs.setInt('thirdtScore', scores[2]);

          // final prefs = await SharedPreferences.getInstance();
          // if(score > bestScore /*&& score > secScore*/){
          //   prefs.setInt('bestScore', score);
          //   }
          // else if(score > secScore/*score > thirdScore && score < bestScore*/){
          //     prefs.setInt('secScore', score);
          //   }
          // else{
          //     prefs.setInt('thirdtScore', score);
        }

            // if(score > bestScore){}
            // bestScore=score;

            // if (best > sec && third > best) {
            // return third + 'num1';
            // } else if (sec > num1 && sec > best) {
            //   return sec + 'num2';
            // } else {
            //   return best + 'num3';
            // }

            );
      }
      loopMonster();
      updateScore();
      setState(() {
        monsterX -= 0.01;
      });
    });
  }

  void playAgain() {
    setState(() {
      gameOver = false;
      monsterX = 1.2;
      marioY = 0.73;
      centralJump = false;
      gameStarted = false;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameOver
          ? (playAgain)
          : (gameStarted ? (centralJump ? null : jumpMario) : startGame),
      child: Scaffold(
          // backgroundColor: Colors.white,
          body: SizedBox(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/images/background2.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              Center(child: GameOver(gameOver: gameOver)),
              Mario(
                  marioX: marioX,
                  marioY: marioY - marioHeight,
                  marioWidth: marioWidth,
                  marioHeight: marioHeight),
              Monster(
                  monsterX: monsterX,
                  monsterY: monsterY - monsterHeight,
                  monsterWidth: monsterWidth,
                  monsterHeight: monsterHeight),
            ],
          ),
        ),
      )),
    );
  }
}

class Mario extends StatelessWidget {
  final double marioX;
  final double marioY;
  final double marioWidth;
  final double marioHeight;

  const Mario(
      {Key? key,
      required this.marioX,
      required this.marioY,
      required this.marioWidth,
      required this.marioHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size=MediaQuery.of(context).size;
    return Container(
      alignment: Alignment(((2 * marioX + marioWidth) / (2 - marioWidth)),
          ((2 * marioY + marioHeight) / (2 - marioHeight))),
      child: SizedBox(
        // height: size.height*2/3* marioHeight/2,
        // width: size.width* marioWidth/2,
        child: Image.asset(
          'lib/images/mario run.png',
          // fit: BoxFit.fill,
          scale: 2.5,
        ),
      ),
    );
  }
}

class Monster extends StatelessWidget {
  final double monsterX;
  final double monsterY;
  final double monsterWidth;
  final double monsterHeight;

  const Monster(
      {Key? key,
      required this.monsterX,
      required this.monsterY,
      required this.monsterWidth,
      required this.monsterHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size=MediaQuery.of(context).size;
    return Container(
      alignment: Alignment(((2 * monsterX + monsterWidth) / (2 - monsterWidth)),
          ((2 * monsterY + monsterHeight) / (2 - monsterHeight))),
      child: SizedBox(
        // height: size.height*2/3* monsterHeight/2,
        // width: size.width* monsterWidth/2,
        child: Image.asset(
          'lib/images/monster.png',
          // fit: BoxFit.fill,
          scale: 1.8,
        ),
      ),
    );
  }
}

class GameOver extends StatelessWidget {
  final bool gameOver;

  const GameOver({Key? key, required this.gameOver}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size=MediaQuery.of(context).size;
    return gameOver
        ?
        // Stack(
        //   children: [
        //     Positioned(
        //       left: 30,
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'lib/images/game over.png',
                scale: 2,
              ),
              const Text(
                'Douple tap to start again',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),
              ),
              // CircleAvatar(child: )
              const Icon(
                Icons.redo,
                size: 70,
                color: Colors.white,
              ),
              SizedBox(height: 40,),
              InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              "lib/images/back arrow.png",
              scale: 4,
            ),
          ),
            ],
          )
        //   ],
        // )
        : Container();
  }
}

// class RedoAvatar extends StatelessWidget {
//   final bool gameOver;
//   const RedoAvatar({ Key? key, required this.gameOver }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: const CircleAvatar(child: Icon(Icons.redo,)),
//     );
//   }
// }
