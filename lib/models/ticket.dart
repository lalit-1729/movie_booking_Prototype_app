class TicketDetails{
  int id;
  String seats;
  String movieTitle;
  String city;
  String time;
  String cinema;
  String imageUrl;

  TicketDetails(this.seats, this.movieTitle, this.city, this.time, this.cinema, this.imageUrl);

  Map<String, dynamic> toMap(){
    return {
      "id":id,
      "seats":seats,
      "movieTitle":movieTitle,
      "city":city,
      "time":time,
      "cinema":cinema,
      "imageUrl": imageUrl
    };
  }

  TicketDetails.fromMap(Map<String, dynamic> ticketMap){
    id = ticketMap["id"];
    seats = ticketMap["seats"];
    movieTitle = ticketMap["movieTitle"];
    city = ticketMap["city"];
    time = ticketMap["time"];
    cinema = ticketMap["cinema"];
    imageUrl = ticketMap["imageUrl"];
  }
    
}