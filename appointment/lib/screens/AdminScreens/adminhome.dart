import 'package:appointment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/user_model.dart';
import '../../services/auth_services.dart';
import '../../widgets/nav_drawer.dart';
import '../authscreens/login.dart';

class adminHome extends StatefulWidget {
  const adminHome({super.key});

  @override
  State<adminHome> createState() => _adminHomeState();
}

class _adminHomeState extends State<adminHome> {
  User? _user;
  //get logged user details
  void userdetails() async {
    User user = await AuthServices().getUserDetails();
    print('name');
    print(user);
    setState(() {
      _user = user;
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
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text(
          'Admin Home',
          style: GoogleFonts.urbanist(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.1,
          ),
        ),
      ),
      drawer: NavDrawer(user: _user),
    );
  }
}
// class NavDrawer extends  StatelessWidget {
//   const NavDrawer({super.key});

//   @override
//   Widget build(BuildContext context) => Drawer(
//     child: SingleChildScrollView(child: Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: <Widget>[
//         buildHeader(context),
//         buildMenueItem(context),
//       ],)),
//   );
//   Widget buildHeader(BuildContext context) =>Container();
//   Widget buildMenueItem(BuildContext context) =>Column(
//     children:[
//       ListTile(
//         leading: const Icon(Icons.home_outlined),
//         title: const Text('Home'),
//         onTap: () {
          
//         },
//       )
//     ]
//   );
// }
//  Center(
//       child: ElevatedButton(
//         onPressed: () {
          // AuthServices().signOut();
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => login()));
//         },
//         child: Text('Admin Signout'),
//       ),
//     );