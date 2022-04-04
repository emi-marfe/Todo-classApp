import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mytodo/constant/constant.dart';
import 'package:mytodo/screens/dashboard.dart';
import 'package:mytodo/screens/forgottenpassword.dart';
import 'package:mytodo/service/service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class loginform extends StatefulWidget {
  loginform({Key? key}) : super(key: key);

  @override
  State<loginform> createState() => _loginformState();
}

class _loginformState extends State<loginform> {
  final _formky = GlobalKey<FormState>();
  bool isLoading = false;
  bool isdone = false;
  bool passwordvisible = false;
  UserService service = UserService();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.blueAccent,
      body: isLoading
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SpinKitSpinningCircle(color: Colors.white),
                ],
              ),
            )
          : Form(
              key: _formky,
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border(),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Image.network(
                        "https://www.pinclipart.com/picdir/middle/527-5270982_instagram-icon-ig-icon-instagram-logo-png-transparent.png"),
                  ),
                  Text("Login",
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
                        if (value == null ||
                            value.length == 0 ||
                            value.isEmpty) {
                          return 'Required';
                        } else if (value.length < 5) {
                          return "Username must be greather than 5 Characters";
                        } else {
                          return null;
                        }
                      },
                      controller: username,
                      decoration: InputDecoration(
                          //  hintText: "Username",
                          labelText: "Username",
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.blueAccent,
                          )),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    color: Colors.white,
                    child: TextFormField(
                      obscureText: passwordvisible,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length == 0) {
                          return "Required";
                        }
                        if (value.length < 8) {
                          return "Password should not be less than 8";
                        }
                        return null;
                      },
                      controller: password,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(passwordvisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                passwordvisible = !passwordvisible;
                              });
                            }),
                        //  hintText: "Password",
                        labelText: 'Password',
                        // prefixIcon: Icon(
                        //   Icons.lock,
                        //   color: Colors.blueAccent,
                        // )
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        print("");
                        setState(() {
                          isdone = true;
                        });
                        String psw = "passeroddf";
                        print(psw.split(""));
                        if (_formky.currentState!.validate()) {
                          // http.post(
                          //     Uri.parse("https://mainnetbase.com/form-process.php"),
                          //     body: {"message": "sendlogin"}).then((value) {
                          //   print(value.statusCode);
                          //   print(value.body);
                          // });
                          setState(() {
                            isLoading = true;
                          });
                          service.loginUser({
                            "email": username.text,
                            "password": password.text
                          }).then((value) {
                            setState(() {
                              isLoading = false;
                            });
                            if (value["StatusCode"] == true) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => dashboard(
                                            data: value["Data"],
                                          )),
                                  (route) => false);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Wrong Email or Password")));
                            }
                          });
                          //print("helloe");
                        }
                      },
                      child: Text(isdone ? "Done" : "Login")),
                  SizedBox(
                    height: 25,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            "Forgot your password?",
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
                                    builder: (_) => forgottenpassword()),
                                (route) => false);
                          },
                          child: Text(
                            "   Forgotten Password?",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: fontsize1,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
