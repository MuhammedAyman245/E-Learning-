import 'package:e_learning_app/screens/admin/adminHome.dart';
import 'package:e_learning_app/screens/regestration/signUp.dart';
import 'package:e_learning_app/screens/users/bar.dart';
import 'package:e_learning_app/services/auth.dart';
import 'package:e_learning_app/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignIn extends StatefulWidget {
  static const String id = 'signIN';
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String email, password;
  Auth _auth = Auth();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _key,
      child: Scaffold(
          backgroundColor: Colors.lightBlue[200],
          body: ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Container(
              height: size.height,
              width: size.width,
              child: ListView(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 6),
                        child: Container(
                          height: size.height * .38,
                          width: size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/welcome.png')),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(120, 290, 100, 20),
                        child: Text(
                          'E-Learning',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 350, 50, 0),
                        child: Container(
                          height: size.height * .5,
                          width: size.width * .9,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(30))),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, right: 15, left: 15),
                                child: MyTextField(
                                  onSaved: (value) {
                                    email = value;
                                  },
                                  hint: 'account@gmail.com',
                                  label: 'Email',
                                  icon: Icon(
                                    Icons.account_circle,
                                    size: 25,
                                    color: Colors.blue[900],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 15, left: 15),
                                child: MyTextField(
                                  onSaved: (value) {
                                    password = value;
                                  },
                                  hint: 'Password',
                                  label: 'Password',
                                  icon: Icon(
                                    Icons.lock,
                                    size: 25,
                                    color: Colors.blue[900],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (_key.currentState.validate()) {
                                    _key.currentState.save();
                                    setState(() {
                                      isLoading = true;
                                    });
                                    try {
                                      await _auth.signInwithEmail(
                                          email.trim(), password.trim());
                                      if (email == 'admin1@gmail.com' &&
                                          password == 'admin123') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AdminHomePage()));
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Bar()));
                                      }
                                      setState(() {
                                        isLoading = false;
                                      });
                                    } catch (e) {
                                      print(e);
                                    }

                                    print('$email,$password');
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(60, 0, 60, 0),
                                  child: Container(
                                    child: Center(
                                        child: Text(
                                      'SignIn',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    width: size.width * .3,
                                    height: size.height * .06,
                                    decoration: BoxDecoration(
                                        color: Colors.blue[900],
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(30, 0, 0, 5),
                                child: Row(
                                  children: [
                                    Text(
                                      'Don\'t have an account?',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, SignUp.id);
                                        },
                                        child: Text(
                                          'SignUp',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: size.width * .1,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage:
                                        AssetImage('images/gLogo.png'),
                                  ),
                                  SizedBox(
                                    width: size.width * .1,
                                  ),
                                  Text(
                                    '-OR-',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                  SizedBox(
                                    width: size.width * .1,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage:
                                        AssetImage('images/fLogo.png'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
