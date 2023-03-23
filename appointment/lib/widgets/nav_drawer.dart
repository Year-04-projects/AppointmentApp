import 'package:appointment/screens/AdminScreens/schedulemanagment.dart';
import 'package:appointment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../provider/userdetailsprovider.dart';
import '../screens/authscreens/login.dart';
import '../services/auth_services.dart';

class NavDrawer extends StatefulWidget {
  

  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: darkprimaryColor,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenueItem(context),
          ],
        )),
      );
//header for profile
  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            SizedBox(
              height: 115,
              width: 115,
              child: Stack(
                clipBehavior: Clip.none,
                fit: StackFit.expand,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage("https://www.gravatar.com/avatar/?d=mp"),
                  ),
                  Positioned(
                      bottom: 0,
                      right: -25,
                      child: RawMaterialButton(
                        onPressed: () {},
                        elevation: 2.0,
                        fillColor: Color(0xFFF5F6F9),
                        child: Center(
                          child: Icon(
                            Icons.edit,
                            color: darkprimaryColor,
                          ),
                        ),
                        padding: EdgeInsets.all(5.0),
                        shape: CircleBorder(),
                      )),
                ],
              ),
            ),
            SizedBox(height: 12),
            Consumer<UserDetailsProvider>(
              builder: (context, provider, _) => Text(
                provider.getUser.name ?? 'loading..',
                style: GoogleFonts.urbanist(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.1,
                  color: Colors.white,
                ),
              ),
            ),
            Consumer<UserDetailsProvider>(
              builder: (context, provider, _) => Text(
                provider.getUser?.email ?? 'loading..',
                style: GoogleFonts.urbanist(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.1,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );

//items of nav bar
  Widget buildMenueItem(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(runSpacing: 16, children: [
          const Divider(color: Colors.white),
          ListTile(
            leading: const Icon(
              Icons.dashboard,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              'Dashboard',
              style: GoogleFonts.urbanist(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.1,
                  color: Colors.white),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.add_outlined,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              'Add Scedule',
              style: GoogleFonts.urbanist(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.1,
                  color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ScheduleManagment()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.account_box,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              'Users',
              style: GoogleFonts.urbanist(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.1,
                  color: Colors.white),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_rounded,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              'Sign Out',
              style: GoogleFonts.urbanist(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.1,
                  color: Colors.white),
            ),
            onTap: () {
              //pop navbar b4 going to any page
              Navigator.pop(context);
              AuthServices().signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => login()));
            },
          ),
        ]),
      );
}
