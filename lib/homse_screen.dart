import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:project/models/postmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> postList = [];
  Future<List<PostModel>> getPost() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    final data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: FutureBuilder(
                future: getPost(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Waiting");
                  } else {
                    return ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context,index){
                      return Card(
                        child: Column(
                      children: [
                        Text(postList[index].title.toString()),
                      ],
                    ));
                    });
                  }
                }))
      ],
    );
  }
}
