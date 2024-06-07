import 'package:flutter/material.dart';
import 'package:flutter_ticketapp/core/core.dart';
import 'package:flutter_ticketapp/data/datasource/auth_local_datasource.dart';
import 'package:flutter_ticketapp/presentation/home/main_page.dart';

import 'login_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
            const Duration(seconds: 2), () => AuthLocalDatasource().isLogin())
        .then((value) {
      context.pushReplacement(
        value == true ? const MainPage() : const LoginPage(),
      );
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(96.0),
        child: Center(
          child: Assets.images.logoBlue.image(),
        ),
      ),
      bottomNavigationBar: const SizedBox(
        height: 100.0,
        child: Align(
          alignment: Alignment.center,
          // child: Assets.images.logoCwb.image(width: 96.0),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
