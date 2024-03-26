import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import '../DatabaseHelper.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// Define a model class to represent your data
class StudentData {

  final String name;
  final String contact;
  final String fathername;
  final String fatherCNIC;
  final String email;

  StudentData({
    required this.name,
    required this.contact,
    required this.fathername,
    required this.fatherCNIC,
    required this.email,
  });
}

// Create a service to fetch data from the backend
class BackendService {


  static Future<List<StudentData>> getItems() async {
    // Simulating fetching data from a backend
   List<StudentData>  studentData=await DatabaseHelper.instance.getItems();

    return studentData;
  }




 static void sendDataWithToken(BuildContext context,StudentData studentData,String usertoken) async {
    // Your data to be sent in the body
    Map<String, dynamic> data = {
      'name': studentData.name,
      'contact': studentData.contact,
      'fathername': studentData.fathername,
      'father_cnic': studentData.fatherCNIC,
      'email': studentData.email,
    };





    // Your Bearer token
    String token = usertoken;

    // URL to send the request to
    String url = 'https://samrsys.rsu-sindh.gov.pk/api/saveDummyData';

    // Convert data to JSON format
    String jsonData = json.encode(data);

    // Send HTTP POST request with data in the body and Bearer token in headers
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonData,
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        print('Data sent successfully');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Data sent successfully'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        print('Response: ${response.body}');
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error sending data: $error');
    }
  }
}

class SyncDataScreen extends StatefulWidget {
  @override
  _DatabaseListViewState createState() =>  _DatabaseListViewState();
}

class _MyHomePageState extends State< SyncDataScreen > {
 late  List<StudentData> _items;

  @override
  void initState() {
    super.initState();
    //_fetchItems() ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Example'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return ItemWidget(item: _items[index]);
        },
      ),
    );
  }


}
class _DatabaseListViewState extends State<SyncDataScreen> {
   List<StudentData>? _items;

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    List<StudentData>  studentData=await DatabaseHelper.instance.getItems();
    setState(() {
      _items = studentData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database ListView'),
      ),
      body: ListView.builder(
        itemCount: _items!.length,
        itemBuilder: (context, index) {
          return ItemWidget(item: _items![index]);
        },
      ),
    );
  }




}
class ItemWidget extends StatelessWidget {
  final  StudentData item;

  const ItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(item.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Contact: ${item.contact}'),
            Text('Father\'s Name: ${item.fathername}'),
            Text('Father\'s CNIC: ${item.fatherCNIC}'),
            Text('Email: ${item.email}'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.send),
          onPressed: () async {
            Map<String, dynamic>? user = await DatabaseHelper.instance.getUseraccesstoken(1);
            var connectivityResult = await Connectivity().checkConnectivity();
            if (connectivityResult == ConnectivityResult.mobile ||connectivityResult == ConnectivityResult.wifi){
           BackendService.sendDataWithToken(context,item,  user?[DatabaseHelper.columnaccessToken]);


            }else{
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('INTERNET'),
                    content: Text('INTERNET IS NOT CONNECTED'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );

            }
          },
        ),
      ),
    );
  }


  Future<void> _showMyDialog(BuildContext context,String reason) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[ // Here's a static text.
                Text(reason), // Here you insert the dynamic string.
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
