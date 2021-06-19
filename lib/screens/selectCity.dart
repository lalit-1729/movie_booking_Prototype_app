import 'package:book_my_movie/models/movieDetails.dart';
import 'package:flutter/material.dart';
import './selectCinema.dart';
import 'dart:ui';

class SelectCityScreen extends StatefulWidget {
  final MovieDetails movie;
  // final String imageUrl;
  SelectCityScreen(this.movie);
  @override
  State<StatefulWidget> createState() => _SelectCityScreenState();
}

class _SelectCityScreenState extends State<SelectCityScreen> {
  final TextEditingController controller = TextEditingController();
  Future<String> loadData() async {
    final jsonString =
        await DefaultAssetBundle.of(context).loadString("cities/cities.json");
    return jsonString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller,
          style: TextStyle(color: Colors.red),
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.name,
          cursorHeight: 20,
          cursorWidth: 3.0,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(2.5),
              filled: true,
              fillColor: Colors.red[50],
              border: OutlineInputBorder(
                  // color:
                  borderRadius: BorderRadius.circular(25.0)),
              hintText: "Select a city",
              prefixIcon: Icon(Icons.search)),
        ),
      ),
      body: PopularCities(widget.movie),
    );
  }
}

class PopularCities extends StatefulWidget {
  final MovieDetails movie;
  PopularCities(this.movie);
  @override
  _PopularCitiesState createState() => _PopularCitiesState();
}

class _PopularCitiesState extends State<PopularCities> {
  final String baseImageUrl = "https://image.tmdb.org/t/p/w185/";

  @override
  Widget build(BuildContext context) {
    final double fullHeight = MediaQuery.of(context).size.height;
    final double fullWidth = MediaQuery.of(context).size.width;

    return Container(
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            padding: EdgeInsets.only(top: 20.0),
            alignment: Alignment.topCenter,
            child: Card(
              elevation: 20.0,
              color: Colors.white30,
              child: Container(
                height: fullHeight / 100 * 30,
                width: fullWidth / 100 * 92,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Popular Cities",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                      ),
                    ),
                    Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectCinemaScreen(
                                    "Banglore",
                                    widget.movie.originalTitle,
                                    widget.movie.posterPath),
                              ),
                            );
                          },
                          child: Container(
                            child: Text(
                              "Bangalore",
                              textScaleFactor: 1.2,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectCinemaScreen(
                                    "Ahmedabad",
                                    widget.movie.originalTitle,
                                    widget.movie.posterPath),
                              ),
                            );
                          },
                          child: Container(
                            child: Text(
                              "Ahmedabad",
                              textScaleFactor: 1.2,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectCinemaScreen(
                                    "Delhi/NCR",
                                    widget.movie.originalTitle,
                                    widget.movie.posterPath),
                              ),
                            );
                          },
                          child: Container(
                            child: Text(
                              "Delhi/NCR",
                              textScaleFactor: 1.2,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectCinemaScreen(
                                    "Chennai",
                                    widget.movie.originalTitle,
                                    widget.movie.posterPath),
                              ),
                            );
                          },
                          child: Container(
                            child: Text(
                              "Chennai",
                              textScaleFactor: 1.2,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectCinemaScreen(
                                    "Pune",
                                    widget.movie.originalTitle,
                                    widget.movie.posterPath),
                              ),
                            );
                          },
                          child: Container(
                            child: Text(
                              "Pune",
                              textScaleFactor: 1.2,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectCinemaScreen(
                                    "Kolkata",
                                    widget.movie.originalTitle,
                                    widget.movie.posterPath),
                              ),
                            );
                          },
                          child: Container(
                            child: Text(
                              "Kolkata",
                              textScaleFactor: 1.2,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectCinemaScreen(
                                    "Mumbai",
                                    widget.movie.originalTitle,
                                    widget.movie.posterPath),
                              ),
                            );
                          },
                          child: Container(
                            child: Text(
                              "Mumbai",
                              textScaleFactor: 1.2,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        //   ],
                        // ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectCinemaScreen(
                                    "Hyderabad",
                                    widget.movie.originalTitle,
                                    widget.movie.posterPath),
                              ),
                            );
                          },
                          child: Container(
                            child: Text(
                              "Hyderabad",
                              textScaleFactor: 1.2,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
  }
}
