import 'package:flutter/material.dart';
import 'package:mod_appl/MainPage.dart';
import 'package:mod_appl/components/GlassTexture.dart';
import 'package:mod_appl/components/deptDropDown.dart';
import 'package:mod_appl/components/CustomDropDown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mod_appl/controllers/DatabaseController.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAuth.instance.authStateChanges().listen((User? User) {
    if (User == null) {
      print("Signed out");
    } else {
      print("Signed in");
    }
  });
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/bg_2.png"), fit: BoxFit.cover)),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: HomePage(),
            backgroundColor: Colors.transparent,
          )),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController tabController_;
  static String user_email = "";
  static String user_regno = "";
  static String user_dept = "";
  static String user_name = "";
  static String user_pwd = "";
  static String user_pos = "";
  static String login_email = "";
  static String login_pwd = "";
  @override
  void initState() {
    super.initState();
    tabController_ = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    child: Image.asset("assets/img/logo.png"),
                    width: 100,
                    height: 100,
                  ),
                  Column(
                    children: [
                      Text("CYSCOM",
                          style: TextStyle(
                            fontFamily: "Rubik",
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                      Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: Text(
                          "Cybersecurity Students' Community of VIT Chennai",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: "Rubik"),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GlassTexture(
                container_child: Container(
                    child: Column(
                  children: [
                    TabBar(controller: tabController_, tabs: <Widget>[
                      Tab(
                        icon: Icon(Icons.login_outlined, size: 20.0),
                      ),
                      Tab(
                        icon: Icon(Icons.app_registration_outlined, size: 20.0),
                      ),
                    ]),
                    Flexible(
                      child: Container(
                        child: TabBarView(
                          controller: tabController_,
                          children: [
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 45),
                              child: Center(
                                child: ListView(
                                  scrollDirection: Axis.vertical,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 20.0, right: 20.0),
                                      child: SizedBox(
                                        height: 30,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        child: TextField(
                                          style: TextStyle(
                                              fontFamily: "Rubik",
                                              color: Colors.white,
                                              fontSize: 11),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.zero,
                                            fillColor:
                                                Colors.black.withOpacity(0.4),
                                            hoverColor:
                                                Colors.black.withOpacity(0.5),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 3.0),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25))),
                                            labelText: "EMAIL ID",
                                            labelStyle: TextStyle(
                                                fontFamily: "Rubik",
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                          onChanged: (changedText) {
                                            login_email = changedText;
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 20.0, right: 20.0),
                                      child: SizedBox(
                                        height: 30,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                    0.75 -
                                                30,
                                        child: TextField(
                                          style: TextStyle(
                                              fontFamily: "Rubik",
                                              color: Colors.white,
                                              fontSize: 11),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.zero,
                                            fillColor:
                                                Colors.black.withOpacity(0.4),
                                            hoverColor:
                                                Colors.black.withOpacity(0.5),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 3.0),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25))),
                                            labelText: "PASSWORD",
                                            labelStyle: TextStyle(
                                                fontFamily: "Rubik",
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                          onChanged: (changedText) {
                                            login_pwd = changedText;
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: UnconstrainedBox(
                                        child: Container(
                                          height: 30,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              try {
                                                final cred = FirebaseAuth
                                                    .instance
                                                    .signInWithEmailAndPassword(
                                                        email: login_email,
                                                        password: login_pwd);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MainPage(
                                                                email:
                                                                    login_email)));
                                              } on FirebaseAuthException catch (e) {
                                                if (e.code ==
                                                    'user-not-found') {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (ctx) => AlertDialog(
                                                                title: Text(""),
                                                                content: Text(
                                                                    "User with that email not found. Please register."),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(ctx)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        color: Colors
                                                                            .blue,
                                                                        padding:
                                                                            EdgeInsets.all(14),
                                                                        child: Text(
                                                                            "Okay"),
                                                                      ))
                                                                ],
                                                              ));
                                                } else if (e.code ==
                                                    'wrong-password') {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (ctx) => AlertDialog(
                                                                title: Text(""),
                                                                content: Text(
                                                                    "The given email or password is wrong. Please enter a valid entry."),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(ctx)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        color: Colors
                                                                            .blue,
                                                                        padding:
                                                                            EdgeInsets.all(14),
                                                                        child: Text(
                                                                            "Okay"),
                                                                      ))
                                                                ],
                                                              ));
                                                }
                                              }
                                            },
                                            child: Text("LOGIN",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Rubik",
                                                  fontSize: 12,
                                                )),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color.fromRGBO(
                                                  31, 77, 204, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Center(
                                child: ListView(
                                  scrollDirection: Axis.vertical,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 20.0, right: 20.0),
                                      child: SizedBox(
                                        height: 30,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        child: TextField(
                                          onChanged: (newtxt) {
                                            user_regno = newtxt;
                                          },
                                          style: TextStyle(
                                              fontFamily: "Rubik",
                                              color: Colors.white,
                                              fontSize: 11),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.zero,
                                            fillColor:
                                                Colors.black.withOpacity(0.4),
                                            hoverColor:
                                                Colors.black.withOpacity(0.5),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 3.0),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25))),
                                            labelText: "REGISTRATION NUMBER",
                                            labelStyle: TextStyle(
                                                fontFamily: "Rubik",
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SizedBox(
                                          width: 50,
                                          height: 40,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Wrap(
                                                children: [
                                                  CustDropDown(
                                                      borderRadius: 5,
                                                      hintText: "DEPARTMENT",
                                                      items: [
                                                        Deptdropdown
                                                            .getDeptDropDown(
                                                                "BOARD"),
                                                        Deptdropdown
                                                            .getDeptDropDown(
                                                                "TECHNICAL"),
                                                        Deptdropdown
                                                            .getDeptDropDown(
                                                                "DEVELOPMENT"),
                                                        Deptdropdown
                                                            .getDeptDropDown(
                                                                "CONTENT"),
                                                        Deptdropdown
                                                            .getDeptDropDown(
                                                                "SOCIAL MEDIA"),
                                                        Deptdropdown
                                                            .getDeptDropDown(
                                                                "OPERATIONS")
                                                      ],
                                                      onChanged: (usr_txt) {
                                                        user_dept = usr_txt;
                                                      }),
                                                ],
                                              ),
                                            ),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4.0, left: 20.0, right: 20.0),
                                      child: SizedBox(
                                        height: 30,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                    0.75 -
                                                30,
                                        child: TextField(
                                          style: TextStyle(
                                              fontFamily: "Rubik",
                                              color: Colors.white,
                                              fontSize: 11),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.zero,
                                            fillColor:
                                                Colors.black.withOpacity(0.4),
                                            hoverColor:
                                                Colors.black.withOpacity(0.5),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 3.0),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25))),
                                            labelText: "NAME",
                                            labelStyle: TextStyle(
                                                fontFamily: "Rubik",
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                          onChanged: (newtxt) {
                                            user_name = newtxt;
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 20.0, right: 20.0),
                                      child: SizedBox(
                                        height: 30,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                    0.75 -
                                                30,
                                        child: TextField(
                                          style: TextStyle(
                                              fontFamily: "Rubik",
                                              color: Colors.white,
                                              fontSize: 11),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.zero,
                                            fillColor:
                                                Colors.black.withOpacity(0.4),
                                            hoverColor:
                                                Colors.black.withOpacity(0.5),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 3.0),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25))),
                                            labelText: "PASSWORD",
                                            labelStyle: TextStyle(
                                                fontFamily: "Rubik",
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                          onChanged: (changed) {
                                            user_pwd = changed;
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 20.0, right: 20.0),
                                      child: SizedBox(
                                        height: 30,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                    0.75 -
                                                30,
                                        child: TextField(
                                          style: TextStyle(
                                              fontFamily: "Rubik",
                                              color: Colors.white,
                                              fontSize: 11),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.zero,
                                            fillColor:
                                                Colors.black.withOpacity(0.4),
                                            hoverColor:
                                                Colors.black.withOpacity(0.5),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 3.0),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25))),
                                            labelText: "EMAIL",
                                            labelStyle: TextStyle(
                                                fontFamily: "Rubik",
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                          onChanged: (text) {
                                            user_email = text;
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SizedBox(
                                          width: 50,
                                          height: 40,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Wrap(
                                                children: [
                                                  CustDropDown(
                                                      borderRadius: 5,
                                                      hintText: "POSITION",
                                                      items: [
                                                        Deptdropdown
                                                            .getDeptDropDown(
                                                                "CHAPTER LEADER"),
                                                        Deptdropdown
                                                            .getDeptDropDown(
                                                                "CHAPTER MANAGER"),
                                                        Deptdropdown
                                                            .getDeptDropDown(
                                                                "GEN. SECRETARY"),
                                                        Deptdropdown
                                                            .getDeptDropDown(
                                                                "DEV LEAD"),
                                                        Deptdropdown
                                                            .getDeptDropDown(
                                                                "SM LEAD"),
                                                        Deptdropdown
                                                            .getDeptDropDown(
                                                                "CONTENT LEAD"),
                                                        Deptdropdown
                                                            .getDeptDropDown(
                                                                "TECH LEAD"),
                                                        Deptdropdown
                                                            .getDeptDropDown(
                                                                "EM LEAD"),
                                                        Deptdropdown
                                                            .getDeptDropDown(
                                                                "MEMBER"),
                                                      ],
                                                      onChanged: (usr_txt) {
                                                        user_pos = usr_txt;
                                                      }),
                                                ],
                                              ),
                                            ),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: UnconstrainedBox(
                                        child: Container(
                                          height: 30,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              try {
                                                print(user_email +
                                                    "GENG SUCKS" +
                                                    user_pwd);
                                                final credential =
                                                    await FirebaseAuth.instance
                                                        .createUserWithEmailAndPassword(
                                                  email: user_email,
                                                  password: user_pwd,
                                                )
                                                        .then((var acc) {
                                                  print(acc.user);
                                                  Databasecontroller
                                                      .AppendUserData(
                                                          reg_no: user_regno,
                                                          dept: user_dept,
                                                          name: user_name,
                                                          password: user_pwd,
                                                          email: user_email,
                                                          position: user_pos,
                                                          tasklist: new Map<String,int>(),
                                                          points: 0,
                                                          badges: []);
                                                });
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MainPage(
                                                              email: user_email,
                                                            )));
                                              } on FirebaseAuthException catch (e) {
                                                if (e.code == 'weak-password') {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (ctx) => AlertDialog(
                                                                title: Text(""),
                                                                content: Text(
                                                                    "Password is very weak"),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(ctx)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        color: Colors
                                                                            .blue,
                                                                        padding:
                                                                            EdgeInsets.all(14),
                                                                        child: Text(
                                                                            "Okay"),
                                                                      ))
                                                                ],
                                                              ));
                                                } else if (e.code ==
                                                    'email-already-in-use') {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (ctx) => AlertDialog(
                                                                title: Text(""),
                                                                content: Text(
                                                                    "Account with that email address is already in use"),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(ctx)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        color: Colors
                                                                            .blue,
                                                                        padding:
                                                                            EdgeInsets.all(14),
                                                                        child: Text(
                                                                            "Okay"),
                                                                      ))
                                                                ],
                                                              ));
                                                } else if (e.code ==
                                                    "network-request-failed") {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (ctx) => AlertDialog(
                                                                title: Text(""),
                                                                content: Text(
                                                                    "Please make sure that you have a proper internet connection..."),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(ctx)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        color: Colors
                                                                            .blue,
                                                                        padding:
                                                                            EdgeInsets.all(14),
                                                                        child: Text(
                                                                            "Okay"),
                                                                      ))
                                                                ],
                                                              ));
                                                }
                                              } catch (e) {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (ctx) => AlertDialog(
                                                              title: Text(""),
                                                              content: Text(
                                                                  e.toString()),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              ctx)
                                                                          .pop();
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      color: Colors
                                                                          .blue,
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              14),
                                                                      child: Text(
                                                                          "Okay"),
                                                                    ))
                                                              ],
                                                            ));
                                              }
                                            },
                                            child: Text("REGISTER",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Rubik",
                                                  fontSize: 12,
                                                )),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color.fromRGBO(
                                                  31, 77, 204, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
                height_: MediaQuery.of(context).size.height * 0.7,
                width_: MediaQuery.of(context).size.width * 0.75,
                padding_: 0),
          ],
        ),
      ),
    );
  }
}
