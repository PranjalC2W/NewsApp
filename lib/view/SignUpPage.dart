import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/view/LoginPage.dart';
import 'package:flutter_assignment/view/fetch_data.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

final   TextEditingController _name=TextEditingController();
 final TextEditingController _email=TextEditingController();
 final TextEditingController _password=TextEditingController();
  final FetchData _fetchData=FetchData();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 249, 253, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15,top: 45),
              child: SizedBox(
                height: 30,
                width:356,
                child: Text("MyNews",style: GoogleFonts.poppins(fontSize:20,fontWeight:FontWeight.w700,color:Theme.of(context).primaryColor),),
              ),
            ),
            const SizedBox(
              height:160,
            ),
            SizedBox(
              height: 35,
              width: 356,
              child: TextFormField(
                 controller: _name,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(255, 255,255,1),
                    labelText: "Name",
                labelStyle: GoogleFonts.poppins(fontSize:14,fontWeight:FontWeight.w400,color:const Color.fromRGBO(0, 0, 0, 1)),
        
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                       borderSide: BorderSide.none
        
                    )
                  ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 35,
              width: 356,
              child: TextFormField(
                 controller: _email,
                  decoration: InputDecoration(
                    
                    filled: true,
                    fillColor: const Color.fromRGBO(255, 255,255,1),
                    labelText: "Email",
                labelStyle: GoogleFonts.poppins(fontSize:14,fontWeight:FontWeight.w400,color:const Color.fromRGBO(0, 0, 0, 1)),
        
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                       borderSide: BorderSide.none
        
                    )
                  ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 35,
              width: 356,
              child: TextFormField(
                 controller: _password,
                  decoration: InputDecoration(
                    filled: true,
                   fillColor: const Color.fromRGBO(255, 255,255,1),
                    labelText: "Password",
                labelStyle: GoogleFonts.poppins(fontSize:14,fontWeight:FontWeight.w400,color:const Color.fromRGBO(0, 0, 0, 1)),
        
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                       borderSide: BorderSide.none
                    )
                  ),
              ),
            ),
            
             const SizedBox(
              height: 270,
            ),
            SizedBox(
              height: 49,
              width: 231,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor:Theme.of(context).primaryColor,),
                
                onPressed:()async {
                   String name = _name.text.trim();
                  String email = _email.text.trim();
                  String password = _password.text.trim();
                 // FetchData();
                  // Navigator.push(context, MaterialPageRoute(builder:(context) {
                  //   return const Homepage();
                  // },));
                   if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
                    User? user = await _fetchData.registerWithEmailAndPassword(name, email, password);
                    if (user != null) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Loginpage()));
                    } else {
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                      const   SnackBar(content: Text("Registration failed. Please try again.")),
                      );
                    }
                  } else {
                   
                    ScaffoldMessenger.of(context).showSnackBar(
                   const    SnackBar(content: Text("Please fill in all fields.")),
                    );
                  }
                }, 
                child:Text("Signup",style: GoogleFonts.poppins(fontSize:16,fontWeight:FontWeight.w700,color:const Color.fromRGBO(255, 255, 255, 1)))),
            ),
            const SizedBox(height: 15,),
           Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                  style: GoogleFonts.poppins(fontSize:16,fontWeight:FontWeight.w400,color:const Color.fromRGBO(0, 0, 0, 1))
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                        onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context) {
                        return const Loginpage();
                  },));
                        },
                        child: Text(
                          "Login",
                          style: GoogleFonts.poppins(fontSize:16,fontWeight:FontWeight.w700,color:Theme.of(context).primaryColor)
                        )),
                  ],
                ),
          
          ],
        ),
      ),
    );
  }
}