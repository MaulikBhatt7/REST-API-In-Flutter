import 'dart:convert';

import 'package:firstproject/Add_Employee.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RestAPIPage extends StatefulWidget {
  @override
  State<RestAPIPage> createState() => _RestAPIPageState();
}

class _RestAPIPageState extends State<RestAPIPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return AddEmployee(null);
                },
              ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                              snapshot.data![index]['EmployeeName'].toString()),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        child: InkWell(
                          onTap: ()  {
                             deleteEmplyee(snapshot.data![index]['id']).then((value) => (value) {
                              setState(() {
                                return;
                              });
                            });
                          },
                          child: Icon(Icons.delete),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return AddEmployee(snapshot.data![index]);
                              },
                            )).then((value) {

                                setState(() {

                                });


                            },);
                          },
                          child: Icon(Icons.edit),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<List> getDetails() async {
    var response1 = await http.get(Uri.parse(
        "https://632158b682f8687273afe9c3.mockapi.io/EmployeeDetails"));
    return jsonDecode(response1.body);
  }

  Future<void> deleteEmplyee(id) async {
    var response1 = await http.delete(Uri.parse(
        "https://632158b682f8687273afe9c3.mockapi.io/EmployeeDetails/"+id));
    return;
  }
}
