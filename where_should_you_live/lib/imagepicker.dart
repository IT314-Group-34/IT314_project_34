import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class FilePicker {
  static Future<File?> showImagePickerDialog(
      BuildContext _context, bool isIOS) async {
    var imgResource;

    if (isIOS) {
      imgResource = await showCupertinoModalPopup<ImageSource>(
        context: _context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: const Text('Choose Photo'),
                onPressed: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
              ),
              CupertinoActionSheetAction(
                child: const Text('Take Photo'),
                onPressed: () {
                  Navigator.pop(context, ImageSource.camera);
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDefaultAction: true,
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          );
        },
      );
    } else {
      imgResource = await showDialog<ImageSource>(
          context: _context,
          builder: (context) => AlertDialog(
                title: Text("Select the image source"),
                actions: <Widget>[
                  MaterialButton(
                    child: Text("Camera"),
                    onPressed: () => Navigator.pop(context, ImageSource.camera),
                  ),
                  MaterialButton(
                    child: Text("Gallery"),
                    onPressed: () =>
                        Navigator.pop(context, ImageSource.gallery),
                  )
                ],
              ));
    }

    if (imgResource != null) {
      ImagePicker _imagePicker = ImagePicker();
      final file = await _imagePicker.getImage(source: imgResource);
      if (file != null && file.path.isNotEmpty)
        return File(file.path);
      else {
        final LostData response = await _imagePicker.getLostData();
        if (!response.isEmpty) {
          if (response.file != null) {
            return File(response.file!.path);
          }
        }
        return File(response.file!.path);
      }
    } else
      return null;
  }

  static String getFileName(File file) {
//    print('Original path: ${file.path}');
//    String dir = path.dirname(file.path);
//    String newPath = path.join(dir, 'case01wd03id01.jpg');
//    print('NewPath: $newPath');
//    file.renameSync(newPath);

//    String dir = path.dirname(file.path);
//    String newPath = path.join(dir, 'CR_DOCUMENT.jpg');
//    file.renameSync(newPath);
    return basename(file.path);
  }
}
