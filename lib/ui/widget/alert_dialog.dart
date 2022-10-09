
//   import 'package:flutter/material.dart';

// Future<void> _displayTextInputDialog(BuildContext context) async {
//     return showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Yeni Kelimeyi Yazınız'),
//             content: TextField(
//               onChanged: (value) {
//                 setState(() {
//                   valueText = value;
//                 });
//               },
//               maxLength: 9,
//               inputFormatters: [
//                 FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
//                 FilteringTextInputFormatter.deny(RegExp(r"\ "),
//                     replacementString: "")
//               ],
//               controller: _textFieldController,
//               decoration: InputDecoration(hintText: "Yeni Kelime"),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   setState(() {
//                     _textFieldController.clear();
//                     Game.selectedChar.clear();
//                     Game.tries = 0;
//                     correctCharNumber = 0;
//                   });
//                   word = WordList().getRandomWord().toUpperCaseTr();
//                   print(word);

//                   Navigator.pop(context);
//                 },
//                 child: Text("Rastgele Kelime"),
//                 style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all<Color>(
//                         AppColor.primaryColor)),
//               ),
//               TextButton(
//                 style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all<Color>(
//                         AppColor.primaryColor)),
//                 // color: Colors.green,
//                 // textColor: Colors.white,
//                 child: Text(
//                   'Tamam',
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//                 onPressed: () {
//                   if (valueText == null) {
//                     AdvanceSnackBar(
//                       message:
//                           "Girdiğiniz Kelime en az 3 en fazla 9 harfli olmalı!!!",
//                       //  mode: "ADVANCE",
//                       duration: Duration(seconds: 5),
//                       bgColor: Colors.red,
//                       textColor: Colors.black,
//                       iconColor: Colors.black,
//                     ).show(context);
//                   } else if (valueText!.length <= 2 ||
//                       valueText!.length >= 10) {
//                     setState(() {
//                       _textFieldController.clear();

//                       Game.selectedChar.clear();
//                       Game.tries = 0;
//                       correctCharNumber = 0;
//                     });
//                     AdvanceSnackBar(
//                       message:
//                           "Girdiğiniz Kelime en az 3 en fazla 9 harfli olmalı!!!",
//                       // mode: "ADVANCE",
//                       duration: Duration(seconds: 5),
//                       bgColor: Colors.red,
//                       textColor: Colors.black,
//                       iconColor: Colors.black,
//                     ).show(context);
//                   } else {
//                     setState(() {
//                       _textFieldController.clear();

//                       Game.selectedChar.clear();
//                       Game.tries = 0;
//                       correctCharNumber = 0;

//                       print(word);

//                       word = valueText.toString().toUpperCaseTr();
//                       Navigator.pop(context);
//                     });
//                   }
//                 },
//               ),
//             ],
//           );
//         });
//   }