import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  String stateName;
  MyHomePage({@required this.stateName});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController scrollController = ScrollController();
  Widget myCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  child: Center(
                    child: Text(
                      "COVISHIELD",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  height: 40,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(22),
                    ),
                    color: Colors.red,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("G.B. Pant Hospital", style: TextStyle(fontWeight: FontWeight.w500)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("JLN Marg, Delhi Gate, New Delhi", style: TextStyle(color: Colors.grey)),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(" 45+ ", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500)),
                        Text("Age", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    SizedBox(width: 10),
                    Column(
                      children: [
                        Text("120", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500)),
                        Text("Doses", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              //TIME SLOTS

              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Slots Available:", style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 5),
                      Text("9:00AM - 12:00PM"),
                      SizedBox(height: 2),
                      Text("9:00AM - 12:00PM"),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(88)),
            ),
          ),
          CupertinoScrollbar(
            controller: scrollController,
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Text("Odessa,", style: TextStyle(color: Colors.white, fontSize: 40))),
                    Text("Fri, 8 Mar", style: TextStyle(color: Colors.white, fontSize: 20)),
                  ],
                ),
                Text("${widget.stateName}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 20),
                for (int i = 0; i < 100; i++) myCard()
              ],
            ),
          )
        ],
      )),
    );
  }
}
