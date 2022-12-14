import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sound_trek/models/priority_queue.dart';
import 'package:sound_trek/models/slideable_actions.dart';
import 'package:sound_trek/models/soundtrack_item.dart';
import 'package:sound_trek/screens/event_builders/location_event_builder.dart';
import 'package:sound_trek/screens/event_builders/time_event_builder.dart';
import 'package:sound_trek/screens/event_builders/weather_event_builder.dart';
import 'package:provider/provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:sound_trek/screens/event_builders/date_event_builder.dart';
import 'package:sound_trek/models/user.dart';

class EventsPage extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final eventsPriorityQueue = Provider.of<PriorityQueue>(context);
    final user = Provider.of<User>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 149, 215, 201),
        // automaticallyImplyLeading: true,
        title: const Text('Events'),
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: eventsPriorityQueue.possibilities.length,
        itemBuilder: (context, index) {
          final soundtrackItem = eventsPriorityQueue.possibilities[index];

          return Slidable(
            key: const ValueKey(0),
            endActionPane: ActionPane(
              motion: DrawerMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) => edit(eventsPriorityQueue, user, index),
                  backgroundColor: Color(0xFF6B6B6B),
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                ),
                SlidableAction(
                  onPressed: (context) => delete(eventsPriorityQueue, index),
                  backgroundColor: Color(0xFF6B6B6B),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: buildListTile(soundtrackItem),
          );
        },
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        backgroundColor: Color.fromARGB(255, 149, 215, 201),
        activeBackgroundColor: Color.fromARGB(255, 149, 215, 201),
        activeForegroundColor: Colors.black26,
        foregroundColor: Colors.white,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        spacing: 10,
        spaceBetweenChildren: 5,
        children: [
          SpeedDialChild(
              child: Icon(Icons.location_on_rounded),
              backgroundColor: Colors.white,
              labelBackgroundColor: Colors.white,
              label: 'Location',
              onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return BuildLocationEvent();
                    })),
                  }),
          SpeedDialChild(
            child: Icon(Icons.access_time_filled_rounded),
            backgroundColor: Colors.white,
            labelBackgroundColor: Colors.white,
            label: 'Time',
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BuildTimeEvent();
              })),
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.event_note_rounded),
            backgroundColor: Colors.white,
            labelBackgroundColor: Colors.white,
            label: 'Date',
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BuildDateEvent();
              })),
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.wb_sunny_rounded),
            backgroundColor: Colors.white,
            labelBackgroundColor: Colors.white,
            label: 'Weather',
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BuildWeatherEvent();
              })),
            },
          )
        ],
      ),
    );
  }

  Widget buildListTile(SoundtrackItem item) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      title: Text('${item.getEventList().elementAt(0)}'),
      subtitle: Text('event type here...'),
      trailing: Icon(
        Icons.arrow_forward,
        color: Color(0xFF303030),
        size: 20,
      ),
      dense: false,
    );
  }

  void edit(PriorityQueue events, User user, int index) {}

  void delete(PriorityQueue events, int index) {
    events.deleteItem(index);

  }
}
