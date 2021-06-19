import 'package:json_annotation/json_annotation.dart';
part 'movieDetails.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake )
class MovieDetails{

  bool adult;
  String backdropPath;
  List genreIds; 
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  MovieDetails();

  factory MovieDetails.fromJson(Map<String, dynamic> movie){
    return _$MovieDetailsFromJson(movie);
  }
}
