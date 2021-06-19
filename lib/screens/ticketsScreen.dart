import 'package:book_my_movie/dbHelper/dbHelper.dart';
import 'package:book_my_movie/models/ticket.dart';
import 'package:flutter/material.dart';

class TicketsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Tickets",
          textScaleFactor: 1.4,
          style: TextStyle(color: Colors.red[900]),
        ),
        centerTitle: true,
      ),
      body: TicketsLayout(),
    );
  }
}

class TicketsLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TicketsLayoutState();
}

class _TicketsLayoutState extends State<TicketsLayout> {
  DbHelper dbHelper;
  @override
  void initState() {
    dbHelper = DbHelper();
    dbHelper.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAllTickets(),
      builder: (context, snapshot) {
        List<TicketDetails> items = snapshot.data;
        if (!(items?.isEmpty ?? true)) {
          return ListView.builder(
            // shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (
              content,
              index,
            ) =>
                Ticket(
              items[index],
            ),
          );
        } else {
          return Center(
            child: Text(
              "No Tickets Booked Yet",
              style: TextStyle(
                color: Colors.red[900],
                fontWeight: FontWeight.bold,
              ),
              textScaleFactor: 1.6,
            ),
          );
        }
      },
    );
  }

  Future<List<TicketDetails>> getAllTickets() async {
    dbHelper = DbHelper();
    List<TicketDetails> tickets = await dbHelper.getTickets();
    return tickets ?? <List<TicketDetails>>[];
  }
}

class Ticket extends StatelessWidget {
  final TicketDetails ticket;
  final String baseUrl = "https://image.tmdb.org/t/p/w342/";
  Ticket(this.ticket);
  @override
  Widget build(BuildContext context) {
    final double fullWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.only(bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 20.0,
                      bottom: 10.0,
                    ),
                    height: fullWidth / 100 * 50.0,
                    width: fullWidth / 100 * 30,
                    child: Image(
                      // loadingBuilder: ,
                      image: NetworkImage("$baseUrl${ticket.imageUrl}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding:
                        EdgeInsets.only(right: 20.0, bottom: 10.0, left: 20.0),
                    child: Image(
                      image: AssetImage("images/qrCode.png"),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 50.0,
                  width: 25.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: Container(
                  color: Colors.grey,
                  height: 2.0,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 50.0,
                  width: 25.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      bottomLeft: Radius.circular(25.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0, right: 15.0, left: 15.0),
            child: RichText(
              overflow: TextOverflow.clip,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: ticket.movieTitle + "\n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ticket.city + "\n",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: ticket.cinema + " | ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      decoration: TextDecoration.overline,
                    ),
                  ),
                  TextSpan(
                    text: ticket.time + "\n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.overline,
                    ),
                  ),
                  TextSpan(
                    text: "Seats: ",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: ticket.seats,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
