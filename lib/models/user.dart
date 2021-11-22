import 'package:just_audio/just_audio.dart';
import 'package:sound_trek/models/events/event.dart';
import 'package:sound_trek/models/playlist.dart';
import 'package:flutter/foundation.dart';
import 'package:sound_trek/screens/musicplayer.dart';

class User with ChangeNotifier{
  List<Playlist> usersPlaylists = [Playlist()];
  String name = 'Lukas Frick';
  String email = 'lfrick3@lsu.edu';
  String image = 'assets/pictures/lukas.png';


  void editEvent(int index) {
    notifyListeners();
  }

  void addPlaylist(Playlist newPlaylist) {
    usersPlaylists.insert(0, newPlaylist);
    notifyListeners();
  }

  void deletePlaylist(int index) {
    usersPlaylists.removeAt(index);
    notifyListeners();
  }

  void editPlaylist(int index) {
    notifyListeners();
  }


}