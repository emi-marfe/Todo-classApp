import 'package:flutter/material.dart';
import 'package:mytodo/constant/constant.dart';
import 'package:mytodo/screens/dashboard.dart';
import 'package:mytodo/screens/forgottenpassword.dart';
import 'package:mytodo/screens/login.dart';
import 'package:mytodo/screens/loginform.dart';
import 'package:mytodo/service/service.dart';

class signupscreen extends StatelessWidget {
  const signupscreen({Key? key, String? message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formky = GlobalKey<FormState>();
    bool isdone = false;

    UserService service = UserService();

    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.blueAccent,
      body: Form(
        key: _formky,
        child: Column(
          children: [
            SizedBox(
              height: 250,
            ),
            Text("Register",
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
                    return 'Required';
                  } else if (value.length < 5) {
                    return "Username must be greather than 5 Characters";
                  } else {
                    return null;
                  }
                },
                controller: username,
                decoration: InputDecoration(
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
                validator: (value) {
                  if (value == null || value.isEmpty || value.length == 0) {
                    return "Required";
                  }
                  if (value.length < 8) {
                    return "Password should not be less than 8";
                  }
                  return null;
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
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  print("");

                  String psw = "passeroddf";
                  print(psw.split(""));
                  if (_formky.currentState!.validate()) {
                    {
                      service.RegisterUser({
                        "name": username.text,
                        "email": username.text,
                        "password": password.text,
                        "age": 20
                      });
                    }
                  }
                },
                child: Text(isdone ? "Done" : "Register")),
            SizedBox(
              height: 25,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      "Already have an account?",
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
                              builder: (_) => dashboard(
                                    data: {},
                                  )),
                          (route) => false);
                    },
                    child: Text(
                      "   Login",
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
