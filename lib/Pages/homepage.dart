import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soiscan/theme.dart';
import 'package:go_router/go_router.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 24,),
                Image.asset("assets/images/homebanner.jpg"),
                Text("Welcome to Soiscan", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: darkgreyColor),),
                const Text(
                  "It offers an easy way to track contacts by sharing QR Codes with others and checking the COVID status of people you meet.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                const SizedBox(height: 24,),
                Container(
                  width: double.infinity,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: (){
                      context.goNamed("login");
                    }, 
                    child: const Text("Login", style: TextStyle(fontSize: 20),),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 0,
                      backgroundColor: darkgreyColor
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: (){}, 
                    child: Text("Signup", style: TextStyle(fontSize: 20, color: darkgreyColor),),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 0,
                      backgroundColor: Colors.white,
                      side: BorderSide(width: 2, color: darkgreyColor)                  
                    ),
                  ),
                ),
                const SizedBox(height: 16,),
                RichText(
                  // textAlign: TextAlign.justify,
                  text: TextSpan(
                    text: "By login or registering, I agree to the ",
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                    children: [
                      TextSpan(
                        text: "Terms and Conditions ",
                        style: TextStyle(color: darkgreyColor)
                      ),
                      const TextSpan(text: "and the "),
                      TextSpan(text: "Privacy Policy", style: TextStyle(color: darkgreyColor))
                    ]
                  )
    
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}