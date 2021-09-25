import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http_auth/http_auth.dart';

class PaypalServices {
  String domain = "https://api.sandbox.paypal.com"; // for sandbox mode
//  String domain = "https://api.paypal.com"; // for production mode

  // change clientId and secret with your own, provided by paypal
  String clientId =
      'AVxP-82hShL9BGI-tPf7WSpgszsianq_E5HDVY3zcHlBBLIsY4jL6mgKk7sj8Vfgbbdb-6Afa3mrjJbj';
  String secret =
      'EPgb652tE5SC4Vlt-4S-F0iLBTPxI6VUeoVBJ8nIFL0vh-w35BM0qzun7uFwLyV7Ck_DgcOs4JwGr0KW';

  // for getting the access token from Paypal
  Future<String> getAccessToken() async {
    try {
      var client = BasicAuthClient(clientId, secret);
      var response = await client.post(
          Uri.parse('$domain/v1/oauth2/token?grant_type=client_credentials'));
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        return body["access_token"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // for creating the payment request with Paypal
  Future<Map<String, String>> createPaypalPayment(
      transactions, accessToken) async {
    try {
      var response = await http.post(Uri.parse("$domain/v1/payments/payment"),
          body: convert.jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
        return null;
      } else {
        throw Exception(body["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  // for executing the payment transaction
  Future<String> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(url,
          body: convert.jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        final data = await FirebaseDatabase.instance
            .reference()
            .child("UserInformation")
            .child(FirebaseAuth.instance.currentUser.uid)
            .once();
        double privAmount = 0.0;
        if (data != null) {
          if (data.value['amount'] != null) {
            privAmount = double.parse(data.value['amount']);
          }
          //....

        }

        FirebaseDatabase.instance
            .reference()
            .child("UserInformation")
            .child(FirebaseAuth.instance.currentUser.uid)
            .update({
          "amount": (privAmount + double.parse("1")).toStringAsFixed(2)
        });
        return body["id"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
