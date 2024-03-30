import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/models/user_model.dart';

class ComplexList_Custom extends StatefulWidget {
  const ComplexList_Custom({super.key});

  @override
  State<ComplexList_Custom> createState() => _ComplexList_CustomState();
}

class _ComplexList_CustomState extends State<ComplexList_Custom> {
  List<UserData> userList = [];

  Future<List<UserData>> getPost() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    final data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        userList.add(UserData.fromJson(i));
      }
      return userList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<List<UserData>>(
            future: getPost(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          
                          ReusableRow(title: "Name", value: snapshot.data![index].name),
                          ReusableRow(title: "Username", value: snapshot.data![index].username),
                          ReusableRow(title: "Email", value: snapshot.data![index].email),
                          ReusableRow(title: "City", value: snapshot.data![index].address!.city),
                          ReusableRow(title: "Geo Lat", value: snapshot.data![index].address!.geo!.lat)
                        ],
                      ),

                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}


class ReusableRow extends StatelessWidget {
  final title;
  final value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}