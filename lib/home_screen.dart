// home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:sindhsupportunit/SubmitForm.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[

            AnimatedButton(
              height: 70,
              width: 200,
              text: 'SUBMIT',
              isReverse: true,
              selectedTextColor: Colors.black,
              transitionType: TransitionType.LEFT_TO_RIGHT,
              backgroundColor: Colors.black,
              borderColor: Colors.white,
              borderRadius: 0,
              borderWidth: 2, onPress: () {  },
            ),
            AnimatedButton(
              height: 70,
              width: 200,
              text: 'SUBMIT',
              isReverse: true,
              selectedTextColor: Colors.black,
              transitionType: TransitionType.LEFT_TO_RIGHT,
              backgroundColor: Colors.black,
              borderColor: Colors.white,
              borderRadius: 0,
              borderWidth: 2, onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SubmitForm()),
              );
            },
            ),
          ]

        )
      ),
    );
  }
}
