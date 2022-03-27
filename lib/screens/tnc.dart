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
            child: ListView(

              children: [

                Center(child: Text('About FiWi', style: DefaultValues.kH2(context),)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Text('FiWi is your Financial Planning Assistant which helps you build a plan for your golden future. It lets you manage your financial goals and then helps you track investments which help you achieve '
                      'those goals. For more information on how to use Fiwi – watch this video tutorial',style: DefaultValues.kNormal3(context) ),
                ),

                Center(child: Text('Version  1.0.0', style: DefaultValues.kH2(context),)),

                Center(child: Text('Revision History – ', style: DefaultValues.kH2(context),)),
                Center(child: Text('27 March 2022 - MVP Launched ', style: DefaultValues.kH2(context),)),
                Container(height: 5,width: double.infinity,color: kPresentTheme.alternateColor,),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Privacy Policy ', style: DefaultValues.kH2(context),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Text('Shubhadeep, Aravind, '
                      'Debashis built the FiWi app as an Ad Supported app. '
                      'This Product  is provided by Shubhadeep, Aravind, Debashis at no cost and is intended for use as is.'
                      ,style: DefaultValues.kNormal3(context) ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Text('This page is used to inform visitors regarding the policies with the collection, use, '
                      'and disclosure of Personal Information if anyone decides to use this Product.'
                      ,style: DefaultValues.kNormal3(context) ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Text('If you choose to use this Product, '
                      'then you agree to the collection and use of information in relation '
                      'to this policy. The Personal Information that we collect is used for '
                      'providing and improving the Product. We will not use or share your information '
                      'with anyone except as described in this Privacy Policy.'
                      ,style: DefaultValues.kNormal3(context) ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Text('The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, '
                      'which are accessible at FiWi unless otherwise defined in this Privacy Policy.'
                      ,style: DefaultValues.kNormal3(context) ),
                ),

                Center(child: Text('Information Collection and Use ', style: DefaultValues.kH2(context),)),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Text('For a better experience, while using our Product, we may require you to provide certain personally identifiable information, '
                      'including but not limited to Name, email, Date of Birth, Salary Range. '
                      ,style: DefaultValues.kNormal3(context) ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Text('The app does use third-party services that may collect information used to identify you.'
                      ,style: DefaultValues.kNormal3(context) ),
                ),


                Center(child: Text('Log Data', style: DefaultValues.kH2(context),)),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Text('We want to inform you that whenever you use this Product, '
                      'in case of an error in the app, We collect data and information '
                      '(through third-party products) on your phone called Log Data. '
                      'This Log Data may include information such as your device Internet Protocol (“IP”) '
                      'address, device name, operating system version, the configuration of the app when utilizing '
                      'this Product, the time and date of your use of the Product, and other statistics.'
                      ,style: DefaultValues.kNormal3(context) ),
                ),

                Center(child: Text('Cookies', style: DefaultValues.kH2(context),)),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Text("Cookies are files with a small amount of data that are "
                      'commonly used as anonymous unique identifiers. These are sent to your browser '
                      "from the websites that you visit and are stored on your device's internal memory."
                      'This Product does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect '
                      'information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. '
                      'If you choose to refuse our cookies, you may not be able to use some portions of this Product. '
                      ,style: DefaultValues.kNormal3(context) ),
                ),

                Center(child: Text('Service Providers', style: DefaultValues.kH2(context),)),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Text('We may employ third-party companies and individuals due to the following reasons:'
                      '*   To facilitate our Service;'
                  '*   To provide the Service on our behalf;'
                  '*   To perform Service-related services; or'
                  '*   To assist us in analyzing how our Product is used'
                  'We want to inform users of this Product that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. '
                      'However, they are obligated not to disclose or use the information for any other purpose.'
                      ,style: DefaultValues.kNormal3(context) ),
                ),

                Center(child: Text('Security', style: DefaultValues.kH2(context),)),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Text('We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.'
                      ,style: DefaultValues.kNormal3(context) ),
                ),

                Center(child: Text('Links to Other Sites', style: DefaultValues.kH2(context),)),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Text('This Product may contain links to other sites. If you click on a third-party link, '
                      'you will be directed to that site. Note that these external sites are not operated by us. '
                      'Therefore, we strongly advise you to review the Privacy Policy of these websites. '
                      'We have no control over and assume no responsibility'
                      ' for the content, privacy policies, or practices of any third-party sites or services.'
                      ,style: DefaultValues.kNormal3(context) ),
                ),

                Center(child: Text('Children’s Privacy', style: DefaultValues.kH2(context),)),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Text('This Product does not address anyone under the age of 13. '
                      'We do not knowingly collect personally identifiable information from children under 13 years of age. '
                      'In the case we discover that a child under 13 has provided us with personal information, '
                      'we immediately delete this from our servers. If you are a parent or guardian and you are aware '
                      'that your child has provided us with personal information, please contact us so that we will be able '
                      'to do the necessary actions.'
                      ,style: DefaultValues.kNormal3(context) ),
                ),

                Center(child: Text('Changes to This Privacy Policy', style: DefaultValues.kH2(context),)),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Text('We may update our Privacy Policy from time to time. '
                      'Thus, you are advised to review this page periodically for any changes. '
                      'We will notify you of any changes by posting the new Privacy Policy on this page.'
                      'This policy is effective as of 2022-01-02'

                      ,style: DefaultValues.kNormal3(context) ),
                ),


                Center(child: Text('Contact Us ', style: DefaultValues.kH2(context),)),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Text('If you have any questions or suggestions about the Privacy Policy, contact us at projdhanrashi@gmail.com'


                      ,style: DefaultValues.kNormal3(context) ),
                ),


                Center(child: Text('Terms & Conditions', style: DefaultValues.kH2(context),)),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Text('By downloading or using the app, these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the app. You are not allowed to copy or modify the app, any part of the app, or our trademarks in any way. You are not allowed to attempt to extract the source code of the app, and you also shouldn’t try to translate the app into other languages or make derivative versions. The app itself, and all the trademarks, copyright, database rights, and other '
                      'intellectual property rights related to it, still belong to Shubhadeep, Aravind, Debashis.'


                      ,style: DefaultValues.kNormal3(context) ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Text('Shubhadeep, Aravind, Debashis are committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, '
                      'at any time and for any reason. We will never charge you for the '
                      'app or its services without making it very clear to you exactly what you are paying for.'
                      'The FiWi app stores and processes personal data that you have provided to us, to provide these services. It is your responsibility to keep your phone and access to the app secure. We therefore recommend that you do not jailbreak or root your phone, which is the process of removing'


                      ,style: DefaultValues.kNormal3(context) ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Text('software restrictions and limitations imposed by the official operating system of your device. '
                      'It could make your phone vulnerable to malware/viruses/malicious programs, compromise your phone’s security '
                      'features and it could mean that the FiWi app won’t work properly or at all.'
                      'The app does use third-party services that declare their Terms and Conditions.'
                      'Link to Terms and Conditions of third-party service providers used by the app'



                      ,style: DefaultValues.kNormal3(context) ),
                ),

                Center(child: Text('Google Play Services', style: DefaultValues.kH2(context),)),
                Center(child: Text('Google Analytics for Firebase', style: DefaultValues.kH2(context),)),
                Center(child: Text('Firebase Crashlytics', style: DefaultValues.kH2(context),)),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Text('You should be aware that there are certain things that Shubhadeep, Aravind, Debashis will not take responsibility for. '
                      'Certain functions of the app will require the app to have an active internet connection. '
                      'The connection can be Wi-Fi or provided by your mobile network provider, but Shubhadeep, Aravind, Debashis '
                      'cannot take responsibility for the app not working at full functionality if you don’t have access to Wi-Fi, '
                      'and you don’t have any of your data allowance left.'
                      'If you are using the app outside of an area with Wi-Fi, you should remember that the terms of the agreement with your mobile network provider will still apply. As a result, '
                      'you may be charged by your mobile provider for the cost of data for the duration of the connection while '
                      'accessing the app, or other third-party charges. In using the app, you are accepting responsibility for any such '
                      'charges, including roaming data charges if you use the app outside of your home territory (i.e. region or country) '
                      'without turning off data roaming. If you are not the bill payer for the device on which you are using the app, please be '
                      'aware that we assume that you have received permission from the bill payer for using the app.'
                      'Along the same lines, Shubhadeep, Aravind, Debashis cannot always take responsibility for'
                      'the way you use the app i.e., You need to make sure that your device stays charged – if '
                      'it runs out of battery and you can’t turn it on to avail the Service, Shubhadeep, Aravind,'
                      'Debashis cannot accept responsibility.'
                     'With respect to Shubhadeep, Aravind, Debashis’s responsibility for your use of the app, '
                      'when you are using the app, it is important to bear in mind that although we endeavor to ensure that '
                      'it is updated and correct at all times, we do rely on third parties to provide information to us so that '
                      'we can make it available to you. Shubhadeep, Aravind, Debashis accepts no liability for any loss, direct or indirect, '
                      'you experience as a result of relying wholly on this functionality of the app.'
                    'At some point, we may wish to update the app. The app is currently available on Android & iOS – '
                      'the requirements for the both systems(and for any additional systems we decide to extend '
                      'the availability of the app to) may change, and you’ll need to download the updates if you want '
                      'to keep using the app. Shubhadeep, Aravind, Debashis does not promise that it will always update '
                      'the app so that it is relevant to you and/or works with the Android & iOS version that you have installed on your device. '
                      'However, you promise to always accept updates to the application when offered to you, We may also wish to stop providing '
                      'the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise,'
                      ' upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, '
                      'and (if needed) delete it from your device',style: DefaultValues.kNormal3(context) ),
                ),

                Center(child: Text('Changes to This Terms and Conditions', style: DefaultValues.kH2(context),)),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Text('We may update our Terms and Conditions from time to time. Thus, '
                      'you are advised to review this page periodically for any changes. We will notify you of any changes '
                      'by posting the new Terms and Conditions on this page.'
                      'These terms and conditions are effective as of 2022-01-02'




                      ,style: DefaultValues.kNormal3(context) ),
                ),

                Center(child: Text('Contact Us', style: DefaultValues.kH2(context),)),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Text('If you have any questions or suggestions about our Terms and Conditions, contact us at projdhanrashi@gmail.com..'




                      ,style: DefaultValues.kNormal3(context) ),
                ),
              ],

            )
          )
      ),
    );
  }
}


