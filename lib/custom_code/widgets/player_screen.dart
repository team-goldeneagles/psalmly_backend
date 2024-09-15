// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({
    super.key,
    this.width,
    this.height,
    required this.musicUrl,
    required this.progressBarColor,
    required this.baseBarColor,
    required this.bufferedBarColor,
    required this.thumbColor,
    required this.fontSize,
    required this.fontColor,
  });

  final double? width;
  final double? height;
  final String musicUrl;
  final Color progressBarColor;
  final Color baseBarColor;
  final Color bufferedBarColor;
  final Color thumbColor;
  final double fontSize;
  final Color fontColor;

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  var player = AudioPlayer();
  bool loaded = false;
  bool playing = false;

  void loadMusic() async {
    await player.setUrl(widget.musicUrl);
    setState(() {
      loaded = true;
    });
  }

  void playMusic() async {
    setState(() {
      playing = true;
    });
    await player.play();
  }

  void pauseMusic() async {
    setState(() {
      playing = false;
    });
    await player.pause();
  }

  @override
  void initState() {
    loadMusic();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
            stream: player.positionStream,
            builder: (context, snapshot1) {
              final Duration duration = loaded
                  ? snapshot1.data as Duration
                  : const Duration(seconds: 0);
              return StreamBuilder(
                  stream: player.bufferedPositionStream,
                  builder: (context, snapshot2) {
                    final Duration bufferedDuration = loaded
                        ? snapshot2.data as Duration
                        : const Duration(seconds: 0);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ProgressBar(
                        progress: duration,
                        total: player.duration ?? const Duration(seconds: 0),
                        buffered: bufferedDuration,
                        timeLabelPadding: -1,
                        timeLabelTextStyle: TextStyle(
                            fontSize: (widget.fontSize),
                            color: (widget.fontColor),
                            fontFamily: 'Inter'),
                        progressBarColor: (widget.progressBarColor),
                        baseBarColor: (widget.baseBarColor),
                        bufferedBarColor: (widget.bufferedBarColor),
                        thumbColor: (widget.thumbColor),
                        onSeek: loaded
                            ? (duration) async {
                                await player.seek(duration);
                              }
                            : null,
                      ),
                    );
                  });
            }),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 35.0, 0.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: loaded
                      ? () async {
                          if (player.position.inSeconds >= 10) {
                            await player.seek(Duration(
                                seconds: player.position.inSeconds - 10));
                          } else {
                            await player.seek(const Duration(seconds: 0));
                          }
                        }
                      : null,
                  icon: Icon(
                    Icons.replay_10_rounded,
                    color: FlutterFlowTheme.of(context).primary,
                    size: 40.0,
                  )),
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.black),
                child: IconButton(
                    onPressed: loaded
                        ? () {
                            if (playing) {
                              pauseMusic();
                            } else {
                              playMusic();
                            }
                          }
                        : null,
                    icon: Icon(
                      playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                      color: Colors.white,
                    )),
              ),
              IconButton(
                  onPressed: loaded
                      ? () async {
                          if (player.position.inSeconds + 10 <=
                              player.duration!.inSeconds) {
                            await player.seek(Duration(
                                seconds: player.position.inSeconds + 10));
                          } else {
                            await player.seek(const Duration(seconds: 0));
                          }
                        }
                      : null,
                  icon: Icon(
                    Icons.forward_10_rounded,
                    color: FlutterFlowTheme.of(context).primary,
                    size: 40.0,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
