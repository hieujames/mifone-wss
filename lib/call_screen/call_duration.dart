import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mifone_sdk_flutter/mifone_sdk_flutter.dart';

import 'numpad_duration.dart';

class DurationCall extends StatefulWidget {
  const DurationCall({super.key});

  @override
  State<DurationCall> createState() => _DurationCallState();
}

class _DurationCallState extends State<DurationCall> {
  late DateTime startTime;
  late DateTime currentTime;
  final TextEditingController _myController = TextEditingController();
  late Timer timer = Timer(Duration.zero, () {});

  String timeText = '00:00';
  bool checkConfir = false;
  bool checkEnded = false;

//option call
  bool checkMute = false;
  bool checkSpeaker = false;
  bool checkKeyboard = false;
  @override
  void dispose() {
    timer.cancel();

    super.dispose();
  }

  var check = '';
  checkConfirm() {
    MifoneSdkFlutter.instance.setEventListener(
      (event) {
        setState(() {
          check = event.state.toString();
        });
        print('check----------------------');
        print(check);
        if (check == 'CallStateEnum.CONFIRMED') {
          // bắt máy
          setState(() {
            checkConfir = true;
            startTime = DateTime.now();
            timer = Timer.periodic(Duration(seconds: 1), (timer) {
              setState(() {
                currentTime = DateTime.now();
                Duration timeElapsed = currentTime.difference(startTime);
                timeText = formatTime(timeElapsed);
              });
            });
          });
          //không nghe máy ngắt máy
        } else if (check == 'CallStateEnum.ENDED' ||
            check == 'CallStateEnum.FAILED') {
          setState(() {
            checkEnded = true;
            if (checkEnded) return Navigator.pop(context);
          });
        }

        print(
            '----------------------------------- [TEST] ------------------------------------------');
        print(event.state.toString());
      },
    );
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    checkConfirm();
    Size sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff202023),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: sizeScreen.height * 0.1,
              ),
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xff5AB873),
                ),
                child: Center(
                    child: Text(
                  'P',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                )),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Phúc',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                checkConfir ? timeText : 'Đang gọi...',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  optionCall(
                      icon: Icon(
                        checkMute ? Icons.mic_off_outlined : Icons.mic,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        MifoneSdkFlutter.instance.handleMute();
                        setState(() {
                          checkMute = !checkMute;
                        });
                      },
                      text: 'Tắt tiếng'),
                  SizedBox(
                    height: 15,
                  ),
                  optionCall(
                      icon: Icon(
                        Icons.phone_forwarded_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                      text: 'Add call'),
                ],
              ),
              Column(
                children: [
                  optionCall(
                      icon: Icon(
                        Icons.keyboard_alt_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          checkKeyboard = true;
                          _showSimpleDialog();
                        });
                      },
                      text: 'Bàn phím'),
                  SizedBox(
                    height: 15,
                  ),
                  optionCall(
                      icon: Icon(
                        Icons.pause,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                      text: 'Hold'),
                ],
              ),
              Column(
                children: [
                  optionCall(
                      icon: Icon(
                        Icons.volume_up_outlined,
                        color: checkSpeaker ? Colors.white : Colors.grey,
                      ),
                      onPressed: () {
                        MifoneSdkFlutter.instance.handleSpeaker(checkSpeaker);
                        // _toggleSpeakerphone(checkSpeaker);
                        setState(() {
                          checkSpeaker = !checkSpeaker;
                        });
                      },
                      text: 'Loa ngoài'),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      MifoneSdkFlutter.instance.hangup();
                      Navigator.of(context).pop();
                    },
                    icon: Image.asset(
                      'assets/image/hangup.png',
                      color: Colors.white,
                    ),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget optionCall(
      {required Icon icon,
      required String text,
      required VoidCallback onPressed}) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: icon,
          iconSize: 35,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white54),
        )
      ],
    );
  }

  Future<void> _showSimpleDialog() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: Colors.transparent,
            children: <Widget>[
              NumPadDuration(
                buttonSize: 50,
                buttonColor: const Color(0xffE5E5E5),
                iconColor: Colors.red,
                controller: _myController,
                delete: () {
                  Navigator.of(context).pop();
                },
                onSubmit: () {
                  MifoneSdkFlutter.instance.hangup();
                },
              ),
            ],
          );
        });
  }
}
