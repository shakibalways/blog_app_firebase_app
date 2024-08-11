import 'dart:io';
import 'package:blog_app_with_firebase/golobal_wieght/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool showSpinner = false;
  final postRef = FirebaseDatabase.instance.ref().child("Posts");
  // firebase_storage.FirebaseStorage storage =
  //     firebase_storage.FirebaseStorage.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  File? image;
  final picker = ImagePicker();
  TextEditingController titleController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  Future getCameraImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print("No Image Selected");
      }
    });
  }

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print("No Image Selected");
      }
    });
  }

  void dialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Container(
              height: 120,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      getCameraImage();
                      Navigator.pop(context);
                    },
                    child: const ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: Text("Camera"),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      getImageGallery();
                      Navigator.pop(context);
                    },
                    child: const ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text("Gallery"),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text("Upload Blog"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    dialog(context);
                  },
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .2,
                      width: MediaQuery.of(context).size.height * 1,
                      child: image != null
                          ? ClipRRect(
                              child: Image.file(
                                image!.absolute,
                                height: 100,
                                width: 100,
                                fit: BoxFit.fill,
                              ),
                            )
                          : Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.pink,
                                size: 40,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: "title",
                        hintText: "Enter Post Title",
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal),
                        labelStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: discriptionController,
                      minLines: 1,
                      maxLines: 5,
                      maxLength: 200,
                      decoration: const InputDecoration(
                        labelText: "discription",
                        hintText: "Enter Your Discription",
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal),
                        labelStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RoundButton(
                        title: 'Upload',
                        onPress: () async {
                          setState(() {
                            showSpinner = true;
                          });

                          try {
                            int date = DateTime.now().millisecondsSinceEpoch;
                            Reference refs = FirebaseStorage.instance
                                .ref("/DailyBlogApp$date");
                            UploadTask uploadTask =
                                refs.putFile(image!.absolute);
                            await Future.value(uploadTask);
                            var newUrl = await refs.getDownloadURL();
                            final User? user = auth.currentUser;
                            postRef
                                .child("Post Last")
                                .child(date.toString())
                                .set({
                              'pId': date.toString(),
                              'pImage': newUrl.toString(),
                              'pTime': date.toString(),
                              'pTitle': titleController.text.toString(),
                              'pDiscription':
                                  discriptionController.text.toString(),
                              'pEmail': user!.email.toString(),
                              'uId': user.uid.toString(),
                            }).then((value) {
                              toastMessage("Post Publish");
                              setState(() {
                                showSpinner = false;
                              });
                            }).onError((error, stackTrac) {
                              toastMessage(error.toString());
                              setState(() {
                                showSpinner = false;
                              });
                            });
                          } catch (e) {
                            setState(() {
                              showSpinner = false;
                            });
                            toastMessage(e.toString());
                          }
                        },
                        color: Colors.deepOrange)
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showInSnackber() {}

  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 10,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
