
import 'dart:io';
import 'dart:math';

import 'package:appointment/services/doctorServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/colors.dart';
import '../../widgets/common/tex_field_field.dart';
import '../../widgets/toastMessage.dart';
import 'doctorsHome.dart';

class AddDoctor extends StatefulWidget {
  const AddDoctor({Key? key}) : super(key: key);

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _splController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  late File image;
  bool isPicked = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    bool _isLoading = false;
    String prof_url = "test";


    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Doctors"),
        backgroundColor: primaryColor,
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Image(image: image)
                  const SizedBox(height: 30),
                  Stack(
                    children: [
                      SizedBox(
                      width:240,
                      height: 240,
                      child: ClipRRect(
                        borderRadius:BorderRadius.circular(200),
                        child: isPicked ?
                        Image.file(
                          image,
                        )    :
                        const Image(
                          image: NetworkImage("https://alumni.engineering.utoronto.ca/files/2022/05/Avatar-Placeholder-400x400-1.jpg"),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: primaryColor,
                        child: IconButton(
                          iconSize: 48,
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
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ]
                  ),
                  const SizedBox(height: 30),
                  TextFieldInput(
                    textEditingController: _nameController,
                    label: 'Name',
                    hintText: "Enter doctor's name",
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 30),
                  TextFieldInput(
                    textEditingController: _splController,
                    label: 'Speciality',
                    hintText: "Enter doctor's speciality",
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 30),
                  TextFieldInput(
                    textEditingController: _emailController,
                    label: 'Email',
                    isEmail: true,
                    hintText: "Enter doctor's email",
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 30),
                  TextFieldInput(
                    textEditingController: _phoneController,
                    label: 'Phone',
                    hintText: "Enter doctor's phone",
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () async {
                      prof_url = await DoctorService().uploadImage(image);
                      String res = await DoctorService().addDoctor(
                        name: _nameController.text,
                        speciality: _splController.text,
                        email: _emailController.text,
                        phone: _phoneController.text,
                        photoUrl: prof_url,
                      );
                      if (res == 'success') {
                        toastMessage(context,"Doctor Added");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DoctorsHome()),
                        );
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        color: primaryColor,
                      ),
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Create Doctor',
                              style: GoogleFonts.urbanist(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          )),
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
