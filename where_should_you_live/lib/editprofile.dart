import 'dart:io';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'imagepicker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _image;

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

  Future getImage(BuildContext context) async {
    var img1 = await FilePicker.showImagePickerDialog(context, Platform.isIOS);

    if (img1 != null) {
      setState(() {
        _image = img1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.appPurpleColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Edit Profile"),
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
              
            ),
          ],
        ),
      ),
    );
  }
}
