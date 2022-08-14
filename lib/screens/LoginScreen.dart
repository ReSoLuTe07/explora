import 'package:explora/components/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:explora/components/RoundedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'data_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email ;
  late String password;
  bool showSpinner = false ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Card(

                    child: Image.asset('assets/16.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) async{
                    email = value;
                  },
                  decoration: kTextFeildDecoration.copyWith(hintText: 'Enter your Email')
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  cursorColor: Colors.blueAccent,
                  style: TextStyle(
                      color: Colors.black
                  ),
                  onChanged: (value) {
                    password= value;
                  },
                  decoration:kTextFeildDecoration.copyWith(hintText: 'Enter Your Password')
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(title: 'Login',colour: Colors.lightGreenAccent, onPressed: () async{
                setState(() {
                  showSpinner =true;
                });
                try{
                  final newUser =  await _auth.signInWithEmailAndPassword(email: email, password: password);
                  if(newUser!= null){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DataScreen()));
                  }
                  setState(() {
                    showSpinner = false ;
                  });
                }
                catch(e){
                  print(e);


                }
              })
            ],
          ),
        ),
      ),
    );
  }
}