// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:project/features/autho/login/view/components/data_widget.dart';

class loginPage extends StatelessWidget {
   loginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       
        child: dataWidget()
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.transparent,
    );
  }
}
