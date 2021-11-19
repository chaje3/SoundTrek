import 'package:SoundTrek/models/soundtrack_item.dart';

class PriorityQueue{
  List<SoundtrackItem> possibilities = [];
  int _currentEventIndex = 0;

  void FindStarterEvent(){
    for(int i = 0; i< possibilities.length; i++){
      if(possibilities.elementAt(i).isHappening()){
        _currentEventIndex = i;
        i = possibilities.length;
      }
    }
  }

  void Update(){
    bool verifyEventOccurance = false;
    for(int i = 0; i<_currentEventIndex+1; i++){
      if(possibilities.elementAt(i).isHappening()){
        _currentEventIndex = i;
        i = possibilities.length;
        verifyEventOccurance = true;
      }
    }

    if(verifyEventOccurance == false){
      FindStarterEvent();
    }
  }
}