import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app/core/enums.dart';
import 'package:movie_app/core/extensions.dart';
import 'package:movie_app/core/paddings_borders.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieWatch extends StatefulWidget {
  const MovieWatch({super.key});

  @override
  State<MovieWatch> createState() => _MovieWatchState();
}

class _MovieWatchState extends State<MovieWatch> {
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'rlR4PJn8b8I',
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  bool _isClickPlay = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                        Image.asset(
                            height: 250,
                            width: context.deviceWidth,
                            fit: BoxFit.cover,
                            MovieNameEnum.game_of_thrones.movieImage),
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            color: Colors.black.withOpacity(0),
                          ),
                        ),
                        Image.asset(height: 250, width: 250, MovieNameEnum.game_of_thrones.movieImage),
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
                      "Nulla veniam do irure id reprehenderit tempor voluptate aute. Fugiat anim aliqua excepteur ea id aute nulla est cupidatat. Aliqua deserunt qui duis irure ex qui. Culpa eiusmod fugiat aute aliqua",
                      style: context.textTheme.titleSmall,
                    ),
                  ),
                  const Text(
                      "Anim do sint ut elit. Veniam sunt culpa dolore. Enim magna nisi deserunt esse adipisicing dolor exercitation"),
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
                              Image.asset(
                                MovieNameEnum.game_of_thrones.movieImage,
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
                                "$index. Winter is coming",
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
