import 'package:flutter/material.dart';
import 'package:movie_app/core/enums.dart';
import 'package:movie_app/core/extensions.dart';
import 'package:movie_app/core/paddings_borders.dart';
import 'package:movie_app/views/movie_watch.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const List<MovieNameEnum> _movies = MovieNameEnum.values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 325,
                  decoration: const BoxDecoration(
                      image:
                          DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/movies/game_of_thrones.png"))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(height: 50, child: Image.asset("assets/images/netflix.webp")),
                      TextButton(onPressed: () {}, child: const Text("TV Shows")),
                      TextButton(onPressed: () {}, child: const Text("Movies")),
                      TextButton(onPressed: () {}, child: const Text("My List")),
                    ],
                  ),
                ),
              ],
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
                  Container(
                    padding: PaddingBorderConstant.paddingAll,
                    decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(10)),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                        ),
                        Text(
                          "Play",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Column(
                      children: [Icon(Icons.info_outline), Text("Info")],
                    ),
                  ),
                ],
              ),
            ),
            _movieSelections(selectionsTitle: "Previews", isCircle: true),
            _movieSelections(selectionsTitle: "Popular on Netflix"),
            _movieSelections(selectionsTitle: "Trending Now"),
          ],
        ),
      ),
    );
  }

  Widget _movieSelections({
    required String selectionsTitle,
    bool? isCircle = false,
  }) {
    bool isCircle0 = (isCircle != null && isCircle == true);
    return Padding(
      padding: PaddingBorderConstant.paddingVerticalHigh,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: PaddingBorderConstant.paddingOnlyLeft,
            child: Text(
              selectionsTitle,
              style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: PaddingBorderConstant.paddingVertical,
            height: isCircle0 ? 100 : 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _movies.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MovieWatch(),
                        ));
                  },
                  child: isCircle0
                      ? Padding(
                          padding: PaddingBorderConstant.paddingHorizontalMedium,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(_movies[index].movieImage),
                          ),
                        )
                      : Container(
                          margin: PaddingBorderConstant.paddingHorizontalMedium,
                          width: 125,
                          decoration: BoxDecoration(
                              image: DecorationImage(fit: BoxFit.cover, image: AssetImage(_movies[index].movieImage))),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
