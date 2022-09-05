import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:planty_app/models/plant_model.dart';
import 'package:planty_app/models/timeline_model.dart';
import 'package:planty_app/screens/timeline/timeline.dart';

class EntryTile extends StatefulWidget {
  final TimelineModel timelineEntry;
  int entryLength;

  int entryIndex; //the first index will have a ball at the top of the line.png (caps)

  EntryTile({this.timelineEntry, this.entryIndex, this.entryLength});
  @override
  _EntryTileState createState() => _EntryTileState();
}

class _EntryTileState extends State<EntryTile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String day = DateFormat.d().format(widget.timelineEntry.updatedAt);
    String month = DateFormat.MMMM().format(widget.timelineEntry.updatedAt);

    String checkIndex() {
      if (widget.entryIndex == widget.entryLength -1) {
        return "assets/images/cap.png";
      } else if (widget.entryIndex == 0) {
        return "assets/images/line.png";
      }  else {
                return "assets/images/line_2.png";

      }
    }

    return Container(
      padding: widget.entryIndex != 0
          ? EdgeInsets.only(top: 0)
          : EdgeInsets.only(top: 30),
      width: 100,
      height: size.width * .8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(day,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(month, style: TextStyle(fontSize: 18))
          ]),
          SizedBox(  width: widget.entryIndex != 0 ? 18.5: 18), //the decimal is there to ensure proper alignment
          Image.asset(checkIndex()),
          Spacer(),
          Container(
            width: 200,
            height: 280,
            child: ClipRRect(
              child: Image.network(widget.timelineEntry.imageUrl,
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(20),
            ),
          )
        ],
      ),
    );
  }
}
