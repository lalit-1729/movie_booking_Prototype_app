import 'dart:convert';
import 'package:book_my_movie/screens/MovieDetailScreen.dart';
import 'package:book_my_movie/screens/ticketsScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/movieDetails.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Book My Movie",
          textScaleFactor: 1.3,
          style: TextStyle(
            color: Colors.red[800],
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: ElevatedButton.icon(
        icon: Icon(Icons.movie),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red[900]),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0))),
        ),
        onPressed: () {
          // Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TicketsScreen(),
            ),
          );
        },
        label: Text(
          "Your Tiekets",
          textScaleFactor: 1.2,
        ),
      ),
      body: HomeLayout(),
    );
  }
}

class HomeLayout extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final String apiKey = "b86a9067dc16912f8a9229f46cdcb559";
  List<MovieDetails> moviesList;
  Future<List<MovieDetails>> loadMoviesDetails() async {
    print("Fetching");
    var response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey'));
    List results = jsonDecode(response.body)["results"] as List;
    moviesList =
        results.map((result) => MovieDetails.fromJson(result)).toList();
    print("Fetched.. Process Ended...");
    return moviesList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadMoviesDetails(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MovieDetails> items = snapshot.data;
          return AnimatedContainer(
            duration: Duration(seconds: 2),
            curve: Curves.bounceIn,
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (context, index) => Container(),
              itemBuilder: (context, index) {
                return Container(
                  child: MovieTile(items[index]),
                  margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
                );
              },
            ),
          );
        } else {
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: CircularProgressIndicator(),
                  ),
                  Text(
                    "Loading...",
                    style: TextStyle(
                      fontSize: 22,
                      color: Color(0xffff0000),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class MovieTile extends StatefulWidget {
  final MovieDetails movie;
  MovieTile(this.movie);
  @override
  _MovieTileState createState() => _MovieTileState();
}

class _MovieTileState extends State<MovieTile> {
  final String baseUrl = "https://image.tmdb.org/t/p/w185/";
  @override
  Widget build(BuildContext context) {
    final double fullWidth = MediaQuery.of(context).size.width;
    final double fullHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(color: Colors.black, boxShadow: [
        BoxShadow(
          color: Colors.grey[900],
          blurRadius: 3.0,
          spreadRadius: 5.0,
          offset: Offset(0, 4),
        ),
      ]),
      height: fullHeight / 100 * 18,
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 30,
                child: Container(
                  width: fullWidth / 100 * 25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("$baseUrl${widget.movie.posterPath}"),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.movie.originalTitle,
                      textScaleFactor: 1.4,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      widget.movie.releaseDate,
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      widget.movie.adult ? "A" : "U/A",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.red[900],
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              child: Text(
                "Book Now",
                textScaleFactor: 1.1,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MovieDetailsScreen(widget.movie)));
              },
            ),
          )
        ],
      ),
    );
  }
}
