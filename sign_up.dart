
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:try1/Homepage.dart';
import 'package:try1/sign_in.dart';



class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  
  
  String? errorMessage;


  
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _cpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //first name field
    final firstNameField = TextFormField(
        autofocus: false,
        controller: _firstName,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          _firstName.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //second name field
    final secondNameField = TextFormField(
        autofocus: false,
        controller: _lastName,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Second Name cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          _lastName.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Second Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));


    final phoneNumber = TextFormField(
              maxLength: 10,
              controller: _phone,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return ('Please Enter Phone-Number');
                }
                if (value.length < 10) {
                  return ('Enter Valid Number');
                }
              },
              onSaved: (value) {
                _phone.text = value!;
              }, 
              decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              counterText: "",
              prefixIcon: const Icon(Icons.email),
              hintText: 'Phone Number',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ));
  
    final emailField = TextFormField(
        autofocus: false,
        controller: _email,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          _email.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: _password,
        obscureText: true,
        validator: (value) {
          RegExp regex = RegExp(r'^.{7,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 7 Character)");
          }
        },
        onSaved: (value) {
          _password.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: _cpassword,
        obscureText: true,
        validator: (value) {
          if (_cpassword.text !=
              _password.text) {
            return "Password don't match";
          }
          return null;
        },
        onSaved: (value) {
          _cpassword.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //signup button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signUp(_email.text, _password.text);
          },
          child: const Text(
            "SignUp",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text('Sign Up',style: TextStyle(fontSize: 35,fontWeight: FontWeight.w800,color: Colors.deepOrange),),
                    const SizedBox(height: 45),
                    firstNameField,
                    const SizedBox(height: 20),
                    secondNameField,
                    const SizedBox(height: 20),
                    phoneNumber,
                    const SizedBox(height: 20),
                    emailField,
                    const SizedBox(height: 20),
                    passwordField,
                    const SizedBox(height: 20),
                    confirmPasswordField,
                    const SizedBox(height: 20),
                    signUpButton,
                    const SizedBox(height: 15),
                    RichText(
  text: TextSpan(
    text: 'Already have an Account ? ',
    style: TextStyle(fontSize: 13,color: Colors.black),
    children: <TextSpan>[
      
      TextSpan(text: 'SIGN UP!', style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),recognizer: TapGestureRecognizer()..onTap=(){
         Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
      }),
      
     
    ],
  ),
)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
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
        print(error.code);
      }
    }
  }
  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

 //   UserModel userModel = UserModel();

    // writing all the values
    // userModel.email = user!.email;
    // userModel.uid = user.uid;
    // userModel.firstName = _firstName.text;
    // userModel.secondName = _lastName.text;
    // userModel.phone = _phone.text;

    await firebaseFirestore
        .collection("users")
        .doc(user!.uid)
        .set({
          'uid': user.uid,
          'email': user.email,
          'firstName': _firstName.text,
          'lastName': _lastName.text,
          'phoneNumber' : _phone.text,
        });      //userModel.toMap()         
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const Homepage()),
        (route) => false);
  }
}





// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/widgets.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:try1/Homepage.dart';
// import 'package:try1/model/user_model.dart';

// void main(){
//   runApp(const MaterialApp(
//     home: SignUp(),
//   ));
// }

// class SignUp extends StatefulWidget {
//   const SignUp({Key? key}) : super(key: key);

//   @override
//   _SignUpState createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {

//    final _auth = FirebaseAuth.instance;
  
//   // string for displaying the error Message
//   String? errorMessage;

//    final _formKey = GlobalKey<FormState>();
//    final TextEditingController _fisrtname = TextEditingController();
//    final TextEditingController _lastname = TextEditingController();
//    final TextEditingController _email = TextEditingController();
//    final TextEditingController _phone = TextEditingController();
//    final TextEditingController _password = TextEditingController();
//    final TextEditingController _cpassword = TextEditingController();


//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         leading: IconButton(onPressed: (){ Navigator.pop(context);}, icon: const Icon(Icons.arrow_back)),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(23),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text('Sign Up',style: TextStyle(fontSize: 35,fontWeight: FontWeight.w800,color: Colors.deepOrange),),
//                   const SizedBox(height: 25,),
//                   TextFormField(
//                     maxLength: 15,
//                     controller: _fisrtname,
//                     validator: (value){
//                       if(value!.isEmpty){
//                         return('Please Enter FirstName');
//                       }
//                       if (value.length >= 15) {
//                         return ('Characters Limit is 15');
//                       }
//                     },
//                       onSaved: (value) {
//           _fisrtname.text = value!;
//         },
//                     decoration: InputDecoration(
//                       counterText: "",
//                       prefixIcon: const Icon(Icons.people),
//                       hintText: 'FirstName',      
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20)
//                       )
//                     ),
//                   ),
//                   const SizedBox(height: 5,),
//                   TextFormField(
//                     controller: _lastname,
//                     maxLength: 10,
//                     validator: (value){
//                       if(value!.isEmpty){
//                         return('Please Enter LastName');
//                       }
//                     },
//                             onSaved: (value) {
//           _lastname.text = value!;
//         },
//                     decoration: InputDecoration(
//                       counterText: "",
//                       prefixIcon: const Icon(Icons.people),
//                       hintText: 'LastName',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20)
//                       )
//                     ),
//                   ),
//                   const SizedBox(height: 5,),
//                    TextFormField(
//                      controller: _email,
//                      keyboardType: TextInputType.emailAddress,
//                      validator: (value){
//                        if(value!.isEmpty){
//                          return ('Please Enter Email');
//                        }
//                        if(!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]').hasMatch(value)){
//                          return ('Enter Valid Email');
//                        }
//                      },
//                              onSaved: (value) {
//           _email.text = value!;
//         },
//                      decoration: InputDecoration(
//                       prefixIcon: const Icon(Icons.email),
//                       hintText: 'Email',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20)
//                       )
//                     ),
//                   ),
//                    const SizedBox(height: 5,),
//                    TextFormField(
//                      maxLength: 10,
//                      controller: _phone,
//                      validator: (value) {
//                        if (value!.isEmpty) {
//                          return ('Please Enter Phone-Number');
//                        }
//                        if (value.length < 10) {
//                          return ('Enter Valid Number');
//                        }
//                      },
//                         onSaved: (value) {
//                   _phone.text = value!;
//                     },
                          
