import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/features/autho/login/view/page/login.dart';


import 'package:project/pages/bookingPage.dart';
import 'package:project/pages/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';

class dashboard extends StatelessWidget {
  dashboard({super.key});
  final _pageControlller = PageController();

  @override
  void dispose() {
    _pageControlller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            " Web Service ",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Color(0xFF345069),

          ///log out button
          actions: [
            IconButton(
              onPressed: () async {
    
 
                try {
                  // Save some data before logging out
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setString('some_key', 'some_value');
                  print('Data saved');
                  await Future.delayed(Duration(seconds: 2));
                  // Sign out the user from Firebase
                  await FirebaseAuth.instance.signOut();
                  print('User signed out from Firebase');

                  // If using Google Sign-In, disconnect Google account
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  if (await googleSignIn.isSignedIn()) {
                    await googleSignIn.disconnect();
                    print('User disconnected from Google');
                  } else {
                    print('User was not signed in with Google');
                  }

                  Navigator.of(context).pop();
                 
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return loginPage();
                  }));
                } catch (e) {
                  print('An error occurred while signing out: $e');
                }
              },
              icon: Icon(Icons.exit_to_app),
              iconSize: 35,
              color: Colors.white,
            )
          ],
        ),
        body: PageView(
          controller: _pageControlller,
          children: const <Widget>[
            HomePage(),
            BookingPage(),
          ],
        ),
        extendBody: true,
        bottomNavigationBar: RollingBottomBar(
          color: const Color.fromARGB(255, 255, 240, 219),
          controller: _pageControlller,
          flat: true,
          useActiveColorByDefault: false,
          items: const [
            RollingBottomBarItem(Icons.home,
                label: 'Home', activeColor: Color.fromARGB(255, 0, 0, 0)),
            RollingBottomBarItem(Icons.sticky_note_2,
                label: 'Booking', activeColor: Color.fromARGB(255, 0, 0, 0)),
          ],
          enableIconRotation: true,
          onTap: (index) {
            _pageControlller.animateToPage(
              index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
            );
          },
        ),
      ),
    );
  }
}
