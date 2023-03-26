import 'dart:io';
import 'package:appointment/screens/userScreens/userHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/user_model.dart';
import '../../services/auth_services.dart';
import '../../utils/colors.dart';
import '../../widgets/common/tex_field_field.dart';
import '../../widgets/toastMessage.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

const String uProfileImage = "https://firebasestorage.googleapis.com/v0/b/ctsea1.appspot.com/o/doctors%2Favatar.jpg?alt=media&token=7880ba93-e7ad-45cb-bb80-6d22fd65ac30";

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  User? _user;
  late File image;
  bool isPicked = false;
  late String prof_url;
  late String email;
  late String role;
  late bool _isLoading;
  late String docid;
  late String name;
  late int age;

  void userdetails() async {
    User user = await AuthServices().getUserDetails();
    print('name');
    setState(() {
      _user = user;
      docid=_user?.uid as String;
      name=_user?.name as String;
      age=_user?.age as int;
      prof_url=_user?.photoUrl as String;
      email=_user?.email as String;
      role=_user?.role as String;
    });
  }

  @override
  void initState() {
    super.initState();
    userdetails();
  }

  @override
  Widget build(BuildContext context) {
    _nameController.text = name;
    _ageController.text = age.toString();
    return Scaffold(
        appBar: AppBar(
            backgroundColor: secondaryColor,
            title: Row(
              children: [
                SizedBox(width: 10),
                Text(
                  'Profile Update',
                  style: GoogleFonts.urbanist(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.1,
                      color: primaryColor),
                ),
              ],
            ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children:  [
                const SizedBox(height: 30),
                // SizedBox(
                //   width: 120,
                //   height: 120,
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(220),
                //     child: Image.network(uProfileImage,fit: BoxFit.cover,),
                //   ),
                // ),

                Stack(
                    children: [
                      SizedBox(
                        width:120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius:BorderRadius.circular(200),
                          child: isPicked ?
                          Image.file(image)
                              :
                          prof_url.isNotEmpty ?
                          Image(image:NetworkImage(prof_url))
                               :
                          const Image(
                            image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/ctsea1.appspot.com/o/doctors%2Favatar.jpg?alt=media&token=7880ba93-e7ad-45cb-bb80-6d22fd65ac30"),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: primaryColor,
                          child: IconButton(
                            iconSize: 24,
                            style: ButtonStyle(
                              // borderRadius: BorderRadius.circular(100),
                              foregroundColor: MaterialStateProperty.all(primaryColor),
                            ),
                            onPressed: () {
                              pickImage();
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ]
                ),


                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 0),
                  child: TextFieldInput(
                    textEditingController: _nameController,
                    label: 'Name',
                    hintText: "Enter user name",
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 0, 50.0, 0),
                  child: TextFieldInput(
                    textEditingController: _ageController,
                    label: 'Age',
                    hintText: "Enter age",
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(height: 90),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () async {
                      // final isFormValid = _formKey.currentState!.validate();
                      // if (isFormValid == false) {
                      //   return;
                      // }

                      _isLoading = true;
                      if(isPicked == true) {
                        if(prof_url.isNotEmpty) {
                          await AuthServices().deleteImage(prof_url);
                        }
                        prof_url = await AuthServices().uploadImage(image);
                        setState(() {});
                      }

                      String res = await AuthServices().updateUser(
                        docid: docid,
                        name: _nameController.text,
                        age: int.parse(_ageController.text),
                        email: email,
                        role: role,
                        photoUrl: prof_url,
                      );
                      if (res == 'success') {
                        toastMessage(context,"User Updated");
                        _isLoading  = false;
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => userHome()));

                      }
                      _isLoading  = false;
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor, shape: StadiumBorder()
                    ),
                    child: const Text('Update',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
  Future pickImage() async {

    try {
      final ImagePicker _picker = ImagePicker();
      XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if(pickedFile != null){
        image = File(pickedFile.path);
        setState(() =>isPicked = true);
      }
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }
}
