import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cowin/Models/DisctrictsModel.dart';
import 'package:cowin/Models/IndStateModel.dart';
import 'package:cowin/homePage.dart';
import 'package:cowin/methods/DistrictsViewModel.dart';
import 'package:cowin/methods/StatesViewModel.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  TextEditingController stateController = new TextEditingController();
  TextEditingController districtController = new TextEditingController();

  GlobalKey<AutoCompleteTextFieldState<StatesModel>> key = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<DistrictBlockModel>> key2 =
      new GlobalKey();

  String selectedStateid;
  String selectedStateName;

  DistrictBlockModel districtBlockModel;
  String selectedDistName;
  String selectedDistId;
  void _loadStates() async {
    await StateViewModel.getStates();
  }

  @override
  void initState() {
    // TODO: implement initState
    // _loadData();
    _loadStates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            AutoCompleteTextField<StatesModel>(
              controller: stateController,
              clearOnSubmit: false,
              key: key,
              suggestions: StateViewModel.statesModel,
              // StateViewModel.statesModel,
              style: new TextStyle(color: Colors.black, fontSize: 16.0),
              itemBuilder: (context, item) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      item.stateName,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                    ),
                    Text(
                      item.stateId.toString(),
                    )
                  ],
                );
              },
              itemFilter: (item, query) {
                return item.stateName
                    .toLowerCase()
                    .startsWith(query.toLowerCase());
              },
              itemSorter: (a, b) {
                return a.stateName.compareTo(b.stateName);
              },
              itemSubmitted: (item) async {
                selectedStateid = item.stateId.toString();
                selectedStateName = item.stateName;
                setState(() {
                  DistrictViewModel.districts.clear();
                  stateController.text = item.stateName;
                });
                await DistrictViewModel.getDistricts(id: selectedStateid);
                setState(() {});
              },
              decoration: new InputDecoration(
                  suffixIcon: Container(
                    width: 85.0,
                    height: 60.0,
                  ),
                  contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                  filled: true,
                  // hintText: 'Search Player Name',
                  hintStyle: TextStyle(color: Colors.black)),
            ),
            DistrictViewModel.districts.length == 0
                ? Text("getting")
                :
//            DropdownButton(
//                    isExpanded: false,
//                    value: selectedDistName,
//                    items: DistrictViewModel.districts
//                        .map<DropdownMenuItem<DistrictBlockModel>>(
//                            (e) => DropdownMenuItem(
//                                  value: DistrictBlockModel(
//                                    districtName: e.districtName,
//                                    districtId: e.districtId,
//                                  ),
//                                  child: Text(e.districtName),
//                                ))
//                        .toList(),
//                    onChanged: (dm) {
//                      setState(() {
//                        selectedDistName = dm.districtName;
//                        selectedDistId = dm.districtId.toString();
//                      });
//                    },
//                  ),

                // AutoCompleteTextField<DistrictBlockModel>(
                //   controller: districtController,
                //   clearOnSubmit: false,
                //   key: key2,
                //   suggestions: DistrictViewModel.districts,
                //   // StateViewModel.statesModel,
                //   style: new TextStyle(color: Colors.black, fontSize: 16.0),
                //   itemBuilder: (context, item) {
                //     return Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: <Widget>[
                //         Text(
                //           item.districtName,
                //           style: TextStyle(fontSize: 16.0),
                //         ),
                //         Padding(
                //           padding: EdgeInsets.all(15.0),
                //         ),
                //         Text(
                //           item.districtId.toString(),
                //         )
                //       ],
                //     );
                //   },
                //   itemFilter: (item, query) {
                //     if (districtController.text == null)
                //       return true;
                //     else
                //       return item.districtName.toLowerCase().startsWith(query.toLowerCase());
                //   },
                //   itemSorter: (a, b) {
                //     print("sorting");
                //     return a.districtName.compareTo(b.districtName);
                //   },
                //   itemSubmitted: (item) async {
                //     selectedDistId = item.districtId.toString();
                //     selectedDistName = item.districtName;
                //     setState(() {
                //       return districtController.text = item.districtName;
                //     });
                //   },
                //   decoration: new InputDecoration(
                //       suffixIcon: Container(
                //         width: 85.0,
                //         height: 60.0,
                //       ),
                //       contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                //       filled: true,
                //       // hintText: 'Search Player Name',
                //       hintStyle: TextStyle(color: Colors.black)),
                // ),
//
                DropdownSearch<DistrictBlockModel>(
                    searchBoxController: TextEditingController(text: ''),
                    mode: Mode.BOTTOM_SHEET,
                    items: DistrictViewModel.districts,

                    maxHeight: 500,
                    isFilteredOnline: true,
                    showClearButton: true,
                    showSearchBox: true,
//                    showSelectedItem: true,
//                    label: 'District',
                    dropdownSearchDecoration: InputDecoration(
                      filled: true,
                      fillColor:
                          Theme.of(context).inputDecorationTheme.fillColor,
                    ),
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (u) =>
                        u == null ? "District is required " : null,
//              onFind: (String filter) => getData(filter),
                    onChanged: (dm) {
                      setState(() {
                        selectedDistName = dm.districtName;
                        selectedDistId = dm.districtId.toString();
                      });
                    },

                    dropdownBuilder: _customDropDownExample,
                    popupItemBuilder: _customPopupItemBuilderExample,
                    popupSafeArea: PopupSafeArea(top: true, bottom: true),
//                    selectedItem:
//                        districtBlockModel ?? DistrictViewModel.districts[0],
                  ),
            Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.blueAccent,
                child:
                    Text("Find Centres", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => MyHomePage(
                                stateName: selectedStateName,
                              )));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customDropDownExample(
      BuildContext context, DistrictBlockModel item, String itemDesignation) {
    if (item == null) {
      return Container();
    }

    return Container(
//      height: 20,
      child: ListTile(
//        key: item.districtId,
//        dense: true,
//        isThreeLine: false,
        visualDensity: VisualDensity(vertical: -4, horizontal: 0),
        contentPadding: EdgeInsets.all(0),
//              leading: CircleAvatar(
//                  // this does not work - throws 404 error
//                  // backgroundImage: NetworkImage(item.avatar ?? ''),
//                  ),
        title: Text(item.districtName),
        subtitle: Text(item.districtId.toString()),
      ),
    );
  }

  Widget _customPopupItemBuilderExample(
      BuildContext context, DistrictBlockModel item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        visualDensity: VisualDensity(vertical: -4, horizontal: 0),
//        dense: true,
        selected: isSelected,
        isThreeLine: false,
        title: Text(item.districtName),
        subtitle: Text(item.districtId.toString()),

//        leading: CircleAvatar(
//          // this does not work - throws 404 error
//          // backgroundImage: NetworkImage(item.avatar ?? ''),
//        ),
      ),
    );
  }
}
