import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../screens/authscreens/login.dart';
import '../screens/userScreens/updateProfileScreen.dart';
import '../services/auth_services.dart';
import '../utils/colors.dart';

class profilescreen extends StatefulWidget {
  const profilescreen({super.key});

  @override
  State<profilescreen> createState() => _profilescreenState();
}

const String uProfileImage = "https://firebasestorage.googleapis.com/v0/b/ctsea1.appspot.com/o/doctors%2Favatar.jpg?alt=media&token=7880ba93-e7ad-45cb-bb80-6d22fd65ac30";

class _profilescreenState extends State<profilescreen> {

  User? _user;
  String name="",email="";
  late String photoUrl,uid;
  late int age;
  void userdetails() async {
    User user = await AuthServices().getUserDetails();
    print('name');
    setState(() {
      _user = user;
      uid=_user?.uid as String;
      name=_user?.name as String;
      email=_user?.email as String;
      age=_user?.age as int;
      photoUrl=_user?.photoUrl as String;
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
      // appBar: AppBar(
      //   title: Text("Profile", style: Theme.of(context).textTheme.headlineMedium),
      // ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children:  [
              const SizedBox(height: 20),
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(220),
                  child: Image.network(
                    photoUrl.isNotEmpty ? photoUrl : uProfileImage,
                    fit: BoxFit.cover,),
                ),
              ),
              const SizedBox(height: 10),
              Text(name,
                  style: Theme.of(context).textTheme.headlineMedium),
              Text(email,
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 20),
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
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              ListTile(
                leading: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.red.withOpacity(0.2),
                  ),
                  child: const Icon(Icons.delete,color: Colors.red),
                ),
                title: Text("Delete Account",
                  style: Theme.of(context).textTheme.bodyLarge?.apply(
                    color: Colors.red,
                  ),
                ),
                  onTap: () async {
                  if (photoUrl.isNotEmpty) {
                    await AuthServices().deleteImage(photoUrl);
                  }
                  await AuthServices().deleteAccount(uid);

                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => login()));
                }),
            //menu
              ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: primaryColor.withOpacity(0.2),
                  ),
                  child: Icon(Icons.logout_outlined,color: primaryColor),
                ),
                title: Text("Logout",
                    style: Theme.of(context).textTheme.bodyLarge?.apply(
                      color: primaryColor,
                    ),
                ),
                onTap: (){
                  AuthServices().signOut();
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => login()));
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}
