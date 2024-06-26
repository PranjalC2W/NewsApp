import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/view/HomePage.dart';
import 'package:flutter_assignment/view/SignUpPage.dart';
import 'package:flutter_assignment/view/fetch_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_assignment/model/newsModel.dart';

String cid="in";
List<Articles> articles=[];
class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginPageState();
}

class _LoginPageState extends State<Loginpage> {

 final TextEditingController _email=TextEditingController();
 final TextEditingController _password=TextEditingController();
  final FetchData _fetchData = FetchData();


  
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
              height: 310,
            ),
            SizedBox(
              height: 49,
              width: 231,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor:Theme.of(context).primaryColor,),
                
                onPressed:() async{
                  
               // getNews(cid);
                  // Navigator.push(context, MaterialPageRoute(builder:(context) {
                  //   return const Homepage();
                  // },));

                   String email = _email.text.trim();
                  String password = _password.text.trim();

                  if (email.isNotEmpty && password.isNotEmpty) {
                    User? user = await _fetchData.signInWithEmailAndPassword(email, password);
                    if (user != null) {
                      getNews(cid);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Homepage()),
                      );
                    } else {
                     
                      ScaffoldMessenger.of(context).showSnackBar(
                      const   SnackBar(content: Text("Login failed. Please try again.")),
                      );
                    }
                  } else {
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                     const  SnackBar(content: Text("Please fill in all fields.")),
                    );
                  }
                }, 
                child:Text("Login",style: GoogleFonts.poppins(fontSize:16,fontWeight:FontWeight.w700,color:const Color.fromRGBO(255, 255, 255, 1)))),
            ),
            const SizedBox(height: 15,),
           Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New here?",
                  style: GoogleFonts.poppins(fontSize:16,fontWeight:FontWeight.w400,color:const Color.fromRGBO(0, 0, 0, 1))
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) {
                            return const SignUpPage();
                          },));
                        },
                        child: Text(
                          "Signup",
                          style: GoogleFonts.poppins(fontSize:16,fontWeight:FontWeight.w700,color:Theme.of(context).primaryColor)
                        )),
                  ],
                ),
          
          ],
        ),
      ),
    );
  }
   void getNews(String cid)async{
    Uri url=Uri.parse("https://newsapi.org/v2/top-headlines?country=in&apiKey=d885b71d234a46d8aa83901ee575ce74");
    http.Response response= await  http.get(url);
    //log(response.body);

   var responseData=json.decode(response.body);
    
 
   Autogenerated  automodel=Autogenerated(responseData);

    setState(() {
      articles=automodel.articles!;
    });
    



  }
}