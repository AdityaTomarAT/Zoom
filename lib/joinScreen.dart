// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class JoiningScreen extends StatefulWidget {
//   @override
//   _JoiningScreenState createState() => _JoiningScreenState();
// }

// class _JoiningScreenState extends State<JoiningScreen> {
//   final TextEditingController meetingIdController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   void openZoomMeeting() async {
//     print('Inside the function');
//     String meetingId = meetingIdController.text.trim();
//     String password = passwordController.text.trim();

//     String url = "zoomus://zoom.us/join?confno=2343416002&pwd=LqhAK9R7NiJbqnRmta4zkB2aqYEtiH.1";

//     //zoomus://zoom.us/join?confno=2343416002&pwd=LqhAK9R7NiJbqnRmta4zkB2aqYEtiH.1

//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

// ignore_for_file: prefer_const_constructors

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Zoom Meeting Opener'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: meetingIdController,
//               decoration: InputDecoration(
//                 labelText: 'Meeting ID',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: passwordController,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//               ),
//             ),
//             SizedBox(height: 32.0),
//             ElevatedButton(
//               onPressed: openZoomMeeting,
//               child: Text('Open Zoom Meeting'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:typed_data';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:join_zoom/webView.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert';
import 'dart:math';
import 'package:cryptography/cryptography.dart';

class JoiningScreen extends StatefulWidget {
  @override
  _JoiningScreenState createState() => _JoiningScreenState();
}

class _JoiningScreenState extends State<JoiningScreen> {
  final TextEditingController meetingIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

 Future<void> openZoomMeeting() async {
    String meetingId = meetingIdController.text.trim();
    String password = passwordController.text.trim();

    bool isZoomInstalled = await DeviceApps.isAppInstalled('us.zoom.videomeetings');
    
    if (isZoomInstalled) {
      String url = "zoomus://zoom.us/join?confno=$meetingId&pwd=$password";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } else {
      String webUrl = "https://us05web.zoom.us/wc/join/$meetingId?pwd=$password";
        Get.to(() => WebViewScreen(), arguments: [webUrl]);
      } 
    }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: meetingIdController,
                decoration: InputDecoration(
                  labelText: 'Meeting ID',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: openZoomMeeting,
                child: Text('Open Zoom Meeting'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
