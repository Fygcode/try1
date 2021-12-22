




import 'package:flutter/material.dart';
import 'package:try1/sign_in.dart';
import 'package:try1/sign_up.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: true,
    home: IndexPage(),
  ));
}

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration:  const BoxDecoration(
          gradient: LinearGradient(
              colors:[
                Colors.pink,
               
                Colors.orange
              ]
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 100,),
            const Text('WELCOME',style: TextStyle(fontSize: 40,fontWeight: FontWeight.w700)),
            const SizedBox(height: 8,),
            const Text('Explore Right Away',style: TextStyle(fontSize: 15)),
            const SizedBox(height: 50,),
            Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50))
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [ 
                        const SizedBox(height: 60,),
                        Image.asset('images/cropped.png', width: 300),
                        const SizedBox(height: 60,),
                        Container(
                          height: 250,
                          width: 250,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.blueGrey,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue,
                                blurRadius: 40,
                                offset: Offset(2, 10)
                              )
                            ]
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 20,),
                              Image.asset('images/cropped.png', width: 150),
                              const SizedBox(height: 25,),
                              Container(
                                decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 20,
                                          offset: Offset(2, 2)
                                      )
                                    ]
                                ),
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignIn()));
                                      },
                                      child: const Text('SIGN IN',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all(const EdgeInsets.only(left: 50,right: 50)),
                                          backgroundColor: MaterialStateProperty.all(Colors.black)
                                      ),
                                    ),
                                  ],
                                )
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                  decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.white,
                                            blurRadius: 20,
                                            offset: Offset(2, 2)
                                        )
                                      ]
                                  ),
                                  child: Column(
                                    children: [
                                      ElevatedButton(
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegistrationScreen()));
                                        },
                                        child: const Text('SIGN UP',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all(const EdgeInsets.only(left: 50,right: 50)),
                                            backgroundColor: MaterialStateProperty.all(Colors.black)
                                        ),
                                      ),
                                    ],
                                  )
                              )
                            ],
                          ),
                        )
                          
                      ],
                    ),
                  ),
                          ))
          ],
        ),
      ),

    );
  }
}

