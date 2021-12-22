



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:try1/Homepage.dart';
import 'package:try1/sign_up.dart';


void main(){
  runApp(const MaterialApp(
    home: SignIn(),
  ));
}



class SignIn extends StatefulWidget {

  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
   final _formkey = GlobalKey<FormState>();
   final TextEditingController _email = TextEditingController();
   final TextEditingController _password = TextEditingController();

   
  // firebase
  final _auth = FirebaseAuth.instance;
  
  // string for displaying the error Message
  String? errorMessage;
 

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,

        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back,color: Colors.deepOrange,)
        ),
      ),
       body: Container(
         height: double.infinity,
         width: double.infinity,
         color: Colors.white54,
         child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(23),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Sign In',style: TextStyle(fontSize: 35,fontWeight: FontWeight.w800,color: Colors.deepOrange),),
                    const SizedBox(height: 25,),
                  
                     TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value){
                        if(value!.isEmpty){
                          return ('Please Enter Email');  
                        }
                        if(!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]').hasMatch(value)){
                          return ('Enter Valid Email'); 
                        }
                      }, 
                      onSaved: (value){
                        _email.text = value!;
                      },
                     
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.people),
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
                    ),


                    const SizedBox(height: 7),

                     TextFormField(
                      controller: _password,
                      validator: (value1){
                        if(value1!.isEmpty){
                          return ('Please Enter Password');
                        }
                        RegExp reg = RegExp(r'^.{7,}$');
                        if(!reg.hasMatch(value1)){
                          return ('Please Enter atleast "7" Character ');
                        }
                      },
                       onSaved: (value){
                        _password.text = value!;
                      },    
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.people),
                        hintText: 'Password',
                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
                    ),

                
                    const SizedBox(height: 10,),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(Colors.deepPurple)
                      ),
                      onPressed: (){
                          signIn(_email.text, _password.text);
                      }, 
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20,right: 20),
                        child: Text('Sign up',style: TextStyle(fontSize: 20,)),
                      )
                    ),
                    const SizedBox(height: 10,),
                       TextButton(onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationScreen()));
                   }, child: Text('Sign up Here!')),

                  ],
                ),
              ),
            ),
          ),
      ),
       ),
    );
  }


// login function
  void signIn(String email, String password) async {

    
    if (_formkey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Homepage())),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        
      }
    }
  }
}
