import 'package:flutter/material.dart';
import 'package:wallet_app/data/account_data.dart';
import 'package:wallet_app/model/account_mode.dart';
import 'package:wallet_app/presentation/welcome_screen.dart';
import 'package:wallet_app/theme/app_color.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Image.asset(
              'assets/images/profile_header.png',
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        accData.name!,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor3),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    accData.email!,
                    maxLines: 3,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: AppColor.primaryColor3),
                  ),
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
                          backgroundColor: AppColor.secondaryColor3,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                _nameController.text = accData.name!;
                                _emailController.text = accData.email!;

                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: const Text('Update Profile'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: _nameController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Name',
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        TextField(
                                          controller: _emailController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Email',
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                            ),
                                            backgroundColor:
                                                AppColor.primaryColor2,
                                          ),
                                          onPressed: () {
                                            var data = AccountModel(
                                              name: _nameController.text,
                                              email: _emailController.text,
                                            );

                                            updateProfileHandle(data);

                                            _nameController.clear();
                                            _emailController.clear();
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'update Data',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                  ],
                                );
                              });
                        },
                        child: const Text(
                          'Update Profile',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () => logoutHandle(),
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                  ),
                  const SizedBox(
                  height: 50.0,
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void updateProfileHandle(AccountModel data) {
    setState(() {
      accData = data;
    });
  }

  void logoutHandle() {
    setState(() {
      accData = AccountModel(name: '', email: '');
    });
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      ),
    );
  }
}
