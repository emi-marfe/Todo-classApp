import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mytodo/constant/constant.dart';
import 'package:mytodo/models/task.dart';
import 'package:mytodo/screens/signupscreen.dart';
import 'package:mytodo/service/service.dart';

class dashboard extends StatefulWidget {
  Map<String, dynamic> data;

  dashboard({Key? key, required this.data}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  String _btn1SelectedVal = 'One';
  UserService service = UserService();
  bool isLoading = false;
  List<Task> AllTask = [];

  @override
  void initState() {
    // TODO: implement initState
    service.getAllTask(token: widget.data["Token"]).then((res) {
      setState(() {
        AllTask = res;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.data);
    const menuItems = <String>[
      'One',
      'Two',
      'Three',
      'Four',
    ];
    final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
        .map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ),
        )
        .toList();

    DateTime initaildate = DateTime.now();
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController dateController = TextEditingController();

    String selected = "";

    List iteams = [
      {"Icon": Icons.assignment, "title": "All Task", "ontap": signupscreen()},
      {
        "Icon": Icons.assignment,
        "title": "In Progress",
        "ontap": signupscreen()
      },
      {"Icon": Icons.badge, "title": "Completed", "ontap": signupscreen()},
      {"Icon": Icons.assignment, "title": "Today", "ontap": signupscreen()},
      {"Icon": Icons.assignment, "title": "Tommorrow", "ontap": signupscreen()},
      {
        "Icon": Icons.assignment,
        "title": "Month",
        "ontap": {signupscreen}
      }
    ];
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Container(
        child: IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setdialogscreen) {
                    return AlertDialog(
                      titlePadding: EdgeInsets.zero,
                      contentPadding: EdgeInsets.zero,
                      title: Container(
                        width: double.infinity,
                        alignment: Alignment.centerRight,
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.cancel)),
                      ),
                      content: isLoading
                          ? SpinKitSpinningCircle(color: Colors.green)
                          : SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, bottom: 5),
                                    child: Text(
                                      "Titlewwww",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "what needs to be done?",
                                        border: new OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(8),
                                          ),
                                          borderSide: new BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, bottom: 5, top: 10),
                                    child: Text(
                                      "Description",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: TextField(
                                      controller: descriptionController,
                                      maxLength: 100,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                        hintText: "Description about task?",
                                        border: new OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(8),
                                          ),
                                          borderSide: new BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, bottom: 5, top: 10),
                                    child: Text(
                                      "Date Picker",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: TextField(
                                      controller: dateController,
                                      decoration: InputDecoration(
                                        hintText: "pick a date",
                                        border: new OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(8),
                                          ),
                                          borderSide: new BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      readOnly: true,
                                      onTap: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: initaildate,
                                                firstDate: DateTime(1999),
                                                lastDate: DateTime(2024))
                                            .then((value) {
                                          if (value != null) {
                                            dateController.text = value
                                                .toString()
                                                .substring(0, 10);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    // Must be one of items.value.
                                    value: _btn1SelectedVal,
                                    onChanged: (String? newValue) {
                                      if (newValue != null) {
                                        setdialogscreen(() {
                                          _btn1SelectedVal = newValue;
                                          print(newValue);
                                        });
                                      }
                                    },
                                    items: _dropDownMenuItems,
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          setdialogscreen(() {
                                            isLoading = true;
                                          });
                                          service
                                              .addNewTask(
                                                  description:
                                                      descriptionController
                                                          .text,
                                                  token: widget.data["Token"])
                                              .then((value) {
                                            setdialogscreen(() {
                                              isLoading = false;
                                            });
                                            Navigator.pop(context);

                                            if (value == true) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                "Added Suceffull",
                                                textAlign: TextAlign.center,
                                              )));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                "Error, Try Again",
                                                textAlign: TextAlign.center,
                                              )));
                                            }
                                          });
                                        },
                                        child: isLoading
                                            ? SpinKitSpinningCircle(
                                                color: Colors.green)
                                            : Text("Add New Task")),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  )
                                ],
                              ),
                            ),
                    );
                  });
                }).then((value) {
              dateController.clear();
            });
          },
          icon: FaIcon(
            FontAwesomeIcons.plus,
            color: Colors.white,
          ),
        ),
        alignment: Alignment.center,
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), color: Colors.blueAccent),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text("ToDo:${widget.data["UserEmail"]}"),
      ),
      drawer: Container(
        color: Colors.blueAccent,
        width: screensize.width / 1.2,
        height: screensize.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                // currentAccountPicture: CircleAvatar(
                //   backgroundColor: Colors.red,
                // ),
                accountName: Text("Marvellous"),
                accountEmail: Text("${widget.data["UserEmail"]}")),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: iteams.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Icon(iteams[index]["Icon"]),
                      title: Text(iteams[index]["title"]),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: screensize.width,
        height: screensize.height,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text(
                      "My All Task",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Text("(${AllTask.length})")
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: AllTask.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = AllTask[index];

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    height: 200,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Topic One",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: FaIcon(
                                  FontAwesomeIcons.trashAlt,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Scrollbar(
                            child: ListView(children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 0, left: 10, right: 10),
                                child: Text(
                                  data.description,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ]),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                // Navigator.pushAndRemoveUntil(
                                //     context,
                                //     MaterialPageRoute(builder: (_) => MyHomePage()),
                                //     (route) => false);
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.clock,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                            Text(
                              data.createdAt.substring(0, 10),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: FaIcon(
                                FontAwesomeIcons.solidFlag,
                                color: Colors.red,
                                size: 15,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                service.Getcompleted(
                                    token: widget.data['Token'], Id: data.id);
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.shieldAlt,
                                color: data.completed
                                    ? Colors.green
                                    : Colors.white,
                                size: 15,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
