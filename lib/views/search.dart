import 'package:flutter/material.dart';
import 'package:movie_app/core/enums.dart';
import 'package:movie_app/core/extensions.dart';
import 'package:movie_app/core/paddings_borders.dart';

class SearchMovie extends StatefulWidget {
  const SearchMovie({super.key});

  @override
  State<SearchMovie> createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchBar(
              hintText: "Search for a movie, show, series etc..",
              padding: WidgetStatePropertyAll(PaddingBorderConstant.paddingHorizontalHigh),
              leading: Icon(Icons.search),
              trailing: [Icon(Icons.keyboard_voice)],
            ),
            Padding(
              padding: PaddingBorderConstant.paddingOnlyTopHigh,
              child: Text(
                "Top Searches",
                style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: PaddingBorderConstant.paddingOnlyTop,
                itemCount: MovieNameEnum.values.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: PaddingBorderConstant.paddingVertical,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero.copyWith(right: 10),
                      tileColor: Colors.grey.shade900,
                      trailing: const Icon(Icons.play_circle_outline_outlined),
                      title: Text(MovieNameEnum.values[index].name),
                      leading: Container(
                          width: 150,
                          color: Colors.red,
                          child: Image.asset(fit: BoxFit.cover, MovieNameEnum.values[index].movieImage)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
