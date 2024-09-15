// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<String> fitBitAccessToken(String url) async {
  // Parse the URL to extract query parameters
  final uri = Uri.parse(url);

  // Since the token is in the fragment (after '#'), we need to extract it manually
  String fragment = uri.fragment;

  // Split the fragment into key-value pairs
  Map<String, String> params = Uri.splitQueryString(fragment);

  // Access and return the access token
  String? accessToken = params['access_token'];

  // Return the access token or an empty string if not found
  return accessToken ?? '';
}
