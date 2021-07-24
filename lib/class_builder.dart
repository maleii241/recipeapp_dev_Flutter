
import 'package:flutter_smart_home_ui/profile.dart';
import 'package:flutter_smart_home_ui/home.dart';
import 'package:flutter_smart_home_ui/search.dart';

import 'package:flutter_smart_home_ui/notifications.dart';
import 'package:flutter_smart_home_ui/search/home.dart';



typedef T Constructor<T>();

final Map<String, Constructor<Object>> _constructors = <String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor;
}

class ClassBuilder {
  static void registerClasses() {
    register<Home>(() => Home());
    register<Profile>(() => Profile());
    register<Notifications>(() => Notifications());
    register<HomeSearch>(() => HomeSearch());

  }

  static dynamic fromString(String type) {
    return _constructors[type]();
  }
}