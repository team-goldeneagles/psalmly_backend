import 'dart:convert';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GenerateMusicCall {
  static Future<ApiCallResponse> call({
    dynamic moodJson,
    String? date = '',
    String? device = '',
    String? userInput = '',
  }) async {
    final mood = _serializeJson(moodJson, true);
    final ffApiRequestBody = '''
{
  "date": "$date",
  "device": "$device",
  "mood": [
    $mood
  ],
  "ACCESS_TOKEN": "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyM1BLWFkiLCJzdWIiOiJCUEtHTjYiLCJpc3MiOiJGaXRiaXQiLCJ0eXAiOiJhY2Nlc3NfdG9rZW4iLCJzY29wZXMiOiJyc29jIHJzZXQgcm94eSBybnV0IHJwcm8gcnNsZSByYWN0IHJsb2MgcnJlcyByd2VpIHJociBydGVtIiwiZXhwIjoxNzU2ODQ3NjA3LCJpYXQiOjE3MjUzMTE2MDd9.hbEVe4UEdlMydDT0DWIlz9uctOm1qxoYa3ByAteru_8",
  "user_input": "$userInput"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Generate Music',
      apiUrl: 'https://psalmly.onrender.com/generate_music',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? audioUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.audio_url''',
      ));
  static String? imageUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.image_url''',
      ));
  static String? lyrics(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.lyrics''',
      ));
  static String? genre(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.tags''',
      ));
  static String? title(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.title''',
      ));
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
