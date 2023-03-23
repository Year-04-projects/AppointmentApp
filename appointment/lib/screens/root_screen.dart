import 'package:appointment/screens/AdminScreens/adminhome.dart';
import 'package:appointment/screens/userScreens/userHome.dart';
import 'package:appointment/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/userdetailsprovider.dart';
import '../services/auth_services.dart';
import 'authscreens/login.dart';

class roootScreen extends StatefulWidget {
  const roootScreen({super.key});

  @override
  State<roootScreen> createState() => _roootScreenState();
}

class _roootScreenState extends State<roootScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = true;
  late Widget root;

  @override
  void initState() {
    super.initState();
    UserLogin();
  }

  void UserLogin() async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      setState(() {
        root = login();
      });
      setState(() {
        _isLoading = false;
      });
    } else {
      UserDetailsProvider userdetailsProvider =
        Provider.of<UserDetailsProvider>(context, listen: false);
      await userdetailsProvider.refreshUser();
      AuthServices().getUserDetails().then((value) => {
            if (value.role == 'admin')
              {
                print('currentUseratadmin ${value.role}'),
                setState(() {
                  root = adminHome();
                }),
                setState(() {
                  _isLoading = false;
                })
              }
            else
              {
                print('currentUseratuser ${value.role}'),
                setState(() {
                  root = userHome();
                }),
                setState(() {
                  _isLoading = false;
                })
              }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: secondaryColor,
        ),
      );
    } else {
      return root;
    }
  }
}
