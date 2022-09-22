import 'package:flutter/material.dart';
import 'package:super_mario/view/first_pg.dart';
// import 'package:super_mario/view/splashscreen.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:audioplayers/audioplayers.dart';

void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // AudioPlayer player = AudioPlayer();
  // player.play('lib/images/SUPER MARIO.mp3', isLocal: true);
  runApp(const MyApp());
  // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirstPG(),
    );
  }
}


