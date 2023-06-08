import 'package:flutter/material.dart';
import 'package:mifone_sdk_flutter/mifone_sdk_flutter.dart';

import 'call_screen/numpad.dart';
import 'call_screen/call_duration.dart';

class NumpadScreen extends StatefulWidget {
  const NumpadScreen({super.key});

  @override
  State<NumpadScreen> createState() => _NumpadScreenState();
}

class _NumpadScreenState extends State<NumpadScreen> {
  final TextEditingController _myController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MifoneSdkFlutter.instance.setConfigureAccount('token');
    //_initPhone();
  }

  /*  _initPhone() {
    _myController.text = widget.phone;
  } */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // display the entered numbers
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: 70,
              child: Center(
                  child: TextField(
                controller: _myController,
                textAlign: TextAlign.center,
                showCursor: false,
                style: const TextStyle(fontSize: 30),
                // Disable the default soft keybaord
                keyboardType: TextInputType.none,
              )),
            ),
          ),
          // implement the custom NumPad
          NumPad(
            buttonSize: 50,
            buttonColor: Color(0xffE5E5E5),
            iconColor: Color(0xff32C75A),
            controller: _myController,
            delete: () {
              if (_myController.text.isNotEmpty) {
                _myController.text = _myController.text
                    .substring(0, _myController.text.length - 1);
              }
            },
            // do something with the input numbers
            onSubmit: () {
              MifoneSdkFlutter.instance.makeCall(_myController.text);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DurationCall(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
