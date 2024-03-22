import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class CheckInternetPage extends StatefulWidget {
  @override
  _CheckInternetPageState createState() => _CheckInternetPageState();
}

class _CheckInternetPageState extends State<CheckInternetPage> {
  String _connectionStatus = 'Unknown';

  @override
  void initState() {
    super.initState();
    _checkInternet();
  }

  Future<void> _checkInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() => _connectionStatus = 'Mobile data');
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() => _connectionStatus = 'Wi-Fi');
    } else {
      setState(() => _connectionStatus = 'No internet connection');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Internet Connectivity'),
      ),
      body: Center(
        child: Text('Connection status: $_connectionStatus'),
      ),
    );
  }
}
