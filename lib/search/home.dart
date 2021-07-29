import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_home_ui/search/recipe_view.dart';
import 'package:http/http.dart' as http;
import 'package:kf_drawer/kf_drawer.dart';

import 'package:url_launcher/url_launcher.dart';

import '../shared.dart';
import 'models/recipe_model.dart';

class HomeSearch extends KFDrawerContent {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeSearch> {
  List<RecipeModel> recipies = new List();
  String ingridients;
  bool _loading = false;
  String query = "";
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
              child: Material(
                shadowColor: Colors.transparent,
                color: Colors.transparent,
                child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  onPressed: widget.onMenuPressed,
                ),
              ),
            ),
            Spacer(),
            Column(children: [


              buildTextTitleVariation1('RecipeApp dev.'),
            ]),
            Spacer(),
              ],
    ),
      ),

    body: Stack(
    children: <Widget>[
    Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
    gradient: LinearGradient(
    colors: [
    const Color(0xff1d3e09),
    const Color(0xff0d5926)
    ],
    begin: FractionalOffset.topRight,
    end: FractionalOffset.bottomLeft)),
    ),
    SingleChildScrollView(
    child: Container(
    padding: EdgeInsets.symmetric(vertical: !kIsWeb ? Platform.isIOS? 60: 30 : 30, horizontal: 24),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    Row(
    mainAxisAlignment: kIsWeb
    ? MainAxisAlignment.start
        : MainAxisAlignment.center,

    ),
    SizedBox(
    height: 10,
    ),
    Text(
    "Что вы планируете приготовить?",
    style: TextStyle(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.w400,
    fontFamily: 'Overpass'),
    ),
    Text(
    "Просто введите ингредиенты на английском языке, которые у вас есть, и мы покажем вам лучшие рецепты",
    style: TextStyle(
    fontSize: 15,
    color: Colors.white,
    fontWeight: FontWeight.w300,
    fontFamily: 'OverpassRegular'),
    ),
    SizedBox(
    height: 20,
    ),
    Container(
    child: Row(
    children: <Widget>[
    Expanded(
    child: TextField(
    controller: textEditingController,
    style: TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontFamily: 'Overpass'),
    decoration: InputDecoration(
    hintText: "Введите ингредиенты",
    hintStyle: TextStyle(
    fontSize: 16,
    color: Colors.white.withOpacity(0.5),
    fontFamily: 'Overpass'),
    enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    ),
    ),
    ),
    ),
    SizedBox(
    width: 16,
    ),
    InkWell(
    onTap: () async {
    if (textEditingController.text.isNotEmpty) {
    setState(() {
    _loading = true;
    });
    recipies = new List();
    String url =
    "https://api.edamam.com/search?q=${textEditingController.text}&app_id=4599dfa6&app_key=2aa046b5e2bb012129e60e67d0f3acb1";
    var response = await http.get(Uri.parse(url));
    print(" $response this is response");
    Map<String, dynamic> jsonData =
    jsonDecode(response.body);
    print("this is json Data $jsonData");
    jsonData["hits"].forEach((element) {
    print(element.toString());
    RecipeModel recipeModel = new RecipeModel();
    recipeModel =
    RecipeModel.fromMap(element['recipe']);
    recipies.add(recipeModel);
    print(recipeModel.url);
    });
    setState(() {
    _loading = false;
    });

    print("doing it");
    } else {
    print("not doing it");
    }
    },
    child: Container(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    gradient: LinearGradient(
    colors: [
    const Color(0xfffff714),
    const Color(0xffad6500)
    ],
    begin: FractionalOffset.topRight,
    end: FractionalOffset.bottomLeft)),
    padding: EdgeInsets.all(8),
    child: Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
    Icon(
    Icons.search,
    size: 20,
    color: Colors.white
    ),
    ],
    ),
    )),
    ],
    ),
    ),
    SizedBox(
    height: 30,
    ),
    Container(
    child: GridView(
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    mainAxisSpacing: 10.0, maxCrossAxisExtent: 200.0),
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    physics: ClampingScrollPhysics(),
    children: List.generate(recipies.length, (index) {
    return GridTile(
    child: RecipieTile(
    title: recipies[index].label,
    imgUrl: recipies[index].image,
    desc: recipies[index].source,
    url: recipies[index].url,
    ));
    })),
    ),
    ],
    ),
    ),
    )
    ],
    ),
    );
  }
}

class RecipieTile extends StatefulWidget {
  final String title, desc, imgUrl, url;

  RecipieTile({this.title, this.desc, this.imgUrl, this.url});

  @override
  _RecipieTileState createState() => _RecipieTileState();
}

class _RecipieTileState extends State<RecipieTile> {
  _launchURL(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (kIsWeb) {
              _launchURL(widget.url);
            } else {
              print(widget.url + " this is what we are going to see");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecipeView(
                        postUrl: widget.url,
                      )));
            }
          },
          child: Container(
            margin: EdgeInsets.all(8),
            child: Stack(
              children: <Widget>[
                Image.network(
                  widget.imgUrl,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 200,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white30, Colors.white],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                              fontFamily: 'Overpass'),
                        ),
                        Text(
                          widget.desc,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black54,
                              fontFamily: 'OverpassRegular'),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class GradientCard extends StatelessWidget {
  final Color topColor;
  final Color bottomColor;
  final String topColorCode;
  final String bottomColorCode;

  GradientCard(
      {this.topColor,
        this.bottomColor,
        this.topColorCode,
        this.bottomColorCode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [topColor, bottomColor],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight)),
                ),
                Container(
                  width: 160,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white30, Colors.white],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          topColorCode,
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        Text(
                          bottomColorCode,
                          style: TextStyle(fontSize: 16, color: bottomColor),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
