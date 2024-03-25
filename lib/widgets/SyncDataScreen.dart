import 'package:flutter/material.dart';

import '../DatabaseHelper.dart';

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

  static void sendData( StudentData studentData) {
    // Send data to the backend
    print('Sending data: ${studentData.name}, ${studentData.contact}, ${studentData.email}');
    // Implement your logic to send data to the backend here
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
          onPressed: () {
            // Perform action when the button is pressed
            // For example, send data to the backend
            BackendService.sendData(item);
          },
        ),
      ),
    );
  }


}