//                     keyboardType: TextInputType.phone,
//                     decoration: InputDecoration(
//                       counterText: "",
//                       prefixIcon: const Icon(Icons.email),
//                       hintText: 'Phone Number',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20)
//                       )
//                     ),
//                   ),      
//                   const SizedBox(height: 5,),
//                    TextFormField(
//                     controller: _password,
//                     obscureText: true,
//                     validator: (value){
//                       if(value!.isEmpty){
//                         return ('Please Enter Password');
//                       }
//                       RegExp reg = RegExp(r'^.{7,}$');
//                       if(!reg.hasMatch(value)){
//                         return ('Please Enter atleast "7" Character ');
//                       }
//                     },
//                        onSaved: (value) {
//           _password.text = value!;
//         },
//                     decoration: InputDecoration(
//                       prefixIcon: const Icon(Icons.password),
//                       hintText: 'Password',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20)
//                       )
//                     ),
//                   ),
//                   const SizedBox(height: 5,),
//                    TextFormField(
//                     controller: _cpassword,
//                     obscureText: true,
//                      validator: (value){
//                       if(value!.isEmpty){
//                         return ('Please Enter Comfirm Password');
//                       }
                     
//                       if(_password.text != _cpassword.text){
//                         return ('Please Does Not Match');
//                       }
//                     },
//                        onSaved: (value) {
//           _cpassword.text = value!;
//         },
//                     decoration: InputDecoration(
//                       prefixIcon: const Icon(Icons.password_outlined),
//                       hintText: 'Comfirm Password',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20)
//                       )
//                     ),
//                   ),


//                   const SizedBox(height: 10,),
//                   TextButton(
//                     style: ButtonStyle(
//                       foregroundColor: MaterialStateProperty.all(Colors.white),
//                       backgroundColor: MaterialStateProperty.all(Colors.deepPurple)
//                     ),
//                     onPressed: (){
//                       // if(_form.currentState!.validate()){
//                       //  Fluttertoast.showToast(msg: 'Entered Details Correct');
//                       //       Navigator.push(context, (MaterialPageRoute(builder: (context){
//                       //     return const Homepage();
//                       //   })));
//                       // }
//                        signUp(_email.text, _password.text);
//                     }, 
//                     child: const Padding(
//                       padding: EdgeInsets.only(left: 20,right: 20),
//                       child: Text('Sign up',style: TextStyle(fontSize: 20,)),
//                     )
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//    void signUp(String email, String password) async { 
//     if(_formKey.currentState!.validate()) {
//       try {
//         await _auth
//               .createUserWithEmailAndPassword(email: email, password: password)
//               .then((value) => {postDetailsToFirestore()})
//               .catchError((e){
//               Fluttertoast.showToast(msg: e!.message);
//               });        
//       } on FirebaseAuthException catch (error) {
//         switch (error.code) {
//           case "invalid-email":
//             errorMessage = "Your email address appears to be malformed.";

//             break;
//           case "wrong-password":
//             errorMessage = "Your password is wrong.";
//             break;
//           case "user-not-found":
//             errorMessage = "User with this email doesn't exist.";
//             break;
//           case "user-disabled":
//             errorMessage = "User with this email has been disabled.";
//             break;
//           case "too-many-requests":
//             errorMessage = "Too many requests";
//             break;
//           case "operation-not-allowed":
//             errorMessage = "Signing in with Email and Password is not enabled.";
//             break;
//           default:
//             errorMessage = "An undefined Error happened.";
//         }
//         Fluttertoast.showToast(msg: errorMessage!);
//         print(error.code);
//       }
//     }
//   }
// postDetailsToFirestore()  {
//    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     User? user = _auth.currentUser;

//     UserModel userModel = UserModel();

//     // writing all the values
//     userModel.email = user!.email;
//     userModel.uid = user.uid;
//     userModel.firstName = _fisrtname.text;
//     userModel.secondName = _lastname.text;
//  //   userModel.phone = _phone.text as int?;

   

//      firebaseFirestore
//         .collection("users")
//         .doc(user.uid)
//         .set({     
//           'uid': user.uid,
//           'email': _email,
//           'firstName': _fisrtname,
//           'lastName': _lastname,
//           'phoneNumber' : _phone,
//         });      //userModel.toMap()
//     Fluttertoast.showToast(msg: "Account created successfully :) ");

//     Navigator.pushAndRemoveUntil(
//         (context),
//         MaterialPageRoute(builder: (context) => const Homepage()),
//         (route) => false);
//   }
// }