import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImgPicker extends StatefulWidget {
  const ImgPicker({super.key});
  @override
  State<ImgPicker> createState() => _ImgPickerState();
}

class _ImgPickerState extends State<ImgPicker> {
  File? image;
  bool spinner = false;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      File(pickedFile.path);
      setState(() {});
    } else {
      print("There is no image");
    }
  }

  Future uploadImage() async {
    setState(() {
      spinner = true;
    });

    var stream = http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();
    var uri = Uri.parse("https://fakestoreapi.com/products");
    var request = new http.MultipartRequest('POST', uri);
    request.fields['title'] = "Static title";
    var multipart = new http.MultipartFile('image', stream, length);
    request.files.add(multipart);
    var response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        spinner = false;
      });
      print("Image Uploaded");
    } else {
      setState(() {
        spinner = false;
      });
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: spinner,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              getImage();
            },
            child: Container(
              child: image == null
                  ? Center(
                      child: Text("Picked Image First"),
                    )
                  : Container(
                      child: Image.file(
                        File(image!.path).absolute,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            height: 45,
            width: 300,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent),
                onPressed: () {
                  uploadImage();
                },
                child: Text("Upload Image")),
          )
        ],
      ),
    );
  }
}
