import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sindhsupportunit/widgets/custom_text_input.dart';

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
      String field1Value = _textFieldController1.text;
      String field2Value = _textFieldController2.text;
      String field3Value = _textFieldController3.text;
      String field4Value = _textFieldController4.text;
      String field5Value = _textFieldController5.text;

      // Send data to API
      try {
        var response = await http.post(
          Uri.parse('your_api_endpoint'),
          body: {
            'field1': field1Value,
            'field2': field2Value,
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
      }
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
                hintTextString: 'Enter Email',
                inputType: InputType.Email,
                enableBorder: true,
                cornerRadius: 48.0,
                maxLength: 24,
              ),
              CustomTextInput(
                textEditController:_textFieldController3,
                hintTextString: 'Enter Password',
                inputType: InputType.Password,
                enableBorder: true,
                cornerRadius: 48.0,
                maxLength: 16,
                prefixIcon: Icon(Icons.lock, color: Theme.of(context).primaryColor),
              ),
              CustomTextInput(
                textEditController:_textFieldController4,
                hintTextString: 'Enter Number',
                inputType: InputType.Number,
                enableBorder: true,
                cornerRadius: 48.0,
                maxLength: 10,
              ),
            CustomTextInput(
              textEditController:_textFieldController5,
              hintTextString: 'Enter Card Number',
              inputType: InputType.PaymentCard,
              enableBorder: true,
              cornerRadius: 48.0,
              maxLength: 10,
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
