import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_smart_home_ui/pallete.dart';
import 'package:flutter_smart_home_ui/widgets/background-image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name, _email, _password;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (user != null) {
          // UserUpdateInfo updateuser = UserUpdateInfo();
          // updateuser.displayName = _name;
          //  user.updateProfile(updateuser);
          await _auth.currentUser.updateProfile(displayName: _name);
          // await Navigator.pushReplacementNamed(context,"/") ;

        }
      } catch (e) {
        showError(e.message);
        print(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Ошибка'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
        children: [
        BackgroundImage(image: 'assets/images/register_bg.png'),
    Scaffold(
    backgroundColor: Colors.transparent,
    body: SingleChildScrollView(
    child: Column(
    children: [
    SizedBox(
    height: size.width * 0.1,
    ),
    Stack(
    children: [
    Center(
    child: ClipOval(
    child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
    child: CircleAvatar(
    radius: size.width * 0.14,
    backgroundColor: Colors.grey[400].withOpacity(
    0.4,
    ),
    child: Icon(
    FontAwesomeIcons.user,
    color: kWhite,
    size: size.width * 0.1,
    ),
    ),
    ),
    ),
    ),
    Positioned(
    top: size.height * 0.08,
    left: size.width * 0.56,
    child: Container(
    height: size.width * 0.1,
    width: size.width * 0.1,
    decoration: BoxDecoration(
    color: kBlue,
    shape: BoxShape.circle,
    border: Border.all(color: kWhite, width: 2),
    ),
    child: Icon(
    FontAwesomeIcons.arrowUp,
    color: kWhite,
    ),
    ),
    )
    ],
    ),
    SizedBox(
    height: size.width * 0.1,
    ),
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) return 'Введите Имя';
                          },
                          decoration: InputDecoration(
                            labelText: 'Имя',
                            prefixIcon: Icon(Icons.person),
                          ),
                          onSaved: (input) => _name = input),
                    ),
                    Container(
                      child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) return 'Введите Email';
                          },
                          decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email)),
                          onSaved: (input) => _email = input),
                    ),
                    Container(
                      child: TextFormField(
                          validator: (input) {
                            if (input.length < 6)
                              return 'Введите как минимум 6 символов';
                          },
                          decoration: InputDecoration(
                            labelText: 'Пароль',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                          onSaved: (input) => _password = input),
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                      onPressed: signUp,
                      child: Text('Вход',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )]);
  }
}
