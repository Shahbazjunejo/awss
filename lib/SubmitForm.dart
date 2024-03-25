import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sindhsupportunit/widgets/custom_text_input.dart';

import 'DatabaseHelper.dart';

class SubmitForm extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<SubmitForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textFieldController1 = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();
  TextEditingController _textFieldController3 = TextEditingController();
  TextEditingController _textFieldController4 = TextEditingController();
  TextEditingController _textFieldController5 = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String nameValue = _textFieldController1.text;
      String contactValue = _textFieldController2.text;
      String fathernameValue = _textFieldController3.text;
      String father_cnicValue = _textFieldController4.text;
      String emailValue = _textFieldController5.text;

      await DatabaseHelper.instance.insertStudent(nameValue, contactValue , fathernameValue, father_cnicValue, emailValue);



      // Send data to API
/*      try {
        var response = await http.post(
          Uri.parse('your_api_endpoint'),
          body: {
            'name': field1Value,
            'contact': field2Value,
            'field3': field3Value,
            'field4': field4Value,
            'field5': field5Value,
          },
        );

        // Handle response
        if (response.statusCode == 200) {
          // Data submitted successfully
          print('Data submitted successfully');
        } else {
          print('Error submitting data: ${response.body}');
        }
      } catch (error) {
        print('Network error: $error');
      }*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Screen'),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fill
            )
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextInput(
                textEditController:_textFieldController1,
                hintTextString: 'Enter User name',
                inputType: InputType.Default,
                enableBorder: true,
                themeColor: Theme.of(context).primaryColor,
                cornerRadius: 48.0,
                maxLength: 24,
                prefixIcon: Icon(Icons.person, color: Theme.of(context).primaryColor),
                textColor: Colors.black,
                errorMessage: 'User name cannot be empty',
                labelText: 'User Name',
              ),
              CustomTextInput(
                textEditController: _textFieldController2,
                hintTextString: 'Enter Contact',
                inputType: InputType.Number,
                enableBorder: true,
                cornerRadius: 48.0,
                maxLength: 12,
              ),
              CustomTextInput(
                textEditController:_textFieldController3,
                hintTextString: 'Father Name',
                inputType: InputType.Default,
                enableBorder: true,
                cornerRadius: 48.0,
                maxLength: 16,
                prefixIcon: Icon(Icons.lock, color: Theme.of(context).primaryColor),
              ),
              CustomTextInput(
                textEditController:_textFieldController4,
                hintTextString: 'Father Cnic',
                inputType: InputType.Number,
                enableBorder: true,
                cornerRadius: 48.0,
                maxLength: 20,
              ),
            CustomTextInput(
              textEditController:_textFieldController5,
              hintTextString: 'Enter Email',
              inputType: InputType.Default,
              enableBorder: true,
              cornerRadius: 48.0,
              maxLength: 30,
            ),
              SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(16),
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 253, 188, 51),
                  borderRadius: BorderRadius.circular(36),
                ),
                alignment: Alignment.center,
                child:  ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
