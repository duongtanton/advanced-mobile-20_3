import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_20120598/src/components/header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> list = <String>['Nước ngoài', 'Việt Nam', 'Bản địa'];
  String dropdownValue = "Nước ngoài";
  TextEditingController dateInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Header(login: true),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.blue,
                  padding: const EdgeInsets.only(
                      top: 46, bottom: 30, left: 30, right: 30),
                  child: const Column(
                    children: [
                      Text("Bạn không có buổi học nào.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30, color: Colors.white)),
                      Padding(padding: EdgeInsets.only(top: 26)),
                      Text(
                        "Chào mừng bạn đến với Letutor.",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tìm kiếm gia sư",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 20)),
                        Row(
                          children: [
                            const Expanded(
                              child: Padding(
                                  padding: EdgeInsets.only(bottom: 18),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: "Nhập tên gia sư..."),
                                  )),
                            ),
                            const Padding(padding: EdgeInsets.only(right: 10)),
                            DropdownButton<String>(
                              value: dropdownValue,
                              padding: const EdgeInsets.only(bottom: 0),
                              icon: const Icon(Icons.arrow_downward),
                              underline: Container(
                                height: 2,
                                color: Colors.black26,
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                              items: list.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                        const Text("Chọn một ngày có lịch trống"),
                        Row(
                          children: [
                            Expanded(
                                child: TextField(
                              controller: dateInput,
                              //editing controller of this TextField
                              decoration: const InputDecoration(
                                  icon: Icon(Icons.calendar_today),
                                  //icon of text field
                                  labelText: "Enter Date" //label text of field
                                  ),
                              readOnly: true,
                              //set it true, so that user will not able to edit text
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2100));

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  setState(() {
                                    dateInput.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {}
                              },
                            )),
                          ],
                        ),
                        const Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.timer),
                                    //icon of text field
                                    labelText:
                                        "Start time" //label text of field
                                    ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.timer),
                                    //icon of text field
                                    labelText: "End time" //label text of field
                                    ),
                              ),
                            )
                          ],
                        )
                      ]),
                )
              ],
            ),
          ))
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => {},
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const Padding(padding: EdgeInsets.only(top: 8)),
          FloatingActionButton(
            onPressed: () => {},
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
