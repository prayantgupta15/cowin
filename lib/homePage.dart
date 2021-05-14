import 'package:cowin/Models/CenterModel.dart';
import 'package:cowin/methods/CenterViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  String stateName;
  String districtName;
  String districtId;
  String stateId;
  MyHomePage({
    @required this.stateName,
    @required this.stateId,
    @required this.districtName,
    @required this.districtId,
  });
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController scrollController = ScrollController();

  bool loading = true;

  Widget myCard(CenterBlockModel centerBlockModel) {
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
                      centerBlockModel.sessions[0].vaccine.toString() ?? 'NA',
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
                child: Text(centerBlockModel.name, style: TextStyle(fontWeight: FontWeight.w500)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(centerBlockModel.address, style: TextStyle(color: Colors.grey)),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                            centerBlockModel.sessions[0].minAgeLimit == null
                                ? 'NA'
                                : centerBlockModel.sessions[0].minAgeLimit.toString() + '+',
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500)),
                        Text("Age", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    SizedBox(width: 10),
                    Column(
                      children: [
                        Text(
                            centerBlockModel.sessions[0].availableCapacity == null
                                ? 'NA'
                                : centerBlockModel.sessions[0].availableCapacity.toString(),
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500)),
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
                      for (int i = 0; i < centerBlockModel.sessions[0].slots.length; i++)
                        Column(
                          children: [
                            Text(centerBlockModel.sessions[0].slots[i]),
                          ],
                        ),
                      SizedBox(height: 2),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _loadData() async {
    await CenterViewModel.getCentresByDistrict(distId: widget.districtId);
  }

  @override
  void initState() {
    // TODO: implement initState
    _loadData();
    super.initState();
    if (mounted)
      setState(() {
        loading = false;
      });
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
                    Flexible(
                        child: Text("${widget.districtName},",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                            ))),
                    Text("Fri, 8 Mar", style: TextStyle(color: Colors.white, fontSize: 20)),
                  ],
                ),
                Text("${widget.stateName}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    )),
                loading
                    ? CircularProgressIndicator()
                    : CenterViewModel.centres.length == 0
                        ? Text("No Appoinemtns")
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: CenterViewModel.centres.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) => myCard(CenterViewModel.centres[i]),

                            // ------------------------------------------------------

                            // FutureBuilder(
                            //   future: CenterViewModel.getCentresByDistrict(distId: widget.districtId),
                            //   builder: (context, snapshot) {
                            //     switch (snapshot.connectionState) {
                            //       case ConnectionState.waiting:
                            //         print("Waiting");
                            //         break;
                            //       case ConnectionState.done:
                            //         print("Done");
                            //
                            //         break;
                            //       case ConnectionState.none:
                            //         print("None");
                            //         break;
                            //       case ConnectionState.active:
                            //         print("Active");
                            //         break;
                            //     }
                            //     if (snapshot.hasData) {
                            //       CenterModel cm = snapshot.data;
                            //       print(cm.centers.length.toString());
                            //       print("data");
                            //       return ListView.builder(
                            //           shrinkWrap: true,
                            //           itemCount: cm.centers.length,
                            //           physics: NeverScrollableScrollPhysics(),
                            //           itemBuilder: (context, i) => myCard(cm.centers[i]));
                            //     } else
                            //       return Container();
                            //   },
                            // ),
                          )
              ],
            ),
          )
        ],
      )),
    );
  }
}
