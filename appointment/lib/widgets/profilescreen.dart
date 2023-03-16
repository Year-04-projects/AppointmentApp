import 'package:flutter/material.dart';

import '../screens/authscreens/login.dart';
import '../services/auth_services.dart';
import '../utils/colors.dart';

class profilescreen extends StatefulWidget {
  const profilescreen({super.key});

  @override
  State<profilescreen> createState() => _profilescreenState();
}

const String uProfileImage = "https://cdn-ajggd.nitrocdn.com/kMoOFpDlsOVtlYJLrnSRNCQXaUFHZPTY/assets/images/optimized/rev-208c8fc/wp-content/uploads/bb-plugin/cache/cool-profile-pic-matheus-ferrero-landscape.jpeg";

class _profilescreenState extends State<profilescreen> {
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
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(220),
                    child: Image.network(uProfileImage,fit: BoxFit.cover,),
                ),
              ),
              const SizedBox(height: 10),
              Text("Mimi",
                  style: Theme.of(context).textTheme.headlineMedium),
              Text("mimi@gmail.com",
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => login()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor, shape: StadiumBorder()
                  ),
                  child: const Text('Edit Profile',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        fontWeight: FontWeight.w600
                      )
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              //menu
              ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: unselectedIconColor.withOpacity(0.1),
                  ),
                  child: Icon(Icons.logout_outlined,color: unselectedIconColor),
                ),
                title: Text("Logout", style: Theme.of(context).textTheme.bodyLarge),
              )
            ],
          ),
        ),
      )
    );
  }
}
