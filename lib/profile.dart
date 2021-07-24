import 'package:flutter/material.dart';
import 'package:flutter_smart_home_ui/size_config.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:flutter_smart_home_ui/body.dart';
import 'constants.dart';

class Profile extends KFDrawerContent {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(),
      body: Body()
    );

  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      leading: SizedBox(),
      // On Android it's false by default
      centerTitle: true,
      title: Text("Профиль"),
      actions: <Widget>[
        Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(36.0)),
              child: Material(
                shadowColor: Colors.transparent,
                color: Colors.transparent,
                child: IconButton(
                  icon: Icon(Icons.home, color: Colors.white),
                  onPressed: widget.onMenuPressed,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}