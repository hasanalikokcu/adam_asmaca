// import 'package:adam_asmaca/screens/home.dart';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   late GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   late String userName;

//   final _auth = FirebaseAuth.instance;
//   bool showSpinner = false;

//   @override
//   Widget build(BuildContext context) {
//     return ModalProgressHUD(
//       inAsyncCall: showSpinner,
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Form(
//           key: _formKey,
//           child: Padding(
//             padding: const EdgeInsets.only(right: 20.0, left: 20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextFormField(
//                   decoration: const InputDecoration(
//                       labelText: "Kullanıcı Adı",
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.purple),
//                       ),
//                       labelStyle: TextStyle(color: Colors.purple)),

//                   validator: (value) {
//                     if (value!.isEmpty)
//                       return 'Kulanıcı adını boş bırakmayın!!!';
//                   },
//                   onChanged: (value) {
//                     setState(() {
//                       userName = value;
//                     });
//                   },
//                   //autovalidateMode: AutovalidateMode.always,
//                 ),
//                 // TextFormField(
//                 //   obscureText: true,
//                 //   decoration: InputDecoration(
//                 //       labelText: "Parola",
//                 //       focusedBorder: OutlineInputBorder(
//                 //         borderSide: BorderSide(color: Colors.purple),
//                 //       ),
//                 //       labelStyle: TextStyle(color: Colors.purple)),

//                 //   validator: (value) {
//                 //     if (value!.isEmpty) return 'Parolanızı boş bırakmayın!!!';
//                 //   },
//                 //   onChanged: (value) {
//                 //     setState(() {
//                 //       password = value;
//                 //     });
//                 //   },
//                 //   //autovalidateMode: AutovalidateMode.always,
//                 // ),
//                 // ignore: prefer_const_constructors
//                 SizedBox(
//                   height: 20,
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState == null) {
//                       print("boş");
//                       return; // dont execute rest code
//                     }
//                     if (_formKey.currentState!.validate()) {
//                       try {
//                         var newUser = await _auth
//                             .signInAnonymously()
//                             .whenComplete(() async => {
//                                   await _auth.currentUser!
//                                       .updateDisplayName(userName)
//                                       .whenComplete(() => {
//                                             print(
//                                                 "şimdiki kullanıcı ${_auth.currentUser}"),
//                                             Navigator.pushReplacementNamed(
//                                                 context, "/homepage")
//                                           }),
//                                 });
//                       } catch (e) {
//                         print(e);

//                         // if (e.hashCode == 34618382) {
//                         //   await _auth
//                         //       .signInWithEmailAndPassword(
//                         //           email: userName, password: password)
//                         //       .whenComplete(() => {
//                         //             Navigator.pushReplacementNamed(
//                         //                 context, "/homepage")
//                         //           });
//                         // }
//                       }
//                       print(_formKey);
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Processing')),
//                       );
//                     }
//                     // print(_formKey.currentWidget);
//                     // if (_formKey.currentState!.validate()) {
//                     //   _formKey.currentState!.save();
//                     //   Navigator.push(
//                     //       context,
//                     //       MaterialPageRoute(
//                     //         builder: (context) => HomeApp(),
//                     //       ));
//                     // }
//                   },
//                   child: Text("Giriş Yap"),
//                   style: ButtonStyle(
//                       fixedSize: MaterialStateProperty.all<Size>(Size(200, 50)),
//                       backgroundColor:
//                           MaterialStateProperty.all<Color>(Colors.purple)),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
