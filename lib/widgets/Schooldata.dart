import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DatabaseHelper.dart';
import 'LoginResponse.dart';
class FormPage extends StatelessWidget {
  final LoginResponse loginResponse;
  FormPage({Key? key, required this.loginResponse}) : super(key: key);
int stdid=0;

  @override
  Widget build(BuildContext context) {
      schoolData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Page'),
      ),
      body:  buildTextFields(),
    );
  }

  Widget buildTextFields() => Padding(
    padding: const EdgeInsets.all(35),
    child: Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTextField1(),
          SizedBox(height: 20,),
          buildTextField2(),
          SizedBox(height: 20,),
          buildTextField3(),
          SizedBox(height: 20,),
          buildTextField4(),
          SizedBox(height: 20,),
          buildTextField5(),

        ],
      ),
    ),
  );

  Widget buildTextField1() => TextFormField(
      enabled: false,
      decoration: InputDecoration(
  focusedBorder: OutlineInputBorder(
  borderSide: BorderSide(color: Colors.red),
  borderRadius: BorderRadius.circular(5.5),
  ),
  enabledBorder: OutlineInputBorder(
  borderSide: BorderSide(
  color: Colors.red,
  ),
  ),
  prefixIcon: Icon(
  Icons.person,
  color: Colors.red,
  ),
  filled: true,
  fillColor: Colors.red[50],
  labelText: "Enter your Name",
  labelStyle: TextStyle(color: Colors.red),
  ),);

  Widget buildTextField2() => TextFormField(
    enabled: false,
    decoration: InputDecoration(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.green,
        ),
      ),
      prefixIcon: Icon(
        Icons.school,
        color: Colors.green,
      ),
      filled: true,
      fillColor: Colors.green[50],
      labelText: "Enter your Name",
      labelStyle: TextStyle(color: Colors.green),
    ),
  );

  Widget buildTextField3() => TextFormField(
    enabled: false,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(5.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(5.5),
      ),
      prefixIcon: Icon(Icons.medical_information, color: Colors.blue),
      hintText: "Enter your Name",
      hintStyle: TextStyle(color: Colors.blue),
      filled: true,
      fillColor: Colors.blue[50],
    ),
  );

  Widget buildTextField4() => TextFormField(
    enabled: false,
    decoration: InputDecoration(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.green,
        ),
      ),
      prefixIcon: Icon(
        Icons.school_outlined,
        color: Colors.green,
      ),
      filled: true,
      fillColor: Colors.green[50],
      labelText: "Enter your Name",
      labelStyle: TextStyle(color: Colors.green),
    ),
  );

  Widget buildTextField5() => TextFormField(
    enabled: false,
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(5.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      prefixIcon: Icon(
        Icons.school,
        color: Colors.red,
      ),
      filled: true,
      fillColor: Colors.red[50],
      labelText: "Enter your Name",
      labelStyle: TextStyle(color: Colors.red),
    ),
  );
///int studentId = await DatabaseHelper.instance.insertStudent('John', 20, 'A', '123 Main St');

schoolData()async{
  int studentId = await DatabaseHelper.instance.insertStudent('John', 20, 'A', '123 Main St');
  stdid=studentId;
}


}
