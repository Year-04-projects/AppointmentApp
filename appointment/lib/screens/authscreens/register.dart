import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../models/user_model.dart';
import '../../provider/userdetailsprovider.dart';
import '../../services/auth_services.dart';
import '../../utils/colors.dart';
import '../../widgets/common/tex_field_field.dart';
import '../AdminScreens/adminhome.dart';
import '../userScreens/userHome.dart';
import 'login.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  bool _isLoading = false;

  //user register
  void registerUser() async {
    final isFormValid = _formKey.currentState!.validate();
    if (isFormValid == false) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    String res = await AuthServices().registerUser(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (res != 'success') {
      //if login invalid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      //if login true
      UserDetailsProvider userdetailsProvider =
          Provider.of<UserDetailsProvider>(context, listen: false);
      await userdetailsProvider.refreshUser();
      User user = await AuthServices().getUserDetails();
      if (user.role == 'admin') {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const adminHome(),
          ),
        );
      } else if (user.role == 'user') {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const userHome(),
          ),
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User not added'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          width: double.infinity,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    const Spacer(),
                    Image.asset(
                      'assets/logo.png',
                      height: 160,
                    ),
                    const Spacer(flex: 2),
                    Text(
                      'Sign up',
                      style: GoogleFonts.urbanist(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.1,
                      ),
                    ),
                    const Spacer(),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFieldInput(
                            textEditingController: _nameController,
                            label: 'Name',
                            hintText: 'Enter your name',
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 12),
                          TextFieldInput(
                            textEditingController: _emailController,
                            label: 'Email Address',
                            hintText: 'Enter your email',
                            textInputType: TextInputType.emailAddress,
                            isEmail: true,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 12),
                          TextFieldInput(
                            textEditingController: _passwordController,
                            label: 'Password',
                            hintText: 'Enter your password',
                            textInputType: TextInputType.text,
                            isPass: true,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 12),
                          TextFieldInput(
                            textEditingController: _confirmPassController,
                            label: 'Confirm Password',
                            hintText: 'Enter confirm password',
                            textInputType: TextInputType.text,
                            isPass: true,
                            isConfirmPass: _passwordController.text,
                            textInputAction: TextInputAction.done,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 36),
                    InkWell(
                      onTap: registerUser,
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
                                'Sign up',
                                style: GoogleFonts.urbanist(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Text(
                            'Do you have an account?',
                            style: GoogleFonts.urbanist(
                              fontSize: 15,
                              color: const Color.fromRGBO(30, 35, 44, 1),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => login()));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              ' Sign in.',
                              style: GoogleFonts.urbanist(
                                fontSize: 15,
                                color: const Color.fromRGBO(30, 35, 44, 1),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
