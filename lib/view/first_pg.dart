import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_mario/view/second_pg.dart';
import 'package:super_mario/view/third_pg.dart';
// import 'package:super_mario/view/best_score.dart';
// import 'package:audioplayers/audioplayers.dart';

class FirstPG extends StatefulWidget {
  const FirstPG({Key? key}) : super(key: key);

  @override
  State<FirstPG> createState() => _FirstPGState();
}

class _FirstPGState extends State<FirstPG> {
  var bestScore;

  getBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      bestScore = prefs.get('bestScore') ?? 0;
    });
  }

  // music() async {
  //   var player= await AudioCache();
  // // AudioPlayer player = AudioPlayer();
  // // await player.setAsset('audio/cow.mp3');
  // player.play('lib/images/super mario.mp3');
  // }

  @override
  void initState() {
    // music();
    getBestScore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        // backgroundColor: Colors.white,
        body: SizedBox(
      height: size.height,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            // opacity: 0.4,
            image: AssetImage("lib/images/background1.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: FirstPGbody(size: size, bestScore: bestScore),
      ),
    ));
  }
}

class FirstPGbody extends StatelessWidget {
  FirstPGbody({
    Key? key,
    required this.size,
    required this.bestScore,
  }) : super(key: key);

  final Size size;
  var bestScore;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          Image.asset(
            "lib/images/logo img.png",
            scale: 1.2,
          ),
          Image.asset(
            "lib/images/logo name.png",
            scale: 2,
          ),
          SizedBox(
            height: size.height * 0.16,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => (const SecondPG())));
            },
            child: Image.asset(
              "lib/images/go.png",
              scale: 5,
            ),
          ),
          // Text('GO!', style: TextStyle(fontSize: 60, color: Colors.white, fontWeight: FontWeight.w900),),
          SizedBox(
            height: size.height * 0.07,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => (ThirdPage())));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "lib/images/star.png",
                  scale: 1.7,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Best Score: $bestScore",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                )
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.09,
          ),
        ],
      ),
    );
  }
}
