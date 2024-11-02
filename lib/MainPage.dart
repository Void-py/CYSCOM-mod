import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mod_appl/components/GlassTexture.dart';
import 'package:mod_appl/controllers/DatabaseController.dart';

bool isAdmin = false;
String usr_email = "";
Map<String, dynamic> user_data = {};
bool data_acquired = false;

class MainPage extends StatefulWidget {
  MainPage({super.key, required email}) {
    usr_email = email;
  }

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      Databasecontroller.ReadUserData(email: usr_email).then((onValue) {
        setState(() {
          user_data = onValue;
          data_acquired = true;
          isAdmin = (user_data["position"] == "MEMBER") ? false : true;
          print("set sail" + user_data.toString());
        });
      });
    });
    print(user_data);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/bg.jpg"), fit: BoxFit.cover),
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: !data_acquired
                ? Center(child: CircularProgressIndicator())
                : isAdmin
                    ? AdminPage(email: usr_email)
                    : MemberPage(email: usr_email),
            backgroundColor: Colors.transparent,
          )),
    );
  }
}

class MemberPage extends StatefulWidget {
  MemberPage({super.key, required email});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  ScrollController _scrollController = ScrollController();
  GlobalKey widgetKey = GlobalKey();
  Offset widgetOffset = Offset.zero;
  double _currentPosition = 0.0;
  double opacity = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    print('scrolling');

    RenderBox textFieldRenderBox =
        widgetKey.currentContext!.findRenderObject() as RenderBox;
    widgetOffset = textFieldRenderBox.localToGlobal(Offset.zero);
    _currentPosition = widgetOffset.dy;

    print("widget position: $_currentPosition against: 100");

