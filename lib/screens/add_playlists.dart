import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:sound_trek/models/user.dart';
import 'package:sound_trek/models/playlist.dart';
import 'package:sound_trek/models/priority_queue.dart';

class AddPlaylists extends StatefulWidget {
  const AddPlaylists({Key? key}) : super(key: key);

  @override
  AddPlaylistsState createState() {
    return AddPlaylistsState();
  }
}

class AddPlaylistsState extends State<AddPlaylists> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<Playlist> playlistList = [];
  List<bool> selected = List.filled(5, false);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final eventsPriorityQueue = Provider.of<PriorityQueue>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 149, 215, 201),
        // automaticallyImplyLeading: true,
        title: Text('Playlists'),
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: user.usersPlaylists.length,
        itemBuilder: (context, index) {
          final playlist = user.usersPlaylists[index];

          return buildListTile(playlist, selected, playlistList, index);
        },
      ),
      floatingActionButton: TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 25),
          primary: Colors.white,
          backgroundColor: const Color.fromARGB(255, 149, 215, 201),
        ),
        onPressed: () {
          Navigator.pop(context, playlistList.elementAt(0));
        },
        child: Text('Add Playlists'),
      ),
    );
  }

  Widget buildListTile(Playlist playlist, List<bool> selected,
      List<Playlist> playlistList, int index) {
    return SwitchListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      title: Text(
        '${playlist.title}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black54,
          fontSize: 20,
        ),
      ),
      value: selected.elementAt(index),
      activeTrackColor: const Color.fromARGB(255, 149, 215, 201),
      activeColor: Colors.teal,
      onChanged: (bool value) {
        setState(() {
          if (value) {
            playlistList.add(playlist);
          } else {
            playlistList.remove(playlist);
          }
          selected[index] = value;
        });
      },
      dense: false,
    );
  }
}
