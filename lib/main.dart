import 'package:flutter/material.dart';
import 'package:tugasbro/camera.dart';
import 'package:tugasbro/country_data.dart';
import 'package:tugasbro/konversimatauang.dart';
import 'package:tugasbro/registerpage.dart';
import 'package:tugasbro/saran.dart';
import 'login.dart';
import 'konversiwaktu.dart';
import 'menu.dart';
import 'profile.dart';
import 'country_detail_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/menu': (context) => const Menu(),
      '/login': (context) => const Login(),
      '/registerpage': (context) => const RegisterPage(),
      '/country_data': (context) => const SearchPage(),
      '/profile': (context) => const profile(),
      '/konversiwaktu': (context) => const waktu(),
      '/konversimatauang': (context) => const konversimatauang(),
      '/saran': (context) => const saran(),
      '/country_detail': (context) => const DetailPage(),
      '/camera': (context) => const CameraScreen(),


    },
    home: const Login(),
  ));
}
