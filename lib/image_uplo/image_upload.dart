import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  final String? Userid;
  ImageUpload({Key? key, this.Userid}) : super(key: key);

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? _image;
  final imagePicker = ImagePicker();
  String? downloadURL;

  Future imagePickerMethod() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showSnackBar("No File selected", Duration(milliseconds: 400));
      }
    });
  }

  // Future uploadImage(File _image) async {
  // final imgId = DateTime.now().millisecondsSinceEpoch.toString();
  // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  // Reference reference = FirebaseStorage.instance
  //     .ref()
  //     .child('${widget.Userid}/images')
  //     .child("post_$imgId");

  // await reference.putFile(_image);
  // print("widget.Userid");
  // print(widget.Userid);
  // downloadURL = await reference.getDownloadURL();

  //   await firebaseFirestore
  //       .collection("users")
  //       .doc(widget.Userid)
  //       .collection("images")
  //       .add({'downloadURL': downloadURL}).whenComplete(
  //           () => showSnackBar("Image Uploaded", Duration(seconds: 2)));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Image "),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: SizedBox(
                    height: 500,
                    width: double.infinity,
                    child: Column(children: [
                      const Text("Upload Image"),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.red),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // the image that we wanted to upload
                                Expanded(
                                    child: _image == null
                                        ? const Center(
                                            child: Text("No image selected"))
                                        : Image.file(_image!)),
                                ElevatedButton(
                                    onPressed: () {
                                      imagePickerMethod();
                                    },
                                    child: const Text("Select Image")),
                                ElevatedButton(
                                    onPressed: () {
                                      if (_image != null) {
                                        // uploadImage(_image!);
                                        showSnackBar(
                                            "Image Uploaded Succesfully",
                                            Duration(milliseconds: 400));
                                      } else {
                                        showSnackBar("Select Image first",
                                            Duration(milliseconds: 400));
                                      }
                                    },
                                    child: const Text("Upload Image")),
                              ],
                            ),
                          ),
                        ),
                      )
                    ])))),
      ),
    );
  }

  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
