import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cowin/Models/DisctrictsModel.dart';
import 'package:cowin/Models/IndStateModel.dart';
import 'package:cowin/homePage.dart';
import 'package:cowin/methods/DistrictsViewModel.dart';
import 'package:cowin/methods/StatesViewModel.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  TextEditingController stateController = new TextEditingController();
  TextEditingController districtController = new TextEditingController();
  TextEditingController controller = TextEditingController(text: "");

  GlobalKey<AutoCompleteTextFieldState<StatesModel>> key = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<DistrictBlockModel>> key2 = new GlobalKey();

  StatesModel selectedStatesModel = StatesModel(stateName: 'Choose State', stateId: null);
  // String selectedStateid;
  // String selectedStateName;
  String selectedDate;
  String selectDay;

  List<String> weekday = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  DistrictBlockModel selectedDistModel = DistrictBlockModel(districtName: 'Choose District', districtId: null);
  // String selectedDistName;
  // String selectedDistId;
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
        extendBodyBehindAppBar: false,
        // resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.blueAccent,
        body: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            Image.asset('assets/image.png'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: DropdownSearch<StatesModel>(
                // searchBoxController: TextEditingController(text: ''),
                items: StateViewModel.statesModel,
                selectedItem: selectedStatesModel,

                mode: Mode.DIALOG,
                maxHeight: 300,
                // showSelectedItem: true,
                dropdownSearchDecoration: InputDecoration(
                    labelText: 'State',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
                searchBoxDecoration: InputDecoration(
                  prefix: Icon(Icons.search),
                  hintText: 'Search',
                ),
                // dialogMaxWidth: 500,
                isFilteredOnline: true,
                showClearButton: false,
                showSearchBox: true,
                showAsSuffixIcons: false,
                dropDownButton: Icon(Icons.expand_more, color: Colors.white),
                filterFn: (item, query) {
                  return item.stateName.toLowerCase().startsWith(query.toLowerCase());
                },
                popupBackgroundColor: Colors.grey.shade100.withOpacity(0.6),
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (u) => u == null ? "State is required " : null,
                onChanged: (item) async {
                  selectedStatesModel = StatesModel(stateId: item.stateId, stateName: item.stateName);
                  setState(() {
                    DistrictViewModel.districts.clear();
                    selectedDistModel = DistrictBlockModel(districtName: 'Choose District', districtId: null);

                    stateController.text = item.stateName;
                  });
                  await DistrictViewModel.getDistricts(id: selectedStatesModel.stateId.toString());
                  setState(() {});
                },

                dropdownBuilder: (context, selectedItem, itemAsString) {
                  if (selectedItem == null) {
                    return Container();
                  }
                  return ListTile(
                    title: Text(selectedItem.stateName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                  );
                },
                popupItemBuilder: (context, item, isSelected) {
                  return Column(
                    children: [
                      ListTile(
                          title: Text(
                        item.stateName,
                        style: TextStyle(fontSize: 18),
                      )),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
            // DistrictViewModel.districts.length == 0
            //     ? Container()
            //     :
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: DropdownSearch<DistrictBlockModel>(
                selectedItem: selectedDistModel,
                items: DistrictViewModel.districts,

                mode: Mode.DIALOG,
                maxHeight: 300,
                // showSelectedItem: true,
                dropdownSearchDecoration: InputDecoration(
                    labelText: 'District',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
                searchBoxDecoration: InputDecoration(
                  prefix: Icon(Icons.search),
                  hintText: 'Search',
                ),
                // dialogMaxWidth: 500,
                isFilteredOnline: true,
                showClearButton: false,
                showSearchBox: true,
                showAsSuffixIcons: false,
                dropDownButton: Icon(Icons.expand_more, color: Colors.white),

                filterFn: (item, query) {
                  return item.districtName.toLowerCase().startsWith(query.toLowerCase());
                },
                // showSelectedItem: true
                popupBackgroundColor: Colors.grey.shade200.withOpacity(0.6),

                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (u) => u == null ? "District is required " : null,
//              onFind: (String filter) => getData(filter),
                onChanged: (dm) {
                  setState(() {
                    selectedDistModel = DistrictBlockModel(districtId: dm.districtId, districtName: dm.districtName);
                  });
                },

                popupItemBuilder: (context, item, isSelected) {
                  return Column(
                    children: [
                      ListTile(
                          title: Text(
                        item.districtName,
                      )),
                      Divider(),
                    ],
                  );
                },
                dropdownBuilder: (context, selectedItem, itemAsString) {
                  if (selectedItem == null) {
                    return Container();
                  }
                  return ListTile(
                    title: Text(selectedItem.districtName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                  );
                },
                // popupSafeArea: PopupSafeArea(top: true, bottom: true),
//                    selectedItem:
//                        districtBlockModel ?? DistrictViewModel.districts[0],
              ),
            ),
            SizedBox(height: 30),
            // selectedDistModel.districtId == null
            //     ? Container()
            //     :
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: GestureDetector(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.calendar_today_sharp, color: Colors.white),
                    Text(
                      ' ${selectDay ?? ''}, ${selectedDate ?? 'Choose Date'}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                onTap: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  DateTime date = DateTime.now();
                  date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2021),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    var day = (date.day <= 9 ? '0' : '') + date.day.toString();
                    var month = (date.month <= 9 ? '0' : '') + date.month.toString();
                    selectedDate = day + '-' + month + '-' + date.year.toString();
                    selectDay = weekday[date.weekday - 1];
                  }
                },
              ),
            ),

            FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Find Centres ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ],
              ),
              onPressed: selectedDate == null
                  ? null
                  : () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => MyHomePage(
                                    stateName: selectedStatesModel.stateName,
                                    districtName: selectedDistModel.districtName,
                                    stateId: selectedStatesModel.stateId.toString(),
                                    districtId: selectedDistModel.districtId.toString(),
                                    date: selectedDate,
                                    pin:controller.text,
                                    isPin: false,
                                  )));
                    },
            ),

            Row(mainAxisSize: MainAxisSize.max, children: [
              Expanded(child: Divider(color: Colors.white.withOpacity(0.6), thickness: 2)),
              Text("  OR  ", style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 25)),
              Expanded(child: Divider(color: Colors.white.withOpacity(0.6), thickness: 2)),
            ]),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Search By Pin Code:",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      )),
                  SizedBox(height: 20),
                  PinCodeTextField(
                    controller: controller,
                    highlight: true,
                    defaultBorderColor: Colors.white,
                    pinTextStyle: TextStyle(color: Colors.white),
                    hasTextBorderColor: Colors.grey.shade100.withOpacity(0.5),
                    highlightColor: Colors.white,
                    maxLength: 6,
                    pinBoxHeight: MediaQuery.of(context).size.width / 8,
                    pinBoxWidth: MediaQuery.of(context).size.width / 8,
                    pinBoxRadius: 16,
                    onDone: (otp) {
                      // if (otp != null && otp.length == 6)
                    },
                  ),
                  SizedBox(height: 20),
                  FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Find Centres ",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    ),
                    onPressed: 
                      selectedDate == null || controller.text.isEmpty
                  ? null
                  : () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => MyHomePage(
                                    stateName: selectedStatesModel.stateName,
                                    districtName: selectedDistModel.districtName,
                                    stateId: selectedStatesModel.stateId.toString(),
                                    districtId: selectedDistModel.districtId.toString(),
                                    date: selectedDate,
                                    pin: controller.text,
                                    isPin: true,
                                  )));
                    },
                    
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
