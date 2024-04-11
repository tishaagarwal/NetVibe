import 'package:ecommerce/screens/admin-panel/admin-main.dart';
import 'package:ecommerce/screens/user-panel/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import '../../controllers/get-user-data-controller.dart';
import '../../controllers/sign-in-controller.dart';
import '../../utils/app-constent.dart';
import 'forget-password-screen.dart';
import 'sign-up.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key); // Corrected key declaration

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController signInController = Get.put(SignInController());
  final GetUserDataController getUserDataController =
      Get.put(GetUserDataController()); 
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: AppConst.appMainColor,
            title: Text('Sign In', style: TextStyle(color: AppConst.appTextColor1)),
          ),
          body: Container(
            child: Column(
              children: [
                isKeyboardVisible ? SizedBox.shrink() : Column(
                  children: [
                    Image.asset('assets/frame 2.png',fit: BoxFit.cover,)
                  ],
                ),
                SizedBox(height: 16,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: userEmail,
                      cursorColor: AppConst.appMainColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        contentPadding: EdgeInsets.only(top: 2,left: 3),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Obx(() => 
                      TextFormField(
                        controller: userPassword,
                        obscureText: !signInController.isPasswordVisible.value, 
                        cursorColor: AppConst.appMainColor,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              signInController.togglePasswordVisibility();
                            },
                            child: Icon(signInController.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off),
                          ),
                          contentPadding: EdgeInsets.only(top: 2,left: 3),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.centerRight,
                  child:GestureDetector(
                    onTap: () {
                      Get.to(()=> ForgetPasswordScreen());
                    },
                    child: Text('Forget Password ?',style: TextStyle(fontWeight: FontWeight.bold,color: AppConst.appMainColor)),
                  ),
                ),
                SizedBox(height: 26,),
                Material(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(21),
                    ),
                    child: TextButton(
                      child: Text('Sign In ',style: TextStyle(color: Colors.white60),),
                      onPressed: () async{
                        String email = userEmail.text.trim();
                        String password = userPassword.text.trim();

                      if (email.isEmpty || password.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Please enter all details",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      } else {
                        UserCredential? userCredential = await signInController.signInMethod(email,password);

                        var userData = await getUserDataController
                            .getUserData(userCredential!.user!.uid);

                        //  if (userCredential != null) {
                          if (userCredential.user!.emailVerified) {
                            //
                            if (userData[0]['isAdmin'] == true) {
                              Get.snackbar(
                                "Success Admin Login",
                                "login Successfully!",
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              Get.offAll(() => AdminMainScreen());
                            } else {
                              Get.offAll(() => HomePage());
                              Get.snackbar(
                                "Success User Login",
                                "login Successfully!",
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          } else {
                            Get.snackbar(
                              "Error",
                              "Please verify your email before login",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                      }
                    },
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: AppConst.appMainColor),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen())),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: AppConst.appMainColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

