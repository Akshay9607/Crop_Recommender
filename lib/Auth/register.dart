import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_connection/components/my_textfield.dart';
import 'package:firebase_connection/components/my_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> registerUsingEmailPassword ({
       required String name ,
       required String email,
       required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance ;
    print("Name => $name ... Email => $email ... Password => $password");
    User? user ;
    try{
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      user = userCredential.user;
      print("User Data is => ${user}");
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if(e.code=='weak-password'){
        print("Password is too Weak.");
      }else if(e.code=='email-already-in-use'){
        print("The Account already Exists");
      }
    } catch (e) {
      print("Error is ${e}");
    }
    // return user ;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/agri2.png'),
            fit: BoxFit.cover,
            opacity: 0.8,
          ) ,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          // appBar: AppBar(
          //   title: Text("Registration User "),
          //   centerTitle: true,
          // ),
          body: Padding(
              padding: EdgeInsets.all(20.0),

              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 200,),
                    Text(
                        "! Welcome to My Farm !",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        fontFamily: 'Estonia'
                      ),
                    ),
                    SizedBox(height: 30) ,
                    MyTextField(
                      controller: usernameController,
                      hintText: 'Name',
                      obscureText: false,
                    ),
                    SizedBox(height: 30,),
                    MyTextField(controller: emailController, hintText: 'Email Id', obscureText: false),
                    SizedBox(height: 30,),
                    MyTextField(controller: passwordController, hintText: 'Password', obscureText: false),
                    SizedBox(height: 30,),
                    MyButton(
                      onTap: () {
                        registerUsingEmailPassword(
                            name: '${usernameController.text}',
                            email: '${emailController.text}',
                            password: '${passwordController.text}'
                        ) ;
                      }
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
    
  }
}
