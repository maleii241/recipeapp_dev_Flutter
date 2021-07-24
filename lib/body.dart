import 'package:flutter/material.dart';
import 'package:flutter_smart_home_ui/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'info.dart';
import 'profile_menu_item.dart';

class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Info(
            image: "images/IMG_20210524_133958.jpg",
            name: "Никита малей",
            email: "malei24102000@mail.ru",
          ),
          SizedBox(height: SizeConfig.defaultSize * 2), //20
          ProfileMenuItem(
            iconSrc: "assets/icons/heart_fill.svg",
            title: "Избранное",
            press: () {},
          ),
          ProfileMenuItem(
            iconSrc: "assets/icons/chef_nav.svg",
            title: "Super Plan",
            press: () {},
          ),
          ProfileMenuItem(
            iconSrc: "assets/icons/language.svg",
            title: "Смена языка",
            press: () {},
          ),
          ProfileMenuItem(
            iconSrc: "assets/icons/info.svg",
            title: "Помощь",
            press: () {},
          ),
        ],
      ),
    );
  }
}
