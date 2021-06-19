import 'package:book_my_movie/models/ticket.dart';
import 'package:book_my_movie/screens/ConfrimTicket.dart';
import 'package:flutter/material.dart';

class SelectSeatScreen extends StatefulWidget {
  final String city;
  final String movieTitle;
  final String cinema;
  final String time;
  final String imageUrl;
  SelectSeatScreen(
      this.city, this.movieTitle, this.cinema, this.time, this.imageUrl);
  @override
  State<StatefulWidget> createState() => _SelectSeatScreenState();
}

class _SelectSeatScreenState extends State<SelectSeatScreen> {
  Color seatColor = Colors.white38;
  bool _isVisible = false;
  List<bool> selectedSeatsList = List.filled(63, false);
  @override
  Widget build(BuildContext context) {
    final double fullHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.city + "\n",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[900],
                ),
              ),
              TextSpan(
                text: widget.cinema + " | " + widget.time,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.overline,
                  color: Colors.red[900],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment(0, 0.92),
        // height: fullHeight / 100 * 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                "Screen",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.0,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
              color: Colors.white,
              height: 8.0,
            ),
            Container(
              height: fullHeight / 100 * 45,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 9,
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 2.0,
                ),
                itemCount: 63,
                itemBuilder: (context, index) {
                  String seatName = getSeatChar((index / 9).floor()) +
                      ((index) % 9 + 1).toString();
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSeatsList[index] =
                            selectedSeatsList[index] ? false : true;
                        _isVisible = checkSeats(selectedSeatsList);
                        print(
                            "for $index the value is ${selectedSeatsList[index]}");
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: selectedSeatsList[index]
                          ? Colors.white60
                          : Colors.white38,
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        seatName,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: _isVisible,
        child: ElevatedButton.icon(
          icon: Icon(Icons.thumb_up),
          label: Text(
            "Done",
            textScaleFactor: 1.4,
          ),
          onPressed: () {
            showDialog(context: context, builder: (context){
              return AlertDialog(
                contentPadding: EdgeInsets.all(10.0),
                content: Confirmation(TicketDetails(createSeatString(selectedSeatsList), widget.movieTitle, widget.city, widget.time, widget.cinema, widget.imageUrl)),
              );
            });

          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red[900]),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            ),
          ),
        ),
      ),
    );
  }

  bool checkSeats(List<bool> list) {
    int i = 0;
    bool returnValue = false;
    while (i < list.length) {
      if (list[i]) {
        returnValue = true;
        break;
      }
      i++;
    }
    return returnValue;
  }

  String createSeatString(List<bool> seatsList) {
    int i = 0;
    String seatsString = "";
    while (i < seatsList.length) {
      if (seatsList[i]) {
        seatsString += getSeatChar((i / 9).floor()).toString();
        seatsString += (i % 9 + 1).toString();
        seatsString += ", ";
      }
      i++;
    }
    return seatsString.substring(0, seatsString.length - 2);
  }

  String getSeatChar(int num) {
    switch (num) {
      case 0:
        return 'A';
      case 1:
        return "B";
      case 2:
        return "C";
      case 3:
        return "D";
      case 4:
        return "E";
      case 5:
        return "F";
      case 6:
        return "G";
    }
    return "";
  }
}
