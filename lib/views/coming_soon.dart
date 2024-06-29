import 'package:flutter/material.dart';
import 'package:movie_app/core/enums.dart';
import 'package:movie_app/core/extensions.dart';
import 'package:movie_app/core/paddings_borders.dart';

class ComingSoonMovies extends StatefulWidget {
  const ComingSoonMovies({super.key});

  @override
  State<ComingSoonMovies> createState() => _ComingSoonMoviesState();
}

class _ComingSoonMoviesState extends State<ComingSoonMovies> {
  final List<String> _movieTickets = ["Steamy", "Soapy", "Slow Burn", "Suspenseful", "Teen"];
  final List<MovieNameEnum> _notifiedMovie = [MovieNameEnum.batman, MovieNameEnum.game_of_thrones];
  @override
  Widget build(BuildContext context) {
    const comingMovie = MovieNameEnum.values;

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        children: [
          const ListTile(
            leading: Icon(Icons.notifications_active_outlined),
            title: Text("Notifications"),
          ),
          ..._notifiedMovie.map((movie) {
            return Padding(
              padding: PaddingBorderConstant.paddingVertical,
              child: ListTile(
                contentPadding: EdgeInsets.zero.copyWith(right: 10),
                tileColor: Colors.grey.shade900,
                title: Text(movie.name),
                subtitle: const Text(
                  "Nov 6",
                ),
                leading: Container(width: 150, color: Colors.red, child: Image.asset(fit: BoxFit.cover, movie.movieImage)),
              ),
            );
          }),
          ...comingMovie.map(
            (movie) {
              return Padding(
                padding: PaddingBorderConstant.paddingVerticalHigh,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      decoration:
                          BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage(movie.movieImage))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _notifiedMovie.contains(movie) ? _notifiedMovie.remove(movie) : _notifiedMovie.add(movie);
                            });
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.notifications,
                                  color: _notifiedMovie.contains(movie) ? Colors.amber : null,
                                ),
                                const Text("Remind Me")
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: PaddingBorderConstant.paddingAllHigh,
                          child: const Column(
                            children: [Icon(Icons.share), Text("Share")],
                          ),
                        )
                      ],
                    ),
                    const Padding(
                      padding: PaddingBorderConstant.paddingOnlyLeftMedium,
                      child: Text("Season 1 Coming December 14"),
                    ),
                    ListTile(
                      title: Text(movie.name.toUpperCase()),
                      subtitle: const Text(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          "Laboris officia enim officia laboris duis qui proident do consequat. Qui esse do Lorem magna est ipsum dolore esse laborum. Duis minim deserunt in laborum occaecat sint commodo voluptate elit minim qui. Aute id consectetur incididunt est proident deserunt tempor enim ea mollit ad qui. Ipsum enim commodo est est est qui mollit et ullamco nostrud aliqua. Ad laborum aliqua magna proident aliquip laboris sit non proident consequat do et qui. Fugiat exercitation sit tempor ut est."),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _buildMovieTicketWidgets(_movieTickets, context),
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
    )));
  }

  List<Widget> _buildMovieTicketWidgets(List<String> tickets, BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < tickets.length; i++) {
      widgets.add(
        Text(
          tickets[i],
          style: Theme.of(context).textTheme.titleSmall,
        ),
      );
      if (i < tickets.length - 1) {
        widgets.add(
          Text(
            '\u2022',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        );
      }
    }
    return widgets;
  }
}
