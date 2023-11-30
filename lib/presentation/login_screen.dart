import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:wallet_app/data/account_data.dart';
import 'package:wallet_app/model/account_mode.dart';
import 'package:wallet_app/presentation/main_screen.dart';
import 'package:wallet_app/theme/app_color.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Stack(children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Hello Folks! , Selamat Datang',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryColor3),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  width: double.infinity,
                  height: 55,
                  padding: const EdgeInsets.only(left: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: AppColor.primaryColor2),
                  ),
                  child: TextField(
                    maxLines: 1,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: AppColor.primaryColor2,
                      ),
                      hintText: 'Name',
                      border: InputBorder.none,
                    ),
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    controller: _nameController,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: double.infinity,
                  height: 55,
                  padding: const EdgeInsets.only(left: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: AppColor.primaryColor2),
                  ),
                  child: TextField(
                    maxLines: 1,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: AppColor.primaryColor2,
                      ),
                      hintText: 'Email',
                      border: InputBorder.none,
                    ),
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                    '*Ini hanyalah data dummy, silahkan input data dirimu walaupun belum registrasi'),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        backgroundColor: AppColor.primaryColor2,
                      ),
                      onPressed: () {
                        if (_nameController.text.isEmpty ||
                            _emailController.text.isEmpty) {
                          FloatingSnackBar(
                            message: 'Isi data dirimu terlebih dahulu',
                            context: context,
                            textColor: Colors.white,
                            textStyle: const TextStyle(color: Colors.white),
                            duration: const Duration(milliseconds: 4000),
                            backgroundColor: Colors.red,
                          );
                        } else {
                          var data = AccountModel(
                            name: _nameController.text,
                            email: _emailController.text,
                          );
            
                          _loginHandle(data);
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => const MainScreen()),
                            (Route<dynamic> route) => false,
                          );
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void _loginHandle(AccountModel data) {
    setState(() {
      accData = data;
    });
  }
}
