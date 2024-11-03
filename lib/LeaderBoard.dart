import 'package:flutter/material.dart';
import 'package:mod_appl/components/GlassTexture.dart';

class Leaderboard extends StatelessWidget {
  Map Data;
  Leaderboard({super.key, required this.Data});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/img/bg.jpg"), fit: BoxFit.cover)),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: LeaderBoardPage(Data: Data),
              backgroundColor: Colors.transparent,
            )));
  }
}

class LeaderBoardPage extends StatelessWidget {
  Map Data;
  LeaderBoardPage({super.key, required this.Data});

  List<Widget> getCards(Map Data) {
    List<Widget> l_1 = [];
    var sorted_data = [];
    Map memberPointMap = {};
    int member_count = 0;
    for (var i in Data.keys) {
      if (Data[i]["position"] == "MEMBER") {
        memberPointMap[i] = Data[i]["points"];
        member_count += member_count;
      } else {
        memberPointMap[i] = 10000000;
      }
    }
    print(member_count);
    final sorted = memberPointMap.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    memberPointMap = {for (var entry in sorted) entry.key: entry.value};
    Map rank = {25: "Masters.png", 50: "Emerald.png", 100: "Silver.png"};
    int temp_count = 0;
    for (var i in memberPointMap.keys) {
      print(i);
      if (memberPointMap[i] == 10000000) {
        print("Enters");
        l_1.add(GlassTexture(
            container_child: Container(
              width: 500,
              height: 100,
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset("assets/img/Challenger.png"),
                  width: 50,
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 45),
                  child: Container(
                    width: 500,
                    height: 100,
                    child: Column(
                      children: [
                        Text(
                          "${Data[i]["name"]}",
                          style: TextStyle(
                            fontFamily: "Rubik",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${Data[i]["position"]}",
                          style: TextStyle(
                            fontFamily: "Rubik",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  "∞",
                  style: TextStyle(
                    fontFamily: "Rubik",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
            height_: 200,
            width_: 500,
            padding_: 10));
      } else {
        var png_img;
        int perc = 0;
        if (perc >= 0 && perc <= 25) {
          png_img = "Masters.png";
        } else if (perc > 25 && perc <= 50) {
          png_img = "Emerald.png";
        } else {
          png_img = "Silver.png";
        }
        l_1.add(GlassTexture(
            container_child: Container(
              width: 500,
              height: 100,
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset("assets/img/${png_img}"),
                  width: 50,
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 45),
                  child: Container(
                    width: 500,
                    child: Column(
                      children: [
                        Text(
                          "${Data[i]["name"]}",
                          style: TextStyle(
                            fontFamily: "Rubik",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${Data[i]["position"]}",
                          style: TextStyle(
                            fontFamily: "Rubik",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  "${memberPointMap[i]}",
                  style: TextStyle(
                    fontFamily: "Rubik",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
            height_: 200,
            width_: double.infinity,
            padding_: 10));
      }
    }

    return l_1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.only(top: 35.0, bottom: 30.0),
              child: Text(
                "LEADERBOARD",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Rubik",
                    fontSize: 30.0,
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
          Container(
            width: MediaQuery.of(context).size.width,
            height: 500,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: getCards(Data),
            ),
          )
        ],
      ),
    );
  }
}
