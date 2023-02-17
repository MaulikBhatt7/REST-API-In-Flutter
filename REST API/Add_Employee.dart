import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class AddEmployee extends StatefulWidget {
  @override
  State<AddEmployee> createState() => _AddEmployeeState();

  dynamic? map;
  AddEmployee(this.map);

  GlobalKey<FormState> formkey = GlobalKey();
  var name = new TextEditingController();
  var code = new TextEditingController();
  var email = new TextEditingController();
  var mobile_no = new TextEditingController();


}

class _AddEmployeeState extends State<AddEmployee> {
  void initState(){
    widget.name.text = widget.map==null?'':widget.map['EmployeeName'];
    widget.code.text = widget.map==null?'':widget.map['EmployeeCode'].toString();
    widget.email.text = widget.map==null?'':widget.map['EmployeeEmail'];
    widget.mobile_no.text = widget.map==null?'':widget.map['EmployeeMobile'];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: TextFormField(
              controller: widget.name,
              decoration: InputDecoration(
                hintText: "Enter Employee's name",
              ),
            ),
          ),
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Enter Employee's code",
              ),
              controller: widget.code,
            ),
          ),
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Enter Employee's email",
              ),
              controller: widget.email,
            ),
          ),
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Enter Employee's mobile no.",
              ),
              controller: widget.mobile_no,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () async {
                if(widget.map==null){
                  await addEmployee().then((value) => (value) {

                  });
                }
                else{
                  await editEmployee().then((value) => (value) {

                  });
                }

                Navigator.of(context).pop(true);
                
              }, child: Text("Submit",style: TextStyle(fontSize: 24),),
            ),
          )
        ],
      ),
    );
  }

  Future<void> addEmployee() async{
    var map ={};
    map['EmployeeName']=widget.name.text;
    map['EmployeeCode']=widget.code.text;
    map['EmployeeEmail']=widget.email.text;
    map['EmployeeMobile']=widget.mobile_no.text;
    var response1 = http.post(Uri.parse("https://632158b682f8687273afe9c3.mockapi.io/EmployeeDetails",),body: map);
  }

  Future<void> editEmployee() async{
    var map ={};
    map['EmployeeName']=widget.name.text;
    map['EmployeeCode']=widget.code.text;
    map['EmployeeEmail']=widget.email.text;
    map['EmployeeMobile']=widget.mobile_no.text;
    var response1 = http.put(Uri.parse("https://632158b682f8687273afe9c3.mockapi.io/EmployeeDetails/"+widget.map['id'].toString(),),body: map);
  }
}
