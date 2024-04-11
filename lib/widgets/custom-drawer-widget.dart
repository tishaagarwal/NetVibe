import 'package:ecommerce/utils/app-constent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../screens/user-panel/all-orders-screen.dart';
import '../screens/user-panel/main_screen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: Get.height/25),
    child: Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(21),
          bottomRight: Radius.circular(21) 
        ),
      ),
      child: Wrap(
        runSpacing: 10,
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 21),
          child:ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            title: Text('Tisha',
            style: TextStyle(color: AppConst.appTextColor1),),
            subtitle: Text('Version 1.0.1',
            style: TextStyle(color: AppConst.appTextColor1),),
            leading: CircleAvatar(
              radius: 21,
              backgroundColor: Colors.white,
              child: Text('T'),
            ),
          ),
          ),
          Divider(
            indent: 12,
            endIndent: 12,
            thickness: 1,
            color: Colors.black,
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          child:ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            title: Text('Home',
            style: TextStyle(color: AppConst.appTextColor1),),
            leading: Icon(Icons.home,
            color: AppConst.appTextColor1,),
            trailing:  Icon(Icons.arrow_forward,
            color: AppConst.appTextColor1,),
          ),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          child:ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            title: Text('Product',
            style: TextStyle(color: AppConst.appTextColor1),),
            leading: Icon(Icons.production_quantity_limits,
            color: AppConst.appTextColor1,),
            trailing:  Icon(Icons.arrow_forward,
            color: AppConst.appTextColor1,),
          ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Orders",
                  style: TextStyle(color: AppConst.appTextColor1),
                ),
                leading: Icon(
                  Icons.shopping_bag,
                  color: AppConst.appTextColor1,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: AppConst.appTextColor1,
                ),
                onTap: () {
                  Get.back();
                  Get.to(() => AllOrdersScreen());
                },
              ),
            ),
          // Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          // child:ListTile(
          //   titleAlignment: ListTileTitleAlignment.center,
          //   title: Text('Orders',
          //   style: TextStyle(color: AppConst.appTextColor1),),
          //   leading: Icon(Icons.shopping_bag,
          //   color: AppConst.appTextColor1,),
          //   trailing:  Icon(Icons.arrow_forward,
          //   color: AppConst.appTextColor1,),
          // ),
          // ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          child:ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            title: Text('Contact',
            style: TextStyle(color: AppConst.appTextColor1),),
            leading: Icon(Icons.phone,
            color: AppConst.appTextColor1,),
            trailing:  Icon(Icons.arrow_forward,
            color: AppConst.appTextColor1,),
          ),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          child:ListTile(
            onTap: () async{
              // ignore: unused_local_variable
              GoogleSignIn googleSignIn = GoogleSignIn();
              FirebaseAuth _auth = FirebaseAuth.instance;
              await _auth.signOut();
              Get.offAll(() => MainScreen());
            },
            titleAlignment: ListTileTitleAlignment.center,
            title: Text('Logout',
            style: TextStyle(color: AppConst.appTextColor1),),
            leading: Icon(Icons.logout,
            color: AppConst.appTextColor1,),
            trailing:  Icon(Icons.arrow_forward,
            color: AppConst.appTextColor1,),
          ),
          ),
        ],
      ),
      backgroundColor: AppConst.appMainColor,
    ),
    );
  }
}