import 'package:flutter/material.dart';
import 'package:wallet_app/presentation/home_screen.dart';
import 'package:wallet_app/presentation/login_screen.dart';
import 'package:wallet_app/presentation/main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background_color.png',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
              top: 70,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/cloud_illustration.png',
                    width: MediaQuery.of(context).size.width,
                  ),
                  const SizedBox(
                    height: 60.0,
                  ),
                  const SizedBox(
                    width: 300,
                    child:  Text(
                      'Catat Keuangan Lebih Cerdas',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  const SizedBox(
                    width: 250,
                    child: Text(
                      'Catat pengeluaran dan pemasukan dengan mudah. DompetCerdas, aplikasi sederhana untuk keuangan yang lebih terorganisir',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )),
          Positioned.fill(
              bottom: 40,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/images/button_start.png',
                        width: 180,
                      ))))
        ],
      ),
    );
  }
}
