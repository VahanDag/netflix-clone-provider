// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:movie_app/core/enums.dart';
import 'package:movie_app/core/extensions.dart';
import 'package:movie_app/core/paddings_borders.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/user_model.dart';
import 'package:movie_app/service/firebase_service.dart';
import 'package:movie_app/views/movie_watch.dart';
import 'package:provider/provider.dart';

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
            ElevatedButton(
                onPressed: () async {
                  // final model = MovieModel(
                  //     image: "https://fr.web.img5.acsta.net/pictures/19/06/18/12/11/3956503.jpg",
                  //     movieId: Random().nextInt(100) + 250,
                  //     name: "Breaking Bad",
                  //     youtubeId: "HhesaQXLuRY",
                  //     description:
                  //         "A high school chemistry teacher turned methamphetamine producer partners with a former student to secure his family's future.");
                  // await FirebaseFirestore.instance.collection("movies").doc(model.name).set(model.toMap());
                  final model = context.read<UserModel>();
                  print(model.email);
                  print(model.name);
                  print(model.movieList);
                },
                child: const Text("data")),
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
            const ShowMovies(
              sectionTitle: "Previews",
              isCircle: true,
            ),
            const ShowMovies(isCircle: false, sectionTitle: "Popular on Netflix"),
            const ShowMovies(isCircle: false, sectionTitle: "Trending Now")
          ],
        ),
      ),
    );
  }
}

class ShowMovies extends StatelessWidget {
  const ShowMovies({
    super.key,
    required this.isCircle,
    required this.sectionTitle,
  });
  final bool isCircle;
  final String sectionTitle;

  @override
  Widget build(BuildContext context) {
    final ref = context.read<FirebaseService>();

    return FutureBuilder(
      future: ref.fetchMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (snapshot.hasError) {
          return Center(child: Text("Something went wrong!", style: context.textTheme.titleLarge));
        } else if (snapshot.hasData) {
          final movies = snapshot.data;
          if (movies?.isEmpty ?? true) {
            return Center(child: Text("No Movies :(", style: context.textTheme.titleLarge));
          } else {
            movies!.shuffle();
            List<MovieModel> moviesModel = [];
            for (var movie in movies) {
              moviesModel.add(MovieModel.fromMap(movie.data() as Map<String, dynamic>));
            }

            return _movieSelections(
                selectionsTitle: sectionTitle, isCircle: isCircle, models: moviesModel, context: context);
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _movieSelections(
      {required List<MovieModel> models,
      required String selectionsTitle,
      bool? isCircle = false,
      required BuildContext context}) {
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
              itemCount: models.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieWatch(movieModel: models[index]),
                        ));
                  },
                  child: isCircle0
                      ? Padding(
                          padding: PaddingBorderConstant.paddingHorizontalMedium,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(models[index].image ?? ""),
                          ),
                        )
                      : Container(
                          margin: PaddingBorderConstant.paddingHorizontalMedium,
                          width: 125,
                          decoration: BoxDecoration(
                              image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(models[index].image ?? ""))),
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
