import 'dart:math';

import 'package:advance_notification/advance_notification.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:turkish/turkish.dart';

import '../ui/colors.dart';
import '../ui/widget/figure_image.dart';
import '../ui/widget/letter.dart';

import '../utils/game.dart';
import '../utils/wordList.dart';

class HomeApp extends StatefulWidget {
  HomeApp({Key? key}) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  String word = WordList().getRandomWord().replaceAll(' ', '').toUpperCaseTr();

  AudioCache audioCache = AudioCache();
  String? valueText;
  TextEditingController _textFieldController = TextEditingController();
  int correctCharNumber = 0;
  bool setSelectedWord = true;
  int winCount = 0;
  double volume = 1;
  bool setVolume = true;
  var user;

  @override
  void initState() {
    super.initState();
  }

  // void getCurrentUser() async {
  //   String token = await UserPreferences.getTokenString();
  //   // try {
  //   _auth.signInWithCustomToken(token);
  //   loggedInUser = _auth.currentUser;
  //   String? deviceId = await PlatformDeviceId.getDeviceId;
  //   final Random _random = new Random();
  //   int randomInt = _random.nextInt(10000);
  //   //user = await _auth.signInWithCustomToken(getLogginData().toString());
  //   print("TOKEN!!!!  ${await UserPreferences.getTokenString()} ");
  //   if (loggedInUser != null) {
  //     print("if içinde $loggedInUser");
  //   } else {
  //     await _auth
  //         .signInAnonymously()
  //         .whenComplete(() async =>
  //             {await _auth.currentUser!.updateDisplayName("misafir$randomInt")})
  //         .whenComplete(() async => {
  //               print("home içinde ${_auth.currentUser}"),
  //               if (_auth.currentUser != null)
  //                 {loggedInUser = _auth.currentUser},
  //               UserPreferences.setToken(_auth.currentUser!.uid)
  //             });
  //   }
  //   // } catch (e) {
  //   //   print(e);
  //   // }
  // }

  // String currentUserName() {
  //   String name = "";
  //   setState(() {
  //     name = loggedInUser == null ? "" : loggedInUser!.displayName.toString();
  //   });

