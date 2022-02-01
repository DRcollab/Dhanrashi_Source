import 'package:dhanrashi_mvp/components/constants.dart';
import 'package:dhanrashi_mvp/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TnC extends StatefulWidget {

  @override
  State<TnC> createState() => _TnCState();
}

class _TnCState extends State<TnC> {
//

late WebViewController _controller;


@override
  void initState() {
    // TODO: implement initState

  WebView.platform  = AndroidWebView();


  }

  _goback(){
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _goback(),


      child: CustomScaffold(
          rightButton: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 7.h),
            child: WebView(
              onWebViewCreated: (controller){
                _controller = controller;
              },
              onPageStarted: (url){
                _controller.runJavascript(
                      "document.getElementsById('docs-titlebar-container').style.display='none'"
                );
              },
              zoomEnabled: true,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: 'https://docs.google.com/document/d/1-JIDrxX4s--lFPNBqM-7W7H-af4_NR_o/edit?usp=sharing&ouid=103366263473702923059&rtpof=true&sd=true',
            ),
          )
      ),
    );
  }
}


