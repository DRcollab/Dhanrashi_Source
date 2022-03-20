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

//late WebViewController _controller = WebViewController;


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
               // _controller = controller;
              },
              onPageStarted: (url){
                //_controller.runJavascript(
                   //   "document.getElementsById('docs-titlebar-container').style.display='none'"
               // );
              },
              zoomEnabled: true,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: 'file:////images/profiles/AG_profile3.png'
              //'https://drive.google.com/file/d/18HC33dZhcy8hh3Ji03BezdaH-phj3KiJ/view?usp=sharing',
            ),
          )
      ),
    );
  }
}


