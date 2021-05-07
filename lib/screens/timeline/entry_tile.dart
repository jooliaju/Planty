import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planty_app/models/plant_model.dart';
import 'package:planty_app/models/timeline_model.dart';
import 'package:planty_app/screens/timeline/timeline.dart';



class EntryTile extends StatefulWidget {


    final TimelineModel timelineEntry;

  EntryTile({this.timelineEntry});
  @override
  _EntryTileState createState() => _EntryTileState();
}

class _EntryTileState extends State<EntryTile> {



  @override
  Widget build(BuildContext context) {

    String date = DateFormat.yMMMd().format(widget.timelineEntry.updatedAt);


    return Container(
            width: 100,
            height: 280,
            margin: EdgeInsets.only(bottom: 50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[200],
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: Offset(5, 5),
                )
              ],
            ),
            child: Row(
              children: [
                Text(date),
                Spacer(),
                Container(width: 200, height: 280, 
                
                
                child: ClipRRect(
                  child: Image.network(widget.timelineEntry.imageUrl, fit: BoxFit.cover),
                ),
                )
              ],
            ),
          );
  }
}