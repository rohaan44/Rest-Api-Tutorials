import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WithoutModelList extends StatefulWidget {
  const WithoutModelList({super.key});

  @override
  State<WithoutModelList> createState() => _WithoutModelListState();
}

class _WithoutModelListState extends State<WithoutModelList> {

  var data;
  Future<void> getPost()async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if (response.statusCode==200) {
      data = jsonDecode(response.body.toString());
    } else {
      
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
Expanded(child: FutureBuilder(future: getPost(), builder: ((context, snapshot) {
if (snapshot.connectionState==ConnectionState.waiting) {
  return Center(child: CircularProgressIndicator(),);
} else {
  return ListView.builder(itemCount: data.length ,itemBuilder: (context,index){
return Card(
  child: Column(
    children: [
      ReusableRow(title: "name", value: data[index]['name'].toString()),
        ReusableRow(title: "username", value: data[index]['username'].toString()),
          ReusableRow(title: "email", value: data[index]['email'].toString()),
            ReusableRow(title: "city", value: data[index]['address']['city'].toString()),
            ReusableRow(title: "Geo Lat", value: data[index]['address']['geo']['lat'].toString())
    ],
  ),
);
  }); 
}
 
})))
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