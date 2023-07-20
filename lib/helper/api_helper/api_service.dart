import 'dart:convert';

import 'package:fsm_employee/main.dart';
import 'package:get/get.dart';

class ApiService extends GetConnect {
  final String _BASE_URL = "https://thedooapp.in/api/";

  Future<Response<dynamic>> callApi(
      String endPoint, ApiType apiType, String? userToken,
      {dynamic body}) async {
    Get.log("--------------------");
    Get.log(
        "URL : $_BASE_URL$endPoint , body : ${body != null ? jsonEncode(body) : 'NA'}");
    if (true) {
      switch (apiType) {
        case ApiType.GET:
          Response<dynamic> responseJson;
          try {
            final response = await get(
              "$_BASE_URL$endPoint",
              headers: {
                'content-type': 'application/json',
                if (userToken != null && userToken.isNotEmpty)
                  'Authorization': 'Bearer $userToken'
              },
            );
            Get.log(
                "URL : $_BASE_URL$endPoint , response : ${jsonEncode(response.body)}");
            if (response.body != null) {
              return response;
            } else {
              return callApi(endPoint, apiType, userToken, body: body);
            }
          } on Exception {
            return callApi(endPoint, apiType, userToken, body: body);
            // throw FetchDataException('No Internet connection');
          }

        case ApiType.POST:
          Response<dynamic> responseJson;
          try {
            final response = await post(
              "$_BASE_URL$endPoint",
              body ?? {},
              headers: {
                'content-type': 'application/json',
                if (userToken != null && userToken.isNotEmpty)
                  'Authorization': 'Bearer $userToken'
              },
            );
            Get.log(
                "URL : $_BASE_URL$endPoint , response : ${jsonEncode(response.body)}");
            if (response.body != null) {
              return response;
            } else {
              return callApi(endPoint, apiType, userToken, body: body);
            }
          } on Exception {
            return callApi(endPoint, apiType, userToken, body: body);

            // throw FetchDataException('No Internet connection');
          }
      }
    }
  }

  Future<bool> sendPushNotification(String title, String body,String email)async{
    try {
      final response = await post(
        "https://fcm.googleapis.com/fcm/send",
        {
          "to": "/topics/leave",
          "notification": {
            "title": title,
            "body": body,
            "mutable_content": true,
            "sound": "Tri-tone"
          },
          "data": {
            "user_email": email,
          }
        },
        headers: {
          'content-type': 'application/json',
          'Authorization': 'key=AAAAjQXvb6I:APA91bEVb-IVkcdR772_6KaLOjA-3t4ZmicvU8kc1xffgsyAnswYNqt8aj4a3dYiX5L0CcIZbAS9NfX6WJpOpWvxbYZjt-Gj2TgQgVAuGpo3UWGDoUwnV8GNsmdj0iCpG8YDyBSu_7qe'

        },
      );
      Get.log(
          "URL : https://fcm.googleapis.com/fcm/send , response : ${jsonEncode(response.body)}");
      if (response.body != null) {
        return true;
      } else {
        return false;
      }
    } on Exception {
      return false;

    }
  }
  Future<bool> sendPushNotificationToAdmin(String title, String body,String email)async{

    var tokens = await firebaseHelper.getAdminTokens();

    try {
      final response = await post(
        "https://fcm.googleapis.com/fcm/send",
        {
          "registration_ids": tokens,
          "notification": {
            "title": title,
            "body": body,
            "mutable_content": true,
            "sound": "Tri-tone"
          },
          "data": {
            "user_email": email,
          }
        },
        headers: {
          'content-type': 'application/json',
          'Authorization': 'key=AAAAjQXvb6I:APA91bEVb-IVkcdR772_6KaLOjA-3t4ZmicvU8kc1xffgsyAnswYNqt8aj4a3dYiX5L0CcIZbAS9NfX6WJpOpWvxbYZjt-Gj2TgQgVAuGpo3UWGDoUwnV8GNsmdj0iCpG8YDyBSu_7qe'

        },
      );
      Get.log(
          "URL : https://fcm.googleapis.com/fcm/send , response : ${jsonEncode(response.body)}");
      if (response.body != null) {
        return true;
      } else {
        return false;
      }
    } on Exception {
      return false;

    }
  }

}

enum ApiType {
  GET,
  POST,
}
