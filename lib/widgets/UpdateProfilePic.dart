import 'dart:io';
import 'package:contact/Models/UserModel.dart';
import 'package:contact/Provider/UserProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../main.dart';

class UpdateProfilePic extends StatefulWidget {
  @override
  _UpdateProfilePicState createState() => _UpdateProfilePicState();
}

class _UpdateProfilePicState extends State<UpdateProfilePic> {
  final ImagePicker _imagePicker = ImagePicker();
  UserModel user;
  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context).user;
    return GestureDetector(
      onTap: () async {
        await _selectImage();
      },
      child: Column(
        children: [
          Center(
            child: Icon(
              Icons.camera_alt_outlined,
              color: Color(0xffDADADA),
            ),
          ),
          Center(
            child: Container(
              width: 60.w,
              margin: EdgeInsets.only(top: 5),
              child: Text(
                "Edit Profile Picture",
                overflow: TextOverflow.ellipsis,
                style: theme.text20boldPrimary,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectImage() async {
    var picture = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (picture != null) {
      // File croppedPic = await ImageCropper.cropImage(
      //   sourcePath: picture.path,
      //   aspectRatio: CropAspectRatio(
      //     ratioX: 1,
      //     ratioY: 1,
      //   ),
      //   compressQuality: 100,
      //   maxHeight: 1000,
      //   maxWidth: 1000,
      //   compressFormat: ImageCompressFormat.png,
      // );
      File file = new File(picture.path);
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('profilePic/${FirebaseAuth.instance.currentUser.uid}');
      UploadTask uploadTask = storageReference.putFile(file);
      await uploadTask.whenComplete(() => print('File Uploaded'));

      storageReference.getDownloadURL().then((fileURL) {
        print('url ' + fileURL);
        user?.photoURL = fileURL;
        setState(() {
          user.photoURL = fileURL;

          Provider.of<UserProvider>(context, listen: false)
              .updateUser(user, context);
        });
      });
    }
  }
}
