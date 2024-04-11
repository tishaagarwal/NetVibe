import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app-constent.dart';
import 'sign-in.dart';
import 'package:ecommerce/controllers/sign-up-controller.dart'; // Import SignUpController

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key); // Corrected key declaration

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController signUpController = Get.put(SignUpController());
  TextEditingController username = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!GetUtils.isPhoneNumber(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (!GetUtils.isLengthGreaterOrEqual(value, 8)) {
      return 'Password must be at least 8 characters long';
    }
    if (!GetUtils.hasMatch(value, r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')) {
      return 'Password must contain at least 1 uppercase letter, 1 lowercase letter, 1 digit, and 1 special character';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppConst.appMainColor,
        title: Text('Sign Up', style: TextStyle(color: AppConst.appTextColor1)),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 16,),
            Container(
              alignment: Alignment.center,
              child: Text('Welcome To NetVibe',style: TextStyle(fontSize: 12)),
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
                   validator: validateEmail,
                ),
              )),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: username,
                  cursorColor: AppConst.appMainColor,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    prefixIcon: Icon(Icons.person),
                    contentPadding: EdgeInsets.only(top: 2,left: 3),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    if (value.contains(' ')) {
                      return 'Username should not contain spaces';
                    }
                    return null;
                  },
                ),
              )),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: userPhone,
                  cursorColor: AppConst.appMainColor,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone),
                    contentPadding: EdgeInsets.only(top: 2,left: 3),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                  ),
                  validator: validatePhone,
                ),
              )),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Obx(() => 
                TextFormField(
                  controller: userPassword,
                  obscureText: !signUpController.isPasswordVisible.value, 
                  cursorColor: AppConst.appMainColor,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        signUpController.togglePasswordVisibility(); // Toggle password visibility
                      },
                      child: Icon(signUpController.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off),
                    ),
                    contentPadding: EdgeInsets.only(top: 2,left: 3),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                  ),
                  validator: validatePassword,
                ),
                )
              )),
              SizedBox(height: 21,),
              Material(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(21),
                ),
                child: TextButton(
                  child: Text('Sign up',style: TextStyle(color: Colors.white60),),
                  onPressed: () async {
                        String name = username.text.trim();
                        String email = userEmail.text.trim();
                        String phone = userPhone.text.trim();
                        String password = userPassword.text.trim();
                        String userDeviceToken = '';

                        if (name.isEmpty ||
                            email.isEmpty ||
                            phone.isEmpty ||
                            password.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Please enter all details",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } else {
                          UserCredential? userCredential =
                              await signUpController.signUpMethod(
                            name,
                            email,
                            phone,
                            password,
                            userDeviceToken,
                          );

                          if (userCredential != null) {
                            Get.snackbar(
                              "Verification email sent.",
                              "Please check your email.",
                              snackPosition: SnackPosition.BOTTOM,
                            );

                            FirebaseAuth.instance.signOut();
                            Get.offAll(() => SignInScreen());
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
                  "Already have an account ? ",
                  style: TextStyle(color: AppConst.appMainColor),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen())),
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        color: AppConst.appMainColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}



// import 'package:ecommerce/controllers/sign-up-controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../utils/app-constent.dart';
// import 'sign-in.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final SignUpController  signUpController = Get.put(SignUpController());
//   TextEditingController username = TextEditingController();
//   TextEditingController userEmail = TextEditingController();
//   TextEditingController userPhone = TextEditingController();
//   TextEditingController userPassword = TextEditingController();


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         centerTitle: true,
//         backgroundColor: AppConst.appMainColor,
//         title: Text('Sign Up', style: TextStyle(color: AppConst.appTextColor1)),
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             SizedBox(height: 16,),
//             Container(
//               alignment: Alignment.center,
//               child: Text('Welcome To NetVibe',style: TextStyle(fontSize: 12)),
//             ),
//             SizedBox(height: 16,),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 5),
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: TextFormField(
//                   controller: userEmail,
//                   cursorColor: AppConst.appMainColor,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: InputDecoration(
//                     hintText: 'Email',
//                     prefixIcon: Icon(Icons.email),
//                     contentPadding: EdgeInsets.only(top: 2,left: 3),
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
//                   ),
//                 ),
//               )),
//             SizedBox(height: 16),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 5),
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: TextFormField(
//                   controller: username,
//                   cursorColor: AppConst.appMainColor,
//                   keyboardType: TextInputType.name,
//                   decoration: InputDecoration(
//                     hintText: 'Username',
//                     prefixIcon: Icon(Icons.person),
//                     contentPadding: EdgeInsets.only(top: 2,left: 3),
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
//                   ),
//                 ),
//               )),
//             SizedBox(height: 16),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 5),
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: TextFormField(
//                   controller: userPhone,
//                   cursorColor: AppConst.appMainColor,
//                   keyboardType: TextInputType.phone,
//                   decoration: InputDecoration(
//                     hintText: 'Phone Number',
//                     prefixIcon: Icon(Icons.phone),
//                     contentPadding: EdgeInsets.only(top: 2,left: 3),
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
//                   ),
//                 ),
//               )),
//             SizedBox(height: 16),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 5),
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Obx(() => 
//                 TextFormField(
//                   controller: userPassword,
//                   obscureText: SignUpController.isPasswordVisible.value,
//                   cursorColor: AppConst.appMainColor,
//                   keyboardType: TextInputType.visiblePassword,
//                   decoration: InputDecoration(
//                     hintText: 'Password',
//                     prefixIcon: Icon(Icons.password),
//                     suffixIcon: Icon(Icons.visibility_off),
//                     contentPadding: EdgeInsets.only(top: 2,left: 3),
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
//                   ),
//                 ),
//                 )
//               )),
//               SizedBox(height: 21,),
//               Material(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(21),
//                 ),
//                 child: TextButton(
//                   child: Text('Sign up',style: TextStyle(color: Colors.white60),),
//                   onPressed: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
//                   },
//                   ),
//               ),
//             ),
//             SizedBox(height: 16),
//        Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Already have an account ? ",
//               style: TextStyle(color: AppConst.appMainColor),
//             ),
//             GestureDetector(
//               onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen())),
//               child: Text(
//                 "Sign In",
//                 style: TextStyle(
//                     color: AppConst.appMainColor,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//           ],
//         )
//           ],
//         ),
//       ),
//     );
//   }
// }