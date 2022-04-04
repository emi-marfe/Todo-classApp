import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mytodo/constant/constant.dart';
import 'package:mytodo/screens/loginform.dart';

class login extends StatelessWidget {
  const login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 10), () {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => loginform()), (route) => false);
    });
    Size screensize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => loginform()), (route) => false);
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
            height: screensize.height,
            width: screensize.width,
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 100, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(fontSize: fontsize, color: Colors.white),
                    ),
                    Text(
                      "Login and start creating your next task",
                      style:
                          TextStyle(fontSize: fontsize1, color: Colors.white),
                    ),
                    SizedBox(
                      height: 25,
                      child: Row(
                        children: [
                          Text(
                            "Do you have an account?",
                            style: TextStyle(
                                fontSize: fontsize1, color: Colors.white),
                          ),
                          GestureDetector(
                            child: Text(
                              " Signup",
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
