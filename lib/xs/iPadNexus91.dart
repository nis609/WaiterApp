import 'package:flutter/material.dart';

class iPadNexus91 extends StatelessWidget {
  iPadNexus91({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1473e6),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(583.0, 134.0),
            child: Container(
              width: 361.0,
              height: 446.0,
              decoration: BoxDecoration(
                color: const Color(0xff1473e6),
                border: Border.all(width: 5.0, color: const Color(0xfffffbfb)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(625.0, 367.0),
            child: Container(
              width: 279.0,
              height: 44.0,
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(625.0, 322.0),
            child: Text(
              'Password',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 25,
                color: const Color(0xfff1ebeb),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(642.0, 479.0),
            child: Container(
              width: 228.0,
              height: 63.0,
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(718.0, 494.0),
            child: Text(
              'Login',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 25,
                color: const Color(0xff1473e6),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(609.0, 112.0),
            child: Container(
              width: 62.0,
              height: 45.0,
              decoration: BoxDecoration(
                color: const Color(0xff1473e6),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(610.0, 115.0),
            child: Text(
              'Login',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 25,
                color: const Color(0xfff1ebeb),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(625.0, 252.0),
            child: Container(
              width: 279.0,
              height: 44.0,
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(625.0, 208.0),
            child: Text(
              'Username',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 25,
                color: const Color(0xfff1ebeb),
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
