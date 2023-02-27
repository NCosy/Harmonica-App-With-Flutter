import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:xylophone/admob.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
  runApp(Xylophone());
}

class Xylophone extends StatefulWidget {
  @override
  _XylophoneState createState() => _XylophoneState();
}

class _XylophoneState extends State<Xylophone> {
  void playSound(int soundNumber) {
    final player = AudioCache();
    player.play('ses$soundNumber.mp3',
        mode: PlayerMode.LOW_LATENCY,
        stayAwake: false);
    print("Pressed Button $soundNumber");
  }

  AdmobInterstitial reward;
  Color buttonBackgroundColor = Color(0xf4313231);
  Color allBackgroundColor = Color(0xf468a3ec);

  @override
  void initState() {
    super.initState();
    reward = AdmobInterstitial(adUnitId: AdManager.rewardId);
    reward.load();
  }

  Expanded buildkey(color, int number) {
    return Expanded(
      // ignore: deprecated_member_use
      child: RaisedButton(
        padding: EdgeInsets.only(bottom: 45, top: 16, left: 10),
        color: color,
        onPressed: () {
          playSound(number);
        },
        child: Text(
          "$number",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 35,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrangeAccent,
          child: Text('Color'),
          onPressed: () async{
            if(await reward.isLoaded) {
              reward.show();
            }
            setState(
              () {
                if (allBackgroundColor == Color(0xf468a3ec)) {
                  allBackgroundColor = Color(0xf47ce046);
                } else if (allBackgroundColor == Color(0xf47ce046)) {
                  allBackgroundColor = Color(0xf4b84ec9);
                }else if (allBackgroundColor == Color(0xf4b84ec9)) {
                  allBackgroundColor = Color(0xf4de5050);
                }else if (allBackgroundColor == Color(0xf4de5050)) {
                  allBackgroundColor = Color(0xf4e0b511);
                }else if (allBackgroundColor == Color(0xf4e0b511)) {
                  allBackgroundColor = Color(0xf468a3ec);
                }
              },
            );
          },
        ),
        backgroundColor: allBackgroundColor,
        body: SafeArea(
            child: Container(
          decoration: BoxDecoration(
            color: buttonBackgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(58),
                bottomLeft: Radius.circular(36)),
          ),
          margin: EdgeInsets.only(left: 30, right: 30, bottom: 5, top: 10),
          child: Column(
            children: [
              Text(
                'Harmonica C',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              Container(
                margin: EdgeInsets.only(top: 14, left: 10, right: 10),
                color: buttonBackgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        buildkey(Color(0xfffd7701), 1),
                        buildkey(Color(0xfff2fc01), 2),
                        buildkey(Color(0xff83fd01), 3),
                        buildkey(Color(0xff6720f6), 4),
                        buildkey(Color(0xff00fda8), 5),
                        buildkey(Color(0xffcd00fe), 6),
                        buildkey(Color(0xfffd0042), 7),
                        buildkey(Color(0xff1345d5), 8),
                        buildkey(Color(0xffce9603), 9),
                        buildkey(Color(0xff66ee11), 10),
                      ],
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      children: [
                        buildkey(Color(0xfffd7701), -1),
                        buildkey(Color(0xfff2fc01), -2),
                        buildkey(Color(0xff83fd01), -3),
                        buildkey(Color(0xff6720f6), -4),
                        buildkey(Color(0xff00fda8), -5),
                        buildkey(Color(0xffcd00fe), -6),
                        buildkey(Color(0xfffd0042), -7),
                        buildkey(Color(0xff1345d5), -8),
                        buildkey(Color(0xffce9603), -9),
                        buildkey(Color(0xff66ee11), -10),
                      ],
                    ),
                    AdmobBanner(
                      adUnitId: AdManager.bannerId,
                      adSize: AdmobBannerSize.FULL_BANNER,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
