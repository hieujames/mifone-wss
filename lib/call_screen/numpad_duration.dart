import 'package:flutter/material.dart';

// KeyPad widget
// This widget is reusable and its buttons are customizable (color, size)
class NumPadDuration extends StatelessWidget {
  final double buttonSize;
  final Color buttonColor;
  final Color iconColor;
  final TextEditingController controller;
  final Function delete;
  final Function onSubmit;

  const NumPadDuration({
    Key? key,
    this.buttonSize = 70,
    this.buttonColor = Colors.indigo,
    this.iconColor = Colors.amber,
    required this.delete,
    required this.onSubmit,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NumberButton(
                number: 1.toString(),
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 4.toString(),
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 7.toString(),
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: '*',
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
            ],
          ),
          Column(
            children: [
              NumberButton(
                number: 2.toString(),
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 5.toString(),
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 8.toString(),
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 0.toString(),
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              GestureDetector(
                onTap: () {
                  delete();
                },
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Ẩn',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              /* SizedBox(
                width: 50,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      onSubmit();
                    },
                    icon: Image.asset(
                      'assets/image/hangup.png',
                      color: Colors.white,
                    ),
                    color: Colors.white,
                  ),
                ),
              ), */
            ],
          ),
          Column(
            children: [
              NumberButton(
                number: 3.toString(),
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 6.toString(),
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 9.toString(),
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: '#',
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// define NumberButton widget
// its shape is round
class NumberButton extends StatelessWidget {
  final String number;
  final double size;
  final Color color;
  final TextEditingController controller;

  const NumberButton({
    Key? key,
    required this.number,
    required this.size,
    required this.color,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: SizedBox(
        width: size,
        height: size,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size / 2),
            ),
          ),
          onPressed: () {
            //  MifoneSdkFlutter.instance.handleCallDtmf(number);
            print(number.toString() + '-----');
          },
          child: Center(
            child: Text(
              number.toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }
}
