import 'package:flutter/material.dart';
import 'package:hey_app/appColors.dart';
import 'package:hey_app/services/auth/authService.dart';
import 'package:hey_app/pages/LoginPage.dart';

import 'HomePage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _email=TextEditingController();
  TextEditingController _pass=TextEditingController();
  TextEditingController _passConfirm=TextEditingController();
  late var _passwordVisible= true;
  late var _passwordVisible1= true;

 void signup(context){

    final _auth=AuthService();

   if (_pass.text==_passConfirm.text){
     try{
       _auth.signUpWithEmailAndPass(_email.text,_pass.text);

       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> HomePage()),(route) => false,);
     }catch(e){
       showDialog(
           context: context,
           builder: (context) => AlertDialog(icon: Icon(Icons.error),iconColor: AppColors.white,
             title: Text(e.toString()),
           ));
     }
   }else{
     showDialog(
         context: context,
         builder: (context) => AlertDialog(
           icon: Icon(Icons.error),iconColor: AppColors.white,
           title: Text("Password doesn't match",style: TextStyle(color: AppColors.white)),
         ));
   }


  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: const Color(0xff1c1c1c),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 25),
            child: SingleChildScrollView(scrollDirection: Axis.vertical,

              child: Center(
                  child:

                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10,),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 50),
                        Container(
                            alignment: Alignment.centerLeft,

                            child: const Text("Register",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white))),



                        const SizedBox(
                          height: 18,
                        ),

                        Container(
                            alignment: Alignment.centerLeft,
                            child: const Text("Email",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white))),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _email,
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.start,
                          decoration: const InputDecoration(
                            fillColor: Color(0x5A424242),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            contentPadding: EdgeInsets.all(15),
                            hintText: "Enter your email",
                            hintStyle: TextStyle(
                                color: Color(0xffbdbfbe),
                                fontSize: 12,
                                fontWeight: FontWeight.w300),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: const Text("Password",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white))),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _pass,
                          style: TextStyle(color: Colors.white),
                          obscureText: _passwordVisible,
                          textAlign: TextAlign.start,
                          decoration:  InputDecoration(
                            suffixIcon: IconButton(onPressed: (){
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });

                            }, icon: const Icon(Icons.remove_red_eye_outlined)),
                            fillColor: Color(0x5A424242),
                            filled: _passwordVisible1,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            contentPadding: EdgeInsets.all(15),
                            hintText: "Enter your password",
                            hintStyle: TextStyle(
                                color: Color(0xffbdbfbe),
                                fontSize: 12,
                                fontWeight: FontWeight.w300),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: const Text("Confirm password",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white))),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _passConfirm,
                          style: TextStyle(color: Colors.white),
                          obscureText: _passwordVisible1,
                          textAlign: TextAlign.start,
                          decoration:  InputDecoration(
                            suffixIcon: IconButton(onPressed: (){
                              setState(() {

                                _passwordVisible1 = !_passwordVisible1;
                              });

                            }, icon: const Icon(Icons.remove_red_eye_outlined)),
                            fillColor: Color(0x5A424242),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            contentPadding: EdgeInsets.all(15),
                            hintText: "Enter your password again",
                            hintStyle: TextStyle(
                                color: Color(0xffbdbfbe),
                                fontSize: 12,
                                fontWeight: FontWeight.w300),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 35,
                        ),
                        MaterialButton(
                          elevation: 0,
                          minWidth: double.infinity,
                          height: 50,
                          shape: RoundedRectangleBorder(
                            // side: BorderSide(color: Colors.black12, width: 2),
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: ()=> signup(context),
                          color: const Color(0x5A424242),
                          child: const Text("Signup",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white)),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(0),
                                  alignment: Alignment.center,
                                  child: TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                          "Already have an account?",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                              color: Color(0xffafaeae))))),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Login",style: TextStyle(
                                      color: Colors.white,fontWeight: FontWeight.w800
                                  ),)
                              )

                            ]
                        )

                      ],
                    ),
                  )


              ),
            ),
          )),
    );;
  }
}
