import 'package:flutter/material.dart';
import 'package:mytodo/constant/constant.dart';
import 'package:mytodo/screens/login.dart';
import 'package:mytodo/screens/loginform.dart';
import 'package:mytodo/screens/signupscreen.dart';

class forgottenpassword extends StatelessWidget {
  const forgottenpassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController password = TextEditingController();
    final _forgotten = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.blueAccent,
      body: Form(
          key: _forgotten,
          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Text("Forgotten password",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                color: Colors.white,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.length == 0 || value.isEmpty) {
                      return 'required';
                    }
                  },
                  controller: password,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.blueAccent,
                  )),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_forgotten.currentState!.validate()) {
                    print("forgotten password");
                  }
                },
                child: Text("forgotten password"),
              ),
              SizedBox(
                height: 25,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                  child: Row(
                    children: [
                      Center(
                        child: Text(
                          "Dont have an account?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontsize1,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => signupscreen(
                                        message: 'forgotten password',
                                      )),
                              (route) => false);
                        },
                        child: Text(
                          "   Register?",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontsize1,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
