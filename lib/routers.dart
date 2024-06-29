import 'package:flutter/material.dart';
import 'package:movie_app/views/coming_soon.dart';
import 'package:movie_app/views/downloaded_movie.dart';
import 'package:movie_app/views/home.dart';
import 'package:movie_app/views/more.dart';
import 'package:movie_app/views/search.dart';

class Routers extends StatefulWidget {
  const Routers({super.key});

  @override
  State<Routers> createState() => _RoutersState();
}

class _RoutersState extends State<Routers> {
  final List<BottomNavigationBarItem> _items = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
    const BottomNavigationBarItem(icon: Icon(Icons.movie_creation_outlined), label: "Coming Soon"),
    const BottomNavigationBarItem(icon: Icon(Icons.download_outlined), label: "Downloads"),
    const BottomNavigationBarItem(icon: Icon(Icons.line_weight_sharp), label: "More"),
  ];
  final List<Widget> _pages = [
    const Home(),
    const SearchMovie(),
    const ComingSoonMovies(),
    const DownloadedMovie(),
    const MoreAndProfile()
  ];
  int _currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentPageIndex,
          onTap: (value) {
            setState(() {
              print("object");
              _currentPageIndex = value;
            });
          },
          items: _items),
    );
  }
}
