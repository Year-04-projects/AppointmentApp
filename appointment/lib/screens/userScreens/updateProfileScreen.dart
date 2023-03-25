import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/user_model.dart';
import '../../services/auth_services.dart';
import '../../utils/colors.dart';
import '../../widgets/common/tex_field_field.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

const String uProfileImage = "https://firebasestorage.googleapis.com/v0/b/ctsea1.appspot.com/o/doctors%2Favatar.jpg?alt=media&token=7880ba93-e7ad-45cb-bb80-6d22fd65ac30";

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  final TextEditingController _nameController = TextEditingController();

  User? _user;

  String name="",email="";

  void userdetails() async {
    User user = await AuthServices().getUserDetails();
    print('name');
    setState(() {
      _user = user;
      name=_user?.name as String;
      email=_user?.email as String;
    });
  }

  @override
  void initState() {
    super.initState();
    userdetails();
  }
  @override
  Widget build(BuildContext context) {
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
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(220),
                    child: Image.network(uProfileImage,fit: BoxFit.cover,),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: TextFieldInput(
                    textEditingController: _nameController,
                    label: 'Name',
                    hintText: "Enter Doctor name",
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(height: 90),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {

                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => UpdateProfileScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor, shape: StadiumBorder()
                    ),
                    child: const Text('Edit Profile',
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
}
