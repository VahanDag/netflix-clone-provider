// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app/core/extensions.dart';
import 'package:movie_app/core/paddings_borders.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieWatch extends StatefulWidget {
  const MovieWatch({
    super.key,
    required this.movieModel,
  });
  final MovieModel movieModel;

  @override
  State<MovieWatch> createState() => _MovieWatchState();
}

class _MovieWatchState extends State<MovieWatch> {
  late final YoutubePlayerController _controller;
  late final MovieModel _model;

  @override
  void initState() {
    super.initState();
    _model = widget.movieModel;
    _controller = YoutubePlayerController(
      initialVideoId: _model.youtubeId ?? 'rlR4PJn8b8I',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  bool _isClickPlay = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_model.name ?? ""),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              child: _isClickPlay
                  ? YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.amber,
                      progressColors: const ProgressBarColors(
                        playedColor: Colors.amber,
                        handleColor: Colors.amberAccent,
                      ),

                      // onReady: () {
                      //   _controller.addListener(
                      //     () {
                      //       print("eee");
                      //     },
                      //   );
                      // },
                      onEnded: (metaData) {
                        setState(() {
                          _isClickPlay = false;
                        });
                      },
                    )
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.network(height: 250, width: context.deviceWidth, fit: BoxFit.cover, _model.image ?? ""),
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            color: Colors.black.withOpacity(0),
                          ),
                        ),
                        Image.network(height: 250, width: 250, _model.image ?? ""),
                      ],
                    ),
            ),
            SizedBox(
              width: context.deviceWidth * 0.9,
              child: Column(
                children: [
                  if (!_isClickPlay)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isClickPlay = true;
                        });
                      },
                      child: Container(
                        margin: PaddingBorderConstant.paddingVerticalHigh,
                        alignment: Alignment.center,
                        width: context.deviceWidth * 0.75,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: PaddingBorderConstant.borderRadius,
                          color: Colors.red,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.play_arrow_rounded),
                            Text(
                              "Play",
                              style: context.textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  Padding(
                    padding: PaddingBorderConstant.paddingVertical,
                    child: Text(
                      maxLines: 3,
                      _model.description ?? "",
                      style: context.textTheme.titleSmall,
                    ),
                  ),
                  Padding(
                    padding: PaddingBorderConstant.paddingVerticalHigh,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: const Column(
                            children: [Icon(Icons.add), Text("My List")],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Column(
                            children: [Icon(Icons.thumb_up_off_alt), Text("Rate")],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Column(
                            children: [Icon(Icons.send_rounded), Text("Share")],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(onPressed: () {}, child: Text("Episodes".toUpperCase())),
                      TextButton(onPressed: () {}, child: Text("trailers & more".toUpperCase()))
                    ],
                  ),
                  Align(alignment: Alignment.centerLeft, child: Text("Season 1", style: context.textTheme.titleMedium)),
                  ...List.generate(
                    5,
                    (index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Row(
                          children: [
                            Stack(alignment: Alignment.center, children: [
                              Image.network(
                                _model.image ?? "",
                                height: 90,
                              ),
                              const Icon(
                                Icons.play_circle_outlined,
                                size: 35,
                              )
                            ]),
                            Padding(
                              padding: PaddingBorderConstant.paddingOnlyLeftMedium,
                              child: Text(
                                "$index. ${_model.name}",
                                style: context.textTheme.bodyMedium,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
