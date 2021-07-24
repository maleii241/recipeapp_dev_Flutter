import 'dart:async';
import 'dart:io';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class RecipeView extends StatefulWidget {
  final String postUrl;
  RecipeView({@required this.postUrl});

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {

  String finalUrl ;
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    {
      finalUrl = widget.postUrl.replaceAll("http://","https://");
      print(finalUrl + "this is final url");
    }


  }

  @override
  Widget build(BuildContext context) {

    return WebviewScaffold(
    url: finalUrl,
    );
  }
}