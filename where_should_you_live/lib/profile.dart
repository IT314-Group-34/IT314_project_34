import 'dart:io';
import 'package:flutter/material.dart';
import 'editprofile.dart';
import 'constants.dart';
import 'imagepicker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? usersEditedData;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: users.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data?.docs.isNotEmpty ?? false) {
            QueryDocumentSnapshot<Object?>? objUser = snapshot.data!.docs.last;
            usersEditedData = {};
            usersEditedData!["name"] = objUser["firstName"];
            usersEditedData!["occupation"] = objUser["occupation"];
            usersEditedData!["age"] = objUser["age"];
            usersEditedData!["height"] = objUser["height"];
            usersEditedData!["ethnicity"] = objUser["ethnicity"];
            usersEditedData!["religion"] = objUser["religion"];
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Constants.appPurpleColor,
              title: const Text("Profile"),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Constants.appLightPurpleColor,
              onPressed: () async {
                final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(
                        objUserData: usersEditedData,
                      ),
                    ));
                setState(() {
                  usersEditedData = result;
                });
              },
              label: const Text('Edit',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Constants.appPurpleColor)),
              icon: const Icon(
                Icons.edit,
                color: Constants.appPurpleColor,
                size: 20,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  usersEditedData == null || usersEditedData!["profile"] == null
                      ? MaterialButton(
                          onPressed: () {},
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
                            File(usersEditedData!["profile"]!),
                            fit: BoxFit.fill,
                            height: 80,
                            width: 80,
                          ).image,
                        ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    usersEditedData == null || usersEditedData!["name"] == ""
                        ? 'Name'
                        : '${usersEditedData!["name"]}',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Divider(thickness: 1.5),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Occupation',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Age',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Height',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Ethnicity',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Religion:',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          children: const [
                            Text(
                              ':',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              ':',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              ':',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              ':',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              ':',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              usersEditedData == null ||
                                      usersEditedData!["occupation"] == ""
                                  ? ""
                                  : '${usersEditedData!["occupation"]}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              usersEditedData == null ||
                                      usersEditedData!["age"] == ""
                                  ? ""
                                  : '${usersEditedData!["age"]}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              usersEditedData == null ||
                                      usersEditedData!["height"] == ""
                                  ? ""
                                  : '${usersEditedData!["height"]}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              usersEditedData == null ||
                                      usersEditedData!["ethnicity"] == ""
                                  ? ""
                                  : '${usersEditedData!["ethnicity"]}',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              usersEditedData == null ||
                                      usersEditedData!["religion"] == ""
                                  ? ""
                                  : '${usersEditedData!["religion"]}',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
