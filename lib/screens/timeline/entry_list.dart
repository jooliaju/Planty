import 'package:flutter/material.dart';
import 'package:planty_app/models/timeline_model.dart';
import 'package:planty_app/screens/timeline/entry_tile.dart';
import 'package:planty_app/shared/constants.dart';
import 'package:provider/provider.dart';

class EntryList extends StatefulWidget {
  @override
  _EntryListState createState() => _EntryListState();
}

class _EntryListState extends State<EntryList> {
  @override
  Widget build(BuildContext context) {
    final entries = Provider.of<List<TimelineModel>>(context) ?? [];

    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: entries.length,
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return EntryTile(timelineEntry: entries[index]);
        },
      ),
    );
  }
}