    if (100 > _currentPosition && _currentPosition > 1) {
      setState(() {
        opacity = _currentPosition / 100;
      });
    } else if (_currentPosition > 100 && opacity != 1) {
      opacity = 1;
    } else if (_currentPosition < 0 && opacity != 0) {
      opacity = 0;
    }
    print("opacity is: $opacity");
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 35.0),
                  child: Text(
                    "CYSCOM",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Rubik",
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            color: Color.fromRGBO(0, 255, 255, 0.8),
                            blurRadius: 10.0,
                          )
                        ]),
                    textAlign: TextAlign.center,
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 0.0),
                  child: Text(
                    "MEMBER DASHBOARD",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Rubik",
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            color: Color.fromRGBO(0, 255, 255, 0.8),
                            blurRadius: 10.0,
                          )
                        ]),
                    textAlign: TextAlign.center,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: GlassTexture(
                    container_child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            child: Text(
                              "PERSONAL INFO",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Rubik",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    color: Color.fromRGBO(0, 0, 0, 0.8),
                                    blurRadius: 10.0,
                                  )
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                            "NAME : ${user_data["name"]}",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Rubik",
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    color: Color.fromRGBO(0, 0, 0, 0.8),
                                    blurRadius: 10.0,
                                  )
                                ]),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "REG NO : ${user_data["reg_no"]}",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Rubik",
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    color: Color.fromRGBO(0, 0, 0, 0.8),
                                    blurRadius: 10.0,
                                  )
                                ]),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "DEPARTMENT : ${user_data["dept"]}",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Rubik",
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    color: Color.fromRGBO(0, 0, 0, 0.8),
                                    blurRadius: 10.0,
                                  )
                                ]),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "EMAIL : ${user_data["email"].replaceAll(",", ".")}",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Rubik",
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    color: Color.fromRGBO(0, 0, 0, 0.8),
                                    blurRadius: 10.0,
                                  )
                                ]),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "POSITION : ${user_data["position"]}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Rubik",
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(1, 1),
                                        color: Color.fromRGBO(0, 0, 0, 0.8),
                                        blurRadius: 10.0,
                                      )
                                    ]),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "POINTS : ${user_data["points"]}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Rubik",
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(1, 1),
                                        color: Color.fromRGBO(0, 0, 0, 0.8),
                                        blurRadius: 10.0,
                                      )
                                    ]),
                                textAlign: TextAlign.center,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    height_: 180,
                    width_: MediaQuery.of(context).size.height,
                    padding_: 10),
              ),
              GlassTexture(
                  container_child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            "BADGES EARNED",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Rubik",
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: Offset(1, 1),
                                  color: Color.fromRGBO(0, 0, 0, 0.8),
                                  blurRadius: 10.0,
                                )
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  height_: 170,
                  width_: MediaQuery.of(context).size.width,
                  padding_: 20),
              Text(
                "TASK LIST",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Rubik",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      color: Color.fromRGBO(0, 0, 0, 0.8),
                      blurRadius: 10.0,
                    )
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminPage extends StatefulWidget {
  AdminPage({super.key, required email});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  ScrollController _scrollController = ScrollController();
  GlobalKey widgetKey = GlobalKey();
  Offset widgetOffset = Offset.zero;
  double _currentPosition = 0.0;
  double opacity = 1;
  String assign_task_desc = "";
  String assign_task_email = "";
  int assign_task_points = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  List<Widget> return_tasks(Map get_user_data) {
    List<Widget> return_list = <Widget>[];
    if (get_user_data.length != 0 && get_user_data["tasklist"] != null) {
      print("act-1");
      print(get_user_data["tasklist"].keys.toString());
      for (var i in get_user_data["tasklist"].keys) {
        print(i.toString().split("-:-")[0]);
        return_list.add(GlassTexture(
            container_child: Container(
                child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Container(
                    child: Text(
                        "DESC : ${i.toString().split("-:-")[0]}\nASSIGNED TO :\n${i.toString().split("-:-")[1].replaceAll(",", ".")}\nPOINTS:${get_user_data["tasklist"][i.toString()]}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Rubik',
                            fontSize: 12,
                            shadows: [
                              Shadow(
                                  blurRadius: 10,
                                  color: Colors.black,
                                  offset: Offset(0, 0))
                            ]))),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          user_data["tasklist"].remove("${i}");
                          print("HAHAHAHA" +
                              user_data["tasklist"].runtimeType.toString());
                          Databasecontroller.ReadUserData(
                                  email: assign_task_email)
                              .then((onValue) {
                            var member_tasklist =
                                Map<String, dynamic>.from(onValue as Map);
                            member_tasklist = Map<String, dynamic>.from(
                                member_tasklist["tasklist"]);
                            member_tasklist.remove("${i}");
                            print(member_tasklist);
                            Databasecontroller.UpdateTaskList(
                                assign_task_email.replaceAll(".", ","),
                                member_tasklist);
                          });
                          Databasecontroller.UpdateTaskList(
                              usr_email.replaceAll(".", ","),
                              Map<String, dynamic>.from(
                                  user_data["tasklist"] as Map));
                        });
                      },
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          int inc_points = user_data["tasklist"]["${i}"];

                          print("hehe" + inc_points.toString());
                          assign_task_email =
                              i.toString().split("-:-")[1].toString();
                          user_data["tasklist"].remove("${i}");
                          print("HAHAHAHA" +
                              user_data["tasklist"].runtimeType.toString());
                          Databasecontroller.ReadUserData(
                                  email: assign_task_email)
                              .then((onValue) {
                            var member_tasklist =
                                Map<String, dynamic>.from(onValue as Map);
                            print(member_tasklist["points"].runtimeType);
                            int curr_pts = member_tasklist["points"];
                            Databasecontroller.UpdateUserPoints(
                                assign_task_email, curr_pts + inc_points);
                            member_tasklist = Map<String, dynamic>.from(
                                member_tasklist["tasklist"]);
                            member_tasklist.remove("${i}");
                            print(member_tasklist);

                            Databasecontroller.UpdateTaskList(
                                assign_task_email.replaceAll(".", ","),
                                member_tasklist);
                          });
                          Databasecontroller.UpdateTaskList(
                              usr_email.replaceAll(".", ","),
                              Map<String, dynamic>.from(
                                  user_data["tasklist"] as Map));
                        });
                      },
                      icon: Icon(Icons.check_circle),
                      color: Colors.green,
                    ),
                  ],
                ),
              ],
            )),
            height_: 140,
            width_: double.infinity,
            padding_: 10));
      }
    }
    if (return_list == []) {
      return [
        GlassTexture(
            container_child: Center(
              child: Text("NO TASKS ASSIGNED YET",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Rubik',
                    fontSize: 12,
                  )),
            ),
            height_: 100,
            width_: double.infinity,
            padding_: 20)
      ];
    }
    print("act-2");
    return return_list;
  }

  _scrollListener() {
    print('scrolling');

    RenderBox textFieldRenderBox =
        widgetKey.currentContext!.findRenderObject() as RenderBox;
    widgetOffset = textFieldRenderBox.localToGlobal(Offset.zero);
    _currentPosition = widgetOffset.dy;

    print("widget position: $_currentPosition against: 100");

    if (100 > _currentPosition && _currentPosition > 1) {
      setState(() {
        opacity = _currentPosition / 100;
      });
    } else if (_currentPosition > 100 && opacity != 1) {
      opacity = 1;
    } else if (_currentPosition < 0 && opacity != 0) {
      opacity = 0;
    }
    print("opacity is: $opacity");
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 35.0),
                  child: Text(
                    "CYSCOM",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Rubik",
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            color: Color.fromRGBO(0, 255, 255, 0.8),
                            blurRadius: 10.0,
                          )
                        ]),
                    textAlign: TextAlign.center,
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 0.0),
                  child: Text(
                    "ADMIN DASHBOARD",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Rubik",
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            color: Color.fromRGBO(0, 255, 255, 0.8),
                            blurRadius: 10.0,
                          )
                        ]),
                    textAlign: TextAlign.center,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: GlassTexture(
                    container_child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            child: Text(
                              "PERSONAL INFO",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Rubik",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    color: Color.fromRGBO(0, 0, 0, 0.8),
                                    blurRadius: 10.0,
                                  )
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                            "NAME : ${user_data["name"]}",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Rubik",
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    color: Color.fromRGBO(0, 0, 0, 0.8),
                                    blurRadius: 10.0,
                                  )
                                ]),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "REG NO : ${user_data["reg_no"]}",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Rubik",
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    color: Color.fromRGBO(0, 0, 0, 0.8),
                                    blurRadius: 10.0,
                                  )
                                ]),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "DEPARTMENT : ${user_data["dept"]}",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Rubik",
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    color: Color.fromRGBO(0, 0, 0, 0.8),
                                    blurRadius: 10.0,
                                  )
                                ]),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "EMAIL : ${user_data["email"].replaceAll(",", ".")}",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Rubik",
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    color: Color.fromRGBO(0, 0, 0, 0.8),
                                    blurRadius: 10.0,
                                  )
                                ]),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "POSITION : ${user_data["position"]}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Rubik",
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(1, 1),
                                        color: Color.fromRGBO(0, 0, 0, 0.8),
                                        blurRadius: 10.0,
                                      )
                                    ]),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "POINTS : INF.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Rubik",
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(1, 1),
                                        color: Color.fromRGBO(0, 0, 0, 0.8),
                                        blurRadius: 10.0,
                                      )
                                    ]),
                                textAlign: TextAlign.center,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    height_: 180,
                    width_: MediaQuery.of(context).size.height,
                    padding_: 10),
              ),
              GlassTexture(
                  container_child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            "BADGES EARNED",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Rubik",
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: Offset(1, 1),
                                  color: Color.fromRGBO(0, 0, 0, 0.8),
                                  blurRadius: 10.0,
                                )
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  height_: 170,
                  width_: MediaQuery.of(context).size.width,
                  padding_: 20),
              GlassTexture(
                  container_child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "TASK LIST",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Rubik",
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: Offset(1, 1),
                                  color: Color.fromRGBO(0, 0, 0, 0.8),
                                  blurRadius: 10.0,
                                )
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        ElevatedButton(
                          child: Icon(Icons.add),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: WidgetStateColor.transparent,
                              foregroundColor: Colors.white,
                              textStyle: TextStyle(
                                fontFamily: "Rubik",
                                fontWeight: FontWeight.bold,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              )),
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                    backgroundColor:
                                        Colors.black.withOpacity(0.8),
                                    content: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Positioned(
                                          right: -40,
                                          top: -40,
                                          child: InkResponse(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: Colors.red,
                                              child: Icon(Icons.close),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 500,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0),
                                                child: TextField(
                                                  style: TextStyle(
                                                      fontFamily: "Rubik",
                                                      color: Colors.white,
                                                      fontSize: 11),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(6),
                                                    fillColor: Colors.black
                                                        .withOpacity(0.4),
                                                    hoverColor: Colors.black
                                                        .withOpacity(0.5),
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.black,
                                                            width: 3.0),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25))),
                                                    labelText: "EMAIL ID",
                                                    labelStyle: TextStyle(
                                                        fontFamily: "Rubik",
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  ),
                                                  onChanged: (changedText) {
                                                    assign_task_email =
                                                        changedText;
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0),
                                                child: SizedBox(
                                                  height: 100,
                                                  child: TextField(
                                                    maxLines: null,
                                                    expands: true,
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    style: TextStyle(
                                                        fontFamily: "Rubik",
                                                        color: Colors.white,
                                                        fontSize: 11),
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.black
                                                          .withOpacity(0.4),
                                                      hoverColor: Colors.black
                                                          .withOpacity(0.5),
                                                      border: OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 3.0),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          25))),
                                                      labelText: "TASK DESC",
                                                      labelStyle: TextStyle(
                                                          fontFamily: "Rubik",
                                                          color: Colors.white,
                                                          fontSize: 12),
                                                    ),
                                                    onChanged: (changedText) {
                                                      assign_task_desc =
                                                          changedText;
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0),
                                                child: TextField(
                                                  style: TextStyle(
                                                      fontFamily: "Rubik",
                                                      color: Colors.white,
                                                      fontSize: 11),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(8),
                                                    fillColor: Colors.black
                                                        .withOpacity(0.4),
                                                    hoverColor: Colors.black
                                                        .withOpacity(0.5),
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.black,
                                                            width: 3.0),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25))),
                                                    labelText: "POINTS",
                                                    labelStyle: TextStyle(
                                                        fontFamily: "Rubik",
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  ),
                                                  onChanged: (changedText) {
                                                    assign_task_points =
                                                        int.parse(changedText);
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.all(20),
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      await Databasecontroller
                                                              .userValidation(
                                                                  assign_task_email)
                                                          .then((onValue) {
                                                        if (onValue) {
                                                          setState(() {
                                                            if (user_data[
                                                                    "tasklist"] ==
                                                                null) {
                                                              user_data[
                                                                  "tasklist"] = {};
                                                            }
                                                            user_data["tasklist"]
                                                                    [
                                                                    "${assign_task_desc.toString()}-:-${assign_task_email.replaceAll(".", ",")}"] =
                                                                assign_task_points;
                                                            print("HAHAHAHA" +
                                                                user_data[
                                                                        "tasklist"]
                                                                    .runtimeType
                                                                    .toString());
                                                            Databasecontroller
                                                                    .ReadUserData(
                                                                        email:
                                                                            assign_task_email)
                                                                .then(
                                                                    (onValue) {
                                                              var member_tasklist = Map<
                                                                      String,
                                                                      dynamic>.from(
                                                                  onValue
                                                                      as Map);
                                                              if (member_tasklist[
                                                                      "tasklist"] ==
                                                                  null) {
                                                                member_tasklist[
                                                                    "tasklist"] = {};
                                                              } else {
                                                                print("Enters");
                                                                member_tasklist = Map<
                                                                        String,
                                                                        dynamic>.from(
                                                                    member_tasklist[
                                                                            "tasklist"]
                                                                        as Map);
                                                              }
                                                              member_tasklist[
                                                                          "tasklist"]
                                                                      [
                                                                      "${assign_task_desc.toString()}-:-${assign_task_email.replaceAll(".", ",")}"] =
                                                                  assign_task_points;
                                                              print(
                                                                  member_tasklist);
                                                              Databasecontroller.UpdateTaskList(
                                                                  assign_task_email
                                                                      .replaceAll(
                                                                          ".",
                                                                          ","),
                                                                  Map<String,
                                                                      dynamic>.from(member_tasklist[
                                                                          "tasklist"]
                                                                      as Map));
                                                            });
                                                            Databasecontroller.UpdateTaskList(
                                                                usr_email
                                                                    .replaceAll(
                                                                        ".",
                                                                        ","),
                                                                Map<String,
                                                                        dynamic>.from(
                                                                    user_data[
                                                                            "tasklist"]
                                                                        as Map));
                                                          });
                                                        }
                                                      });
                                                    },
                                                    child: Text(
                                                      "SUBMIT",
                                                      style: TextStyle(
                                                        fontFamily: "Rubik",
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Color.fromRGBO(
                                                              36, 35, 34, 1),
                                                      foregroundColor:
                                                          Colors.white,
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ],
                                    )));
                          },
                        )
                      ],
                    ),
                  ),
                  height_: 50,
                  width_: double.infinity,
                  padding_: 0),
              Container(
                  height: 500,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: return_tasks(user_data),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
