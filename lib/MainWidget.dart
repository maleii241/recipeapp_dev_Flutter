import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_smart_home_ui/profile.dart';
import 'package:flutter_smart_home_ui/search/home.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:flutter_smart_home_ui/body.dart';
import 'api/local_auth_api.dart';
import 'class_builder.dart';
import 'home.dart';

class MainWidget extends StatefulWidget {
  MainWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("start");
      }
    });
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
        final isAuthenticated = LocalAuthApi.authenticate();
      });
    }
  }

  signOut() async {
    _auth.signOut();

    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  KFDrawerController _drawerController;

  @override
  void initState() {
    super.initState();

    this.checkAuthentification();
    this.getUser();


    _drawerController = KFDrawerController(
      initialPage: ClassBuilder.fromString('Home'),
      items: [
        KFDrawerItem.initWithPage(
          text: Text('Главная',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          icon: Icon(Icons.home, color: Colors.white),
          page: Home(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Профиль',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          icon: Icon(Icons.account_box, color: Colors.white),
          page: Profile(),
        ),

        KFDrawerItem.initWithPage(
          text: Text(
            'Поиск по продуктам',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          icon: Icon(Icons.youtube_searched_for_sharp, color: Colors.white),
          page: HomeSearch(),
        ),


        KFDrawerItem.initWithPage(
          text: Text(
            'Видео',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          icon: Icon(Icons.video_call, color: Colors.white),
          page: ClassBuilder.fromString('Notifications'),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Выход',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          icon: Icon(Icons.settings, color: Colors.white),
          onPressed: signOut,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KFDrawer(
        controller: _drawerController,
        header: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
              children: <Widget>[
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                          image: AssetImage('images/IMG_20210524_133958.jpg'),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    new Text('${user.displayName}',
                        style:
                            new TextStyle(fontSize: 17, color: Colors.white)),
                    new SizedBox(height: 2),
                    new Text('${user.email}',
                        style: new TextStyle(fontSize: 15, color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
        ),
        footer: KFDrawerItem(
          text: Text(
            'Developer version',
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(31, 58, 47, 1.0),
              Color.fromRGBO(31, 58, 47, 1.0)
            ],
            tileMode: TileMode.repeated,
          ),
        ),
      ),
    );
  }
}
