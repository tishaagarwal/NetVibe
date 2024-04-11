import 'package:ecommerce/controllers/google-sign-in-controller.dart';
import 'package:get/get.dart';

import '/screens/auth-ui/sign-in.dart';

import '../../utils/app-constent.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final GoogleSignInController _googleSignInController = Get.put(GoogleSignInController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppConst.appMainColor,
        title: Text('Welcome to the NetVibe', style: TextStyle(color: AppConst.appTextColor1)),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(child: Image.asset('assets/frame 2.png',fit: BoxFit.cover,)),
            Container(margin: EdgeInsets.only(top: 20),child: Text('  Happy Shopping.....',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
            SizedBox(height: 51,),
            Material(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(21),
                ),
                child: TextButton.icon(
                  icon: Image.asset('assets/Google.png'),
                  label: Text('Sign in with google',style: TextStyle(color: Colors.white60),),
                  onPressed: (){
                    _googleSignInController.signInWithGoogle();
                  },
                  ),
              ),
            ),
            SizedBox(height: 26),
            Material(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(21),
                ),
                child: TextButton.icon(
                  icon: Image.asset('assets/Email.png'),
                  label: Text('Sign in with Email',style: TextStyle(color: Colors.white60),),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
                  },
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}