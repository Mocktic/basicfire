import 'package:firebase_auth/firebase_auth.dart';

import 'DynamicUrls.dart';

Future<void> signInWithEmailAndLink(String _userEmail) async {
  ActionCodeSettings authcode = new ActionCodeSettings(
    url: url,
    handleCodeInApp: true,
    iOSBundleId: isopackageName,
    androidInstallApp: false,
    androidPackageName: androidpackageName,
    dynamicLinkDomain: domain,
    androidMinimumVersion: "1",
  );
  await FirebaseAuth.instance
      .sendSignInLinkToEmail(email: _userEmail, actionCodeSettings: authcode);

  print("doe with it");
}
