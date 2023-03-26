import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/doctorServices.dart';
import '../../utils/colors.dart';
import '../../widgets/common/tex_field_field.dart';
import '../../widgets/toastMessage.dart';
import 'doctorsHome.dart';

class DoctorUpdate extends StatefulWidget {
  final String id;
  final String name;
  final String special;
  final String email;
  final String phone;
  final String imageUrl;

  const DoctorUpdate({
    Key? key,
    required this.id,
    required this.name,
    required this.special,
    required this.phone,
    required this.email,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<DoctorUpdate> createState() => _DoctorUpdateState();
}

class _DoctorUpdateState extends State<DoctorUpdate> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _splController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _splController.text = widget.special;
    _emailController.text = widget.email;
    _phoneController.text = widget.phone;
    image = File(widget.imageUrl);
  }

  late File image;
  bool isPicked = false;
  late String prof_url;
  late bool _isLoading;

  @override
  Widget build(BuildContext context) {
    _isLoading = false;
    prof_url = widget.imageUrl;


    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Doctors"),
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
                            Image.file(image)
                                :
                            widget.imageUrl.isNotEmpty ?
                            Image(image:NetworkImage(prof_url))
                                :
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
                      _isLoading = true;
                      if(isPicked == true) {
                        await DoctorService().deleteImage(prof_url);
                        prof_url = await DoctorService().uploadImage(image);
                        setState(() {});
                      }

                      String res = await DoctorService().updateDoctor(
                        docid: widget.id,
                        name: _nameController.text,
                        speciality: _splController.text,
                        email: _emailController.text,
                        phone: _phoneController.text,
                        photoUrl: prof_url,
                      );
                      if (res == 'success') {
                        toastMessage(context,"Doctor Updated");
                        _isLoading  = false;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DoctorsHome()),
                        );
                      }
                      _isLoading  = false;
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
                              'Update Doctor',
                              style: GoogleFonts.urbanist(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () async {
                      _isLoading = true;
                      AlertDialog(
                        title: Text("Delete Doctor"),
                        content: Text("Are you want to delete the doctor?"),
                        actions: [

                        ],
                      );
                        await DoctorService().deleteImage(prof_url);
                      String res = await DoctorService().deleteDoctor(
                        docid: widget.id,
                      );
                      if (res == 'success') {
                        toastMessage(context,"Doctor Deleted");
                        _isLoading  = false;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DoctorsHome()),
                        );
                      }
                      _isLoading  = false;
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        color: redIconColor,
                      ),
                      child: _isLoading
                          ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                          : Text(
                        'Delete Doctor',
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
        print(pickedFile.path);
        setState(() =>{isPicked = true, prof_url=""});
      }
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

}
