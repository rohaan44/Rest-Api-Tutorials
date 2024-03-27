import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomHome extends StatefulWidget {
  const CustomHome({super.key});

  @override
  State<CustomHome> createState() => _CustomHomeState();
}

class _CustomHomeState extends State<CustomHome> {
  List<CustomModel> customList = [];
  Future<List<CustomModel>> getPhotos() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    final data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        CustomModel customModel = CustomModel(title: i['title'], url: i['url'],id: i['id']);
        customList.add(customModel);
      }
    return customList;
    }
     else {
      return customList;
    }
  }

 @override
Widget build(BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: FutureBuilder<List<CustomModel>>(
          future: getPhotos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data![index].url),
                    ),
                    title: Text(snapshot.data![index].title),
                    subtitle: Text(snapshot.data![index].id.toString()),
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

class CustomModel {
  String title;
  String url;
  int id;
  CustomModel({required this.title, required this.url, required this.id});
}
