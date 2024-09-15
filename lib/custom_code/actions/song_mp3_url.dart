// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:http/http.dart' as http;

// Future<String> songMp3Url(String url) async {
//   // Parse the URL to extract query parameters
//   final uri = Uri.parse(url);

//   // Extract the item_id from the query parameters
//   String? itemId = uri.queryParameters['item_id'];

//   // Construct the new URL if item_id exists
//   if (itemId != null) {
//     return 'https://cdn1.suno.ai/$itemId.mp3';
//   } else {
//     return ''; // Return an empty string if item_id is not found
//   }
// }

Future<String> songMp3Url(String url) async {
  /// MODIFY CODE ONLY BELOW THIS LINE

  // Parse the URL to extract query parameters
  final uri = Uri.parse(url);

  // Extract the item_id from the query parameters
  String? itemId = uri.queryParameters['item_id'];

  // Construct the new URL if item_id exists
  if (itemId == null) {
    return ''; // Return an empty string if item_id is not found
  }

  final mp3Url = 'https://cdn1.suno.ai/$itemId.mp3';

  // Attempt to hit the URL 3 times
  int attempt = 0;
  int maxAttempts = 10;

  while (attempt < maxAttempts) {
    try {
      final response =
          await http.get(Uri.parse(mp3Url)); // Use await in async function

      if (response.statusCode == 200) {
        // Successful response, return the URL
        return mp3Url;
      } else if (response.statusCode == 403) {
        // Access denied, retry after a short delay
        attempt++;
        await Future.delayed(
            Duration(seconds: 15)); // Add a small delay before retrying
      } else {
        // Some other error occurred, break the loop
        break;
      }
    } catch (e) {
      // Handle any network errors
      print('Error accessing the URL: $e');
      break;
    }
  }

  // If all attempts fail, return an empty string
  return '';

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
