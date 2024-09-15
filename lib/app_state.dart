import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _accesstoken = prefs.getString('ff_accesstoken') ?? _accesstoken;
    });
    _safeInit(() {
      _songs = prefs.getStringList('ff_songs')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _songs;
    });
    _safeInit(() {
      _likedSongs = prefs.getStringList('ff_likedSongs')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _likedSongs;
    });
    _safeInit(() {
      _device = prefs.getString('ff_device') ?? _device;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _accesstoken = '';
  String get accesstoken => _accesstoken;
  set accesstoken(String value) {
    _accesstoken = value;
    prefs.setString('ff_accesstoken', value);
  }

  List<dynamic> _songs = [];
  List<dynamic> get songs => _songs;
  set songs(List<dynamic> value) {
    _songs = value;
    prefs.setStringList('ff_songs', value.map((x) => jsonEncode(x)).toList());
  }

  void addToSongs(dynamic value) {
    songs.add(value);
    prefs.setStringList('ff_songs', _songs.map((x) => jsonEncode(x)).toList());
  }

  void removeFromSongs(dynamic value) {
    songs.remove(value);
    prefs.setStringList('ff_songs', _songs.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromSongs(int index) {
    songs.removeAt(index);
    prefs.setStringList('ff_songs', _songs.map((x) => jsonEncode(x)).toList());
  }

  void updateSongsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    songs[index] = updateFn(_songs[index]);
    prefs.setStringList('ff_songs', _songs.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInSongs(int index, dynamic value) {
    songs.insert(index, value);
    prefs.setStringList('ff_songs', _songs.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _userInput = [];
  List<dynamic> get userInput => _userInput;
  set userInput(List<dynamic> value) {
    _userInput = value;
  }

  void addToUserInput(dynamic value) {
    userInput.add(value);
  }

  void removeFromUserInput(dynamic value) {
    userInput.remove(value);
  }

  void removeAtIndexFromUserInput(int index) {
    userInput.removeAt(index);
  }

  void updateUserInputAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    userInput[index] = updateFn(_userInput[index]);
  }

  void insertAtIndexInUserInput(int index, dynamic value) {
    userInput.insert(index, value);
  }

  List<dynamic> _likedSongs = [];
  List<dynamic> get likedSongs => _likedSongs;
  set likedSongs(List<dynamic> value) {
    _likedSongs = value;
    prefs.setStringList(
        'ff_likedSongs', value.map((x) => jsonEncode(x)).toList());
  }

  void addToLikedSongs(dynamic value) {
    likedSongs.add(value);
    prefs.setStringList(
        'ff_likedSongs', _likedSongs.map((x) => jsonEncode(x)).toList());
  }

  void removeFromLikedSongs(dynamic value) {
    likedSongs.remove(value);
    prefs.setStringList(
        'ff_likedSongs', _likedSongs.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromLikedSongs(int index) {
    likedSongs.removeAt(index);
    prefs.setStringList(
        'ff_likedSongs', _likedSongs.map((x) => jsonEncode(x)).toList());
  }

  void updateLikedSongsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    likedSongs[index] = updateFn(_likedSongs[index]);
    prefs.setStringList(
        'ff_likedSongs', _likedSongs.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInLikedSongs(int index, dynamic value) {
    likedSongs.insert(index, value);
    prefs.setStringList(
        'ff_likedSongs', _likedSongs.map((x) => jsonEncode(x)).toList());
  }

  String _device = 'no_device';
  String get device => _device;
  set device(String value) {
    _device = value;
    prefs.setString('ff_device', value);
  }

  String _userSelfInput = '';
  String get userSelfInput => _userSelfInput;
  set userSelfInput(String value) {
    _userSelfInput = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
