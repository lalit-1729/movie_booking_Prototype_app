import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../models/ticket.dart';
import 'dart:io';

class DbHelper{
  final String colId = "id";
  final String colSeats = "seats";
  final String colMovieTitle = "movieTitle";
  final String colTime = "time";
  final String colCity = "city";
  final String colCinema = "cinema";
  final String colImageUrl = "imageUrl";
  final String tableName = "ticketsTable";

  final int _version = 1;
  static Database _db;
  static DbHelper _singleTon = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper(){
    return _singleTon;
  }

  Future init()async{
    Directory docDir = await getApplicationDocumentsDirectory();
    String dbPath = join(docDir.path, "tickets.db");
    _db = await openDatabase(dbPath, version: _version, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async{
    String query = 'CREATE TABLE $tableName ($colId INTEGER PRIMARY KEY, $colSeats TEXT, $colMovieTitle TEXT, $colCity TEXT, $colCinema Text, $colTime Text, $colImageUrl )';
    await db.execute(query);
  }

  Future<int> insertTicket(TicketDetails ticket) async{
    int result = await _db.insert(tableName, ticket.toMap());
    return result;
  }

  Future<int> deleteTicket(TicketDetails ticket) async{
    int result = await _db.delete(tableName, where:"$colId = ?", whereArgs: [ticket.id] );
    return result;
  }


  Future<List<TicketDetails>> getTickets() async{
    if(_db == null){
      await init();
    }
    List<Map<String, dynamic>> ticketsList = await _db.query(tableName, orderBy: colId);
    List<TicketDetails> tickets = [];
    ticketsList.forEach((ticket) {
      tickets.add(TicketDetails.fromMap(ticket));
     });
    return tickets;
  }

}