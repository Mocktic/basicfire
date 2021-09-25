// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:google_sign_in/google_sign_in.dart';
// import "package:http/http.dart" as http;
// import 'dart:convert';
// import 'package:sendgrid_mailer/sendgrid_mailer.dart';

// GoogleSignIn googleSignIn = new GoogleSignIn(
//   scopes: <String>['https://www.googleapis.com/auth/gmail.send'],
// );

// Future<Null> handleSignOut() async {
//   googleSignIn.disconnect();
// }

// class LoginPage extends StatefulWidget {
//   @override
//   LoginPageState createState() => new LoginPageState();
// }

// class LoginPageState extends State<LoginPage> {
//   Future<Null> testingEmail(String userId, Map header) async {
//     header['Accept'] = 'application/json';
//     header['Content-type'] = 'application/json';

//     var from = userId;
//     var to = userId;
//     var subject = 'test send email';
//     //var message = 'worked!!!';
//     var message = "Hi<br/>Html Email";
//     var content = '''
// Content-Type: text/html; charset="us-ascii"
// MIME-Version: 1.0
// Content-Transfer-Encoding: 7bit
// to: ${to}
// from: ${from}
// subject: ${subject}
// ${message}''';

//     var bytes = utf8.encode(content);
//     var base64 = base64Encode(bytes);
//     var body = json.encode({'raw': base64});

//     String url = 'https://www.googleapis.com/gmail/v1/users/' +
//         userId +
//         '/messages/send';

//     final http.Response response =
//         await http.post(Uri.parse(url), headers: header, body: body);
//     if (response.statusCode != 200) {
//       setState(() {
//         print('error: ' + response.statusCode.toString());
//         print(url);
//         print(json.decode(response.body));
//       });
//       return;
//     }
//     final Map<String, dynamic> data = json.decode(response.body);
//     print('ok: ' + response.statusCode.toString());
//     print(data);
//   }

//   @override
//   Widget build(BuildContext context) {
//     var assetImage = new AssetImage('assets/google-g-logo.png');
//     var image = new Image(image: assetImage, width: 96.0, height: 96.0);

//     var loginPage = new Scaffold(
//         backgroundColor: Colors.pink[400],
//         body: new Center(
//             child: new Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             new Material(
//                 color: Colors.white,
//                 type: MaterialType.circle,
//                 elevation: 6.0,
//                 child: new GestureDetector(
//                   child: new Container(
//                       width: 112.0,
//                       height: 112.0,
//                       child: new InkWell(
//                         onTap: () async {
//                           try {
//                             // await googleSignIn.signIn().then((data) {
//                             //   data.authHeaders.then((result) {
//                             //     var header = {
//                             //       'Authorization': result['Authorization'],
//                             //       'X-Goog-AuthUser': result['X-Goog-AuthUser']
//                             //     };
//                             //     testingEmail(data.email, header);
//                             //   });
//                             // });
//                             SendGridUtil.send();
//                             SendGridUtil.sendRegistrationNotification("");
//                           } catch (error) {
//                             print(error);
//                           }
//                         },
//                         child: new Center(child: image),
//                       )),
//                 )),
//             new Container(
//               margin: new EdgeInsets.only(top: 16.0),
//               child: new Text(
//                 'Sign up with Google',
//                 style: new TextStyle(
//                     color: Colors.white, fontFamily: "Futura", fontSize: 18.0),
//               ),
//             ),
//           ],
//         )));

//     return loginPage;
//   }
// }

// class SendGridUtil {
//   static send() {
//     String api =
//         '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';
//     final mailer = Mailer('api');
//     final toAddress = Address('deveshgarg9829@gmail.com');
//     final fromAddress = Address('deveshgarg9829@gmail.com');
//     final content = Content('text/plain', 'Hello World!');
//     final subject = 'Hello Subject!';
//     final personalization = Personalization([toAddress]);

//     final email =
//         Email([personalization], fromAddress, subject, content: [content]);
//     mailer.send(email).then((result) {
//       print(result.isError);
//     });
//   }

//   static sendRegistrationNotification(String email) async {
//     email = "Devesh <deveshgarg9829@gmail.com>";
//     print("processing started");
//     String api =
//         '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';
//     Map<String, String> headers = new Map();
//     headers["Authorization"] = "$api";
//     headers["Content-Type"] = "application/json";

//     var url = 'https://api.sendgrid.com/v3/mail/send';
//     print("sending response");
//     var response = await http.post(Uri.parse(url),
//         headers: headers,
//         body: json.encode({
//           "to": '$email', // Change to your recipient
//           "from": '$email', // Change to your verified sender
//           "subject": 'Sending with SendGrid is Fun',
//           "text": 'and easy to do anywhere, even with Node.js',
//           "html": '<strong>and easy to do anywhere, even with Node.js</strong>',
//         }));

//     print('Response status: ${response.statusCode}');
//     print('Response body: ${response.body}');
//   }
// }
// // smtps://apikey:SG.yGSrBZ-UQlurwCQMl5A3DQ.-0xDYLVLn9v4oecmewAzL-tl5wUypEwU0KAu3dbCYn@smtp.sendgrid.net:465
// // https://medium.com/firebase-developers/firebase-extension-trigger-email-5802800bb9ea