import 'dart:convert';
import 'dart:ui';
import 'package:book_my_movie/screens/selectCity.dart';
import 'package:flutter/material.dart';
import '../models/movieDetails.dart';
import "package:http/http.dart" as http;

class MovieDetailsScreen extends StatelessWidget {
  final MovieDetails movie;
  MovieDetailsScreen(this.movie);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Movie Details",
          textScaleFactor: 1.4,
          style: TextStyle(
            color: Colors.red[800],
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: MovieDetail(movie),
      floatingActionButton: ElevatedButton(
        child: Text("Book Now", textScaleFactor: 1.3,),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SelectCityScreen(movie)),
          );
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red[900]),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
    );
  }
}

class MovieDetail extends StatefulWidget {
  final MovieDetails movie;
  MovieDetail(this.movie);
  @override
  State<StatefulWidget> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final String baseImageUrl = "https://image.tmdb.org/t/p/w185/";
  final String baseUrl = "https://api.themoviedb.org/3/movie/";
  final String apiKey = "b86a9067dc16912f8a9229f46cdcb559";
  List<Genre> genres = [];
  int runtime;

  Future<bool> fetchData() async {
    print("Fetching....");
    var response =
        await http.get(Uri.parse("$baseUrl${widget.movie.id}?api_key=$apiKey"));
    List genresList = jsonDecode(response.body)["genres"] as List;
    genres = genresList.map((genre) {
      return Genre.fromData(genre);
    }).toList();
    runtime = jsonDecode(response.body)["runtime"] as int;
    print("Process Ended");
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final double fullWidth = MediaQuery.of(context).size.width;
    final double fullHeight = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: [
                          Container(
                            alignment: Alignment.topCenter,
                            child: Card(
                              margin: EdgeInsets.only(top: 10.0),
                              color: Colors.white38,
                              child: Container(
                                margin: EdgeInsets.all(10.0),
                                alignment: Alignment(-0.80, 0.0),
                                width: fullWidth / 100 * 95,
                                height: fullHeight / 100 * 33,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      widget.movie.originalTitle,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            widget.movie.originalTitle.length >
                                                    40
                                                ? 28
                                                : 32,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Release Date: ${widget.movie.releaseDate}",
                                      textScaleFactor: 1.5,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Genres: ${createGenreString(genres)}",
                                      textScaleFactor: 1.5,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Duration: ${runtime.toString()} minutes",
                                      textScaleFactor: 1.5,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      widget.movie.adult ? "A" : "U/A",
                                      textScaleFactor: 1.5,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        alignment: Alignment.center,
                        child: Text(
                          widget.movie.overview.length > 500
                              ? widget.movie.overview.substring(0, 500) + "...."
                              : widget.movie.overview,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("$baseImageUrl${widget.movie.posterPath}"),
                fit: BoxFit.cover,
              ),
            ),
          );
        } ///// if for the future builder ends here
        else {
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

  String createGenreString(List<Genre> genresList) {
    String genresString = "";
    int i = 0;
    while (i < genresList.length) {
      if (genresList[i].name == "Science Fiction") {
        genresString += "Sci Fic";
      } else {
        genresString += genresList[i].name.toString();
      }
      if (i != genresList.length - 1) {
        genresString += " | ";
      }
      i++;
    }

    return genresString;
  }
}

class Genre {
  int id;
  String name;

  Genre(this.id, this.name);
  factory Genre.fromData(Map<String, dynamic> list) {
    return Genre(list["id"], list["name"]);
  }
}