  //   return name;
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 100) / 2;
    final double itemWidth = size.width;
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: Text("Adam Asmaca"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
        // leading: Text("${currentUserName()} $winCount kere kazandınız"),
        leadingWidth: 1000,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (setVolume) {
                    setVolume = false;
                    volume = 0;
                  } else {
                    setVolume = true;
                    volume = 1;
                  }
                  print("volume değere $volume");
                });
              },
              icon: setVolume ? Icon(Icons.volume_up) : Icon(Icons.volume_off)),
          IconButton(
              onPressed: () {
                correctCharNumber = 0;
                valueText = "";
                Game.selectedChar.clear();
                Game.tries = 0;
                _displayTextInputDialog(context);
              },
              icon: Icon(Icons.add_box_outlined))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                figureImage(Game.tries >= 0, "assets/hang.png"),
                figureImage(Game.tries >= 1, "assets/head.png"),
                figureImage(Game.tries >= 2, "assets/body.png"),
                figureImage(Game.tries >= 3, "assets/ra.png"),
                figureImage(Game.tries >= 4, "assets/la.png"),
                figureImage(Game.tries >= 5, "assets/rl.png"),
                figureImage(Game.tries >= 6, "assets/ll.png"),
              ],
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: word
                  .split("")
                  .map((e) => letter(e.toUpperCaseTr(),
                      !Game.selectedChar.contains(e.toUpperCaseTr())))
                  .toList()),
          SizedBox(
            width: double.infinity,
            height: (itemHeight / 1.1),
            child: GridView.count(
              //crossAxisCount: (MediaQuery.of(context).size.width ~/ 45).toInt(),

              crossAxisCount: 6,
              childAspectRatio: (itemWidth / itemHeight),
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              padding: EdgeInsets.all(8),
              children: WordList().alphabets.map((e) {
                return RawMaterialButton(
                    child: Text(
                      e,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    fillColor: Game.selectedChar.contains(e)
                        ? Colors.black87
                        : Colors.blue,
                    onPressed: Game.selectedChar.contains(e)
                        ? null
                        : () {
                            setState(() {
                              Game.selectedChar.add(e);
                              if (!word.split("").contains(e.toUpperCaseTr())) {
                                Game.tries++;

                                audioCache.play("sound/incorrect.wav",
                                    volume: volume);
                                print("volume değeri $volume");

                                if (Game.tries == 6) {
                                  audioCache.play("sound/game-over.wav",
                                      volume: volume);

                                  gameOverAlertDialog(context, false);
                                }
                              } else {
                                final charCount = word
                                    .split("")
                                    .where((element) => element == e)
                                    .toList()
                                    .length;

                                setState(() {
                                  correctCharNumber += charCount;
                                });
                                print(correctCharNumber);
                                print(word.length);
                                if (correctCharNumber == word.length) {
                                  setState(() {
                                    correctCharNumber = 0;
                                    //  word = "";
                                    Game.selectedChar.clear();
                                    _textFieldController.clear();
                                    valueText = "";
                                    Game.tries = 0;
                                  });
                                  audioCache
                                      .play("sound/level-up.wav")
                                      .then((value) => (audioCache.play(
                                          "sound/clapping.wav",
                                          volume: volume)))
                                      .whenComplete(() =>
                                          gameOverAlertDialog(context, true));
                                } else {
                                  audioCache.play("sound/correct.wav",
                                      volume: volume);
                                }
                              }
                            });
                          });
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Yeni Kelimeyi Yazınız'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              maxLength: 9,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp('[a-zA-ZiİçÇşŞğĞÜüÖö]')),
                // FilteringTextInputFormatter.deny(
                //     RegExp(
                //       "[1,2,3,4,5,6,7,8,9,0]",
                //     ),
                //     replacementString: ""),
                FilteringTextInputFormatter.deny(RegExp(r"\ "),
                    replacementString: "")
              ],
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Yeni Kelime"),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  setState(() {
                    _textFieldController.clear();
                    Game.selectedChar.clear();
                    Game.tries = 0;
                    correctCharNumber = 0;
                    setSelectedWord = true;
                  });
                  word = WordList().getRandomWord().toUpperCaseTr();
                  print(word);

                  Navigator.pop(context);
                },
                child: Text("Rastgele Kelime"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColor.primaryColor)),
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColor.primaryColor)),
                // color: Colors.green,
                // textColor: Colors.white,
                child: Text(
                  'Tamam',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (valueText == null) {
                    AdvanceSnackBar(
                      message:
                          "Girdiğiniz Kelime en az 3 en fazla 9 harfli olmalı!!!",
                      //  mode: "ADVANCE",
                      duration: Duration(seconds: 5),
                      bgColor: Colors.red,
                      textColor: Colors.black,
                      iconColor: Colors.black,
                    ).show(context);
                  } else if (valueText!.length <= 2 ||
                      valueText!.length >= 10) {
                    setState(() {
                      _textFieldController.clear();

                      Game.selectedChar.clear();
                      Game.tries = 0;
                      correctCharNumber = 0;
                    });
                    AdvanceSnackBar(
                      message:
                          "Girdiğiniz Kelime en az 3 en fazla 9 harfli olmalı!!!",
                      // mode: "ADVANCE",
                      duration: Duration(seconds: 5),
                      bgColor: Colors.red,
                      textColor: Colors.black,
                      iconColor: Colors.black,
                    ).show(context);
                  } else {
                    setState(() {
                      _textFieldController.clear();

                      Game.selectedChar.clear();
                      Game.tries = 0;
                      correctCharNumber = 0;

                      print(word);
                      setSelectedWord = false;
                      word = valueText.toString().toUpperCaseTr();
                      Navigator.pop(context);
                    });
                  }
                },
              ),
            ],
          );
        });
  }

  Future<dynamic> gameOverAlertDialog(BuildContext context, bool i) {
    String gameOverText;

    i == false ? gameOverText = "KAYBETTİNİZ" : gameOverText = "KAZANDINIZ";
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(gameOverText),
          content: Text("Kelime :  $word"),
          actions: [
            TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColor.primaryColorDark)),
                onPressed: () {
                  setState(() {
                    if (setSelectedWord) {
                      winCount++;
                    }
                    _textFieldController.clear();
                    Game.selectedChar.clear();
                    correctCharNumber = 0;
                    Game.tries = 0;
                  });

                  Navigator.pop(context);
                  _displayTextInputDialog(context);
                },
                child: Text(
                  "Yeni Oyun",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        );
      },
    );
  }
}
