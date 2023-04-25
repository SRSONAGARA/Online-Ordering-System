import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseApiCalling extends ChangeNotifier{
  Future<void> sendPushNotification(String title, String msg) async {
    final prefs = await SharedPreferences.getInstance();
    String? fcmToken = prefs.getString('fcmToken');
    try {
      final body = {
        "to": fcmToken,
        "notification": {
          "title": title, //our name should be send
          "body": msg,
          "android_channel_id": "OnlineOrderingsystem"
        },
        // "data": {
        //   "some_data": "User ID: ${me.id}",
        // },
      };

      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
            'key=AAAAXT-OWaI:APA91bEtaOlPAd2eJjBah2IQ1qo7b-QOieJ42PSof1dNE4a4PH4i-9KnLYPs7vRMA2M6HkqWavHQiVZ-_tkjbqhmAHofCyHEsP88aNSUqHnlyVTGPSe02RFSSC5sIIa23dNN5D324PKG'
          },
          body: jsonEncode(body));
      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
    notifyListeners();
  }
}