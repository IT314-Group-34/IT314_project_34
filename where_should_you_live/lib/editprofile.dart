import 'dart:io';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'imagepicker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/user_model.dart';
import 'neighborhood_details.dart';

class EditProfilePage extends StatefulWidget {
  Map<String, dynamic>? objUserData;
  String? email_ID;
  EditProfilePage({super.key, this.objUserData, required this.email_ID});
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _image;

  String? _email;
  TextEditingController nameController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController ethnicityController = TextEditingController();
  TextEditingController religionController = TextEditingController();

  final FocusNode occupationFocusNode = FocusNode();
  final FocusNode ageFocusNode = FocusNode();
  final FocusNode heightFocusNode = FocusNode();
  final FocusNode ethnicityFocusNode = FocusNode();
  final FocusNode religionFocusNode = FocusNode();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future getImage(BuildContext context) async {
    var img1 = await FilePicker.showImagePickerDialog(context, Platform.isIOS);

    if (img1 != null) {
      setState(() {
        _image = img1;
      });
    }
  }

  Future<void> addUserToFireStore() async {
    await FirebaseUserRepository().addUser(User(
        firstName: nameController.text,
        email: _email!,
        lastName: widget.objUserData?["lastName"],
        occupation: occupationController.text,
        age: int.parse(ageController.text),
        height: double.parse(heightController.text),
        ethnicity: ethnicityController.text,
        religion: religionController.text,
        wishlist: widget.objUserData?["wishlist"] == null
            ? ''
            : widget.objUserData?["wishlist"]));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User data added successfully')),
    );
  }

  Future<void> updateUserToFireStore() async {
    await FirebaseUserRepository().updateUser(User(
        firstName: nameController.text,
        email: _email!,
        lastName: widget.objUserData?["lastName"],
        occupation: occupationController.text,
        age: int.parse(ageController.text),
        height: double.parse(heightController.text),
        ethnicity: ethnicityController.text,
        religion: religionController.text,
        wishlist: widget.objUserData?["wishlist"] == null
            ? ''
            : widget.objUserData?["wishlist"]));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User data updated successfully')),
    );
  }

  @override
  void initState() {
    super.initState();
    _email = widget.email_ID;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.objUserData != null) {
      setState(() {
        nameController.text = widget.objUserData!["name"];
        occupationController.text = widget.objUserData!["occupation"];
        ageController.text = widget.objUserData!["age"].toString();
        heightController.text = widget.objUserData!["height"].toString();
        ethnicityController.text = widget.objUserData!["ethnicity"];
        religionController.text = widget.objUserData!["religion"];
      });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.appPurpleColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(_email == null ? 'No email' : '$_email'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            _image == null
                ? MaterialButton(
                    onPressed: () {
                      getImage(context);
                    },
                    color: Constants.appLightPurpleColor,
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(30),
                    shape: const CircleBorder(),
                    child: const Icon(Icons.camera_alt,
                        size: 80, color: Constants.appPurpleColor),
                  )
                : CircleAvatar(
                    radius: 80,
                    backgroundImage: Image.file(
                      _image!,
                      fit: BoxFit.fill,
                      height: 80,
                      width: 80,
                    ).image,
                  ),
            const SizedBox(
              height: 30.0,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Name"),
              controller: nameController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              focusNode: occupationFocusNode,
            ),
            const SizedBox(
              height: 30.0,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Occupation"),
              controller: occupationController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              focusNode: ageFocusNode,
            ),
            const SizedBox(
              height: 30.0,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Age"),
              controller: ageController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: heightFocusNode,
            ),
            const SizedBox(
              height: 30.0,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Height"),
              controller: heightController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: ethnicityFocusNode,
            ),
            const SizedBox(
              height: 30.0,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Ethnicity"),
              controller: ethnicityController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              focusNode: religionFocusNode,
            ),
            const SizedBox(
              height: 30.0,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Religion"),
              controller: religionController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 50.0,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Map<String, dynamic> usersData = {
                    "profile": _image?.path,
                    "name": nameController.text,
                    "occupation": occupationController.text,
                    "age": int.parse(ageController.text),
                    "height": double.parse(heightController.text),
                    "ethnicity": ethnicityController.text,
                    "religion": religionController.text,
                  };

                  if (_email == null) {
                    addUserToFireStore();
                  } else {
                    updateUserToFireStore();
                  }

                  Navigator.of(context).pop(usersData);
                },
                style: ElevatedButton.styleFrom(
                    elevation: 10.0,
                    backgroundColor: Constants.appLightPurpleColor,
                    foregroundColor: Constants.appPurpleColor,
                    textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Constants.appPurpleColor)),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
