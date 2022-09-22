import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:super_mario/view/best_score.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {

  var bestScore;
  var secScore;
  var thirdScore;


  getBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      bestScore = prefs.get('bestScore') ;
      secScore = prefs.get('secScore') ;
      thirdScore = prefs.get('thirdScore') ;
    });
  }

  @override
  void initState() {
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
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                // opacity: 0.4,
                image: AssetImage("lib/images/background1.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Image.asset('lib/images/congrats.png', scale: 3,),
                const Text(
                  "Best three scores are",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                ),

                const SizedBox(height: 70,),
                BestScoreRow(bestScore: bestScore),
                BestScoreRow(bestScore: secScore),
                BestScoreRow(bestScore: thirdScore),],
            )),
          ),
          Positioned(left: 70,bottom: 50,
            child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              "lib/images/back arrow.png",
              scale: 4,
            ),
          ),),
        ],
      ),
    ));
  }
}

class BestScoreRow extends StatelessWidget {
  BestScoreRow({
    Key? key,
    required this.bestScore,
  }) : super(key: key);

  var bestScore;

  @override
  Widget build(BuildContext context) {
    return 
    Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "lib/images/star.png",
              scale: 2,
            ),
            const SizedBox(
          width: 5,
        ),
            Text(
              "$bestScore",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
            )
          ],
        ),
        const SizedBox(height: 8,)
      ],
    );
  }
}
