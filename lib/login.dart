import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sindhsupportunit/widgets/LoginDataResponse.dart';
import 'package:sindhsupportunit/widgets/LoginResponse.dart';
import 'package:sindhsupportunit/widgets/Schooldata.dart';

import 'DatabaseHelper.dart';
import 'SubmitForm.dart';
import 'home_screen.dart';
import 'main.dart';

class LoginPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  int _connectionStatus = 0;
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkInternet();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fill
            )
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 30.0),
                    child: const Text("Login",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 20.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: emailController,
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            icon: Icon(Icons.email, color: Colors.black),
                            hintText: "Email",
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        TextFormField(
                          controller: passwordController,
                          cursorColor: Colors.white,
                          obscureText: true,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            icon: Icon(Icons.lock, color: Colors.black),
                            hintText: "Password",
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40.0,
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    margin: const EdgeInsets.only(top: 15.0),
                    child: ElevatedButton(
                      onPressed: () {


                        setState(() {
                                _isLoading = true;
                              });

                              signIn(emailController.text,
                                  passwordController.text);
                            },
                      child: const Text("Sign In",
                          style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(_connectionStatus==0){
      loginUser(email, pass);
    }

    Map data = {'email': email, 'password': pass};
    var jsonResponse = null;

    var response =
        await http.post(Uri.parse('https://samrsys.rsu-sindh.gov.pk/api/login'), body: data);





    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);



      if (jsonResponse != null) {
        Root root = Root.fromJson(jsonResponse);
        registerUser(email,pass,root.accesstoken.toString());
        setState(() {
          _isLoading = false;
        });
        String tokensent=root.accesstoken.toString();
       // LoginResponse loginResponse = LoginResponse(Map<String, dynamic>? {  root.data?.name, root.data?.username, root.data?.email,root.data?.contact, root.data?.cnic,tokensent  } );

await DatabaseHelper.instance.insertSchoolData(root.data?.name, root.data?.username, root.data?.email,  root.data?.contact, root.data?.cnic, root.data?.address,tokensent);
//Future<LoginDataResponse> loginDataResponse=fetchLoginData(email, pass) ;

        Map<String, dynamic>? userinformation = await DatabaseHelper.instance.getInformationData(email);

        LoginResponse loginResponse= await LoginResponse.fromJson(userinformation);


                                      Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FormPage(loginResponse:loginResponse)),
                              );

      }
    } else {
      _showMyDialog(response.body);
      loginUser(email, pass);
      setState(() {
        _isLoading = false;
      });

      print(response.body);



    }
  }

  void registerUser(String username, String password,String accessToken) async {
    int id = await DatabaseHelper.instance.insertUser({
      DatabaseHelper.columnName: username,
      DatabaseHelper.columnPassword: password,
      DatabaseHelper.columnaccessToken: accessToken,
    });
    if (id != null) {
      // Registration successful
      print('User registered successfully');
    } else {
      // Registration failed
      print('Failed to register user');
    }
  }

  void loginUser(String username, String password) async {
    Map<String, dynamic>? user = await DatabaseHelper.instance.getUser(username);
    Map<String, dynamic>? userinformation = await DatabaseHelper.instance.getInformationData(username);
    LoginResponse loginResponse= LoginResponse.fromJson(userinformation);
    if (user != null && user[DatabaseHelper.columnPassword] == password) {
      // Login successful
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FormPage(loginResponse: loginResponse,)),
      );
    } else {
      // Login failed
      print('Login failed');
    }
  }


  Future<void> _showMyDialog(String reason) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Login Has been Failed'), // Here's a static text.
                Text('Reason: $reason'), // Here you insert the dynamic string.
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


  Future<LoginDataResponse> fetchLoginData(String email, pass) async {
    Map data = {'email': email, 'password': pass};
    final response = await http.post(
        Uri.parse('https://samrsys.rsu-sindh.gov.pk/api/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:jsonEncode(<String, String>{
          'email': email,
          'password': pass,
        }),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      return LoginDataResponse.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load login data');
    }
  }

  Future<void> _checkInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() => _connectionStatus = 1);
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() => _connectionStatus = 1);
    } else {
      setState(() => _connectionStatus = 0);
    }
  }

}
