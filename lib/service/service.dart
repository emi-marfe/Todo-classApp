import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mytodo/models/task.dart';

class UserService {
  final regUser = "https://api-nodejs-todolist.herokuapp.com/user/register";

  Future RegisterUser(Map<String, dynamic> body) async {
    http
        .post(Uri.parse(regUser),
            headers: {"Content-Type": "application/json"},
            body: json.encode(body))
        .then((res) {
      print(res.statusCode);
      print(res.body);
    });
  }

  final logUser = "https://api-nodejs-todolist.herokuapp.com/user/login";
  Future<Map<String, dynamic>> loginUser(Map<String, dynamic> body) async {
    // final response = await http.post();
    // if

    return http
        .post(Uri.parse(logUser),
            headers: {"Content-Type": "application/json"},
            body: json.encode(body))
        .then((response) {
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 400) {
        return {"StatusCode": false};
      } else if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        print(data);
        print(data["user"]["email"]);
        print(data["token"]);
        return {
          "StatusCode": true,
          "Data": {"UserEmail": data["user"]["email"], "Token": data["token"]}
        };
      }
      return {"StatusCode": false};
    });
  }

  Future<bool> addNewTask(
      {required String description, required String token}) async {
    return http
        .post(Uri.parse("https://api-nodejs-todolist.herokuapp.com/task"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token"
            },
            body: json.encode({"description": description}))
        .then((res) {
      if (res.statusCode == 201) {
        return true;
      }
      return false;
    });
  }

  Future<List<Task>> getAllTask({required String token}) async {
    return http.get(
      Uri.parse("https://api-nodejs-todolist.herokuapp.com/task"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    ).then((res) {
      print(res.statusCode);
      print(res.body);

      if (res.statusCode == 200) {
        final ss = jsonDecode(res.body) as Map<String, dynamic>;

        Iterable array = ss["data"];

        return List<Task>.from(array.map((e) => Task.fromJson(e)));
      }
      return [];
    });
  }

  //get complete
  final completedtask = "https://api-nodejs-todolist.herokuapp.com/task";
  Future Getcompleted({required String token, required String Id}) async {
    // final response = await http.post();
    // if

    return http
        .put(Uri.parse(completedtask + "/$Id"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token"
            },
            body: json.encode({"completed": true}))
        .then((response) {
      print(response.statusCode);
      print(response.body);
    });
  }
}
