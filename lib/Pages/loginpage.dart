import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soiscan/theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent
      ),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: darkgreyColor
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text("Login", style: TextStyle(color: darkgreyColor),),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60,),
                  Text("Login", style: TextStyle(fontSize: 35, color: darkgreyColor, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  const Text("Enter your valid data to login", style: TextStyle(color: Colors.grey, fontSize: 16 ),),
                  const SizedBox(height: 30,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      labelText: "Email",
                    ),
                  ),
                  const SizedBox(height: 15,),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      labelText: "Password",
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: (){}, 
                      child: const Text("Login", style: TextStyle(fontSize: 20),),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 0,
                        backgroundColor: darkgreyColor
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ),
      )
    );
  }
}