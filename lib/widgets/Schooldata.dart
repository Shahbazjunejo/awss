import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DatabaseHelper.dart';
import 'LoginDataResponse.dart';
import 'LoginResponse.dart';
class FormPage extends StatelessWidget {
  final Root loginResponse;
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
          buildTextField1(loginResponse.data?.name),
          SizedBox(height: 20,),
          buildTextField2(loginResponse.data?.username),
          SizedBox(height: 20,),
          buildTextField3(loginResponse.data?.email),
        //  SizedBox(height: 20,),
        //  buildTextField4(loginResponse.data?.semiscode as String?),
          SizedBox(height: 20,),
          buildTextField5(loginResponse.data?.contact),
          SizedBox(height: 20,),
          buildTextField6(loginResponse.data?.cnic),
          SizedBox(height: 20,),
          buildTextField7(loginResponse.data?.address),

        ],
      ),
    ),
  );

  Widget buildTextField1(String? name) => TextFormField(
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
  labelText: "Name:   $name",
  labelStyle: TextStyle(color: Colors.red),
  ),);

  Widget buildTextField2(String? username) => TextFormField(
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
      labelText: "User Name :$username",
      labelStyle: TextStyle(color: Colors.green),
    ),
  );

  Widget buildTextField3(String? email) => TextFormField(
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
      hintText: "Email: $email",
      hintStyle: TextStyle(color: Colors.blue),
      filled: true,
      fillColor: Colors.blue[50],
    ),
  );

  Widget buildTextField4(String? semiscode) => TextFormField(
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
      labelText: "SemisCode: $semiscode",
      labelStyle: TextStyle(color: Colors.green),
    ),
  );

  Widget buildTextField5(String? contact) => TextFormField(
    enabled: false,
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
        borderRadius: BorderRadius.circular(5.5),
      ),
      enabledBorder: OutlineInputBorder(
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
      labelText: "Contact: $contact",
      labelStyle: TextStyle(color: Colors.green),
    ),
  );

  Widget buildTextField6(String? cnic) => TextFormField(
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
      filled: true,
      fillColor: Colors.blue[50],
      labelText: "CNIC : $cnic",
      labelStyle: TextStyle(color: Colors.blue),
    ),
  );

  Widget buildTextField7(String? Villageaddress) => TextFormField(
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
      labelText: "Address : $Villageaddress",
      labelStyle: TextStyle(color: Colors.red),
    ),
  );




///int studentId = await DatabaseHelper.instance.insertStudent('John', 20, 'A', '123 Main St');

schoolData()async{
  int studentId = await DatabaseHelper.instance.insertStudent('John', 20, 'A', '123 Main St');
  stdid=studentId;
}


}
