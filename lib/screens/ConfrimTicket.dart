import 'dart:ui';
import 'package:book_my_movie/dbHelper/dbHelper.dart';
import 'package:book_my_movie/models/ticket.dart';
import 'package:book_my_movie/screens/ticketsScreen.dart';
import "package:flutter/material.dart";

class Confirmation extends StatefulWidget {
  final TicketDetails ticket;
  Confirmation(this.ticket);
  @override
  State<StatefulWidget> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  final String baseUrl = "https://image.tmdb.org/t/p/w342/";
  DbHelper _dbHelper;

  @override
  void initState() {
    _dbHelper = DbHelper();
    _dbHelper.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("$baseUrl${widget.ticket.imageUrl}"),
          fit: BoxFit.cover,
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            NetworkImage("$baseUrl${widget.ticket.imageUrl}")),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.ticket.movieTitle + "\n",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: widget.ticket.movieTitle.length>20.0 ? 35.0 :39.0,
                          ),
                        ),
                        TextSpan(
                          text: widget.ticket.city + "\n",
                          style: TextStyle(
                            fontSize: 28.0,
                          ),
                        ),
                        TextSpan(
                          text: widget.ticket.cinema + " | ",
                          style: TextStyle(
                            fontSize: 28.0,
                          ),
                        ),
                        TextSpan(
                          text: widget.ticket.time + "\n",
                          style: TextStyle(
                            fontSize: 28.0,
                          ),
                        ),
                        TextSpan(
                          text: "Seats: " + widget.ticket.seats,
                          style: TextStyle(
                            fontSize: 28.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.confirmation_num),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.red[900],
                  ),
                ),
                onPressed: () async {
                  await _dbHelper.insertTicket(widget.ticket);
                  print("Ticket added");
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TicketsScreen(),
                    ),
                  );
                },
                label: Text(
                  "Confirm",
                  textScaleFactor: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
