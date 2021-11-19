import 'package:basic/models/events/clock_event.dart';
import 'package:basic/models/weather_handler.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//THIS IS WHERE WE PUT
//THE
//VARIABLES
//THAT WE USE
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  DateTime _dateToday = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ;
  int _time = DateTime.now().millisecondsSinceEpoch;
  String startTime = "22:00";
  var _startTimeUpdated;
  Location _location = new Location();
  bool _isServiceEnabled = false;
  late PermissionStatus _permissionStatus;
  late LocationData _locationData;
  bool _isListenLocation=false,_isGetLocation=false;
  var weatherOne = WeatherHandler().getWeather();


  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      var test1 = ClockEvent("00:00", "22:00");
      var test2 = ClockEvent("22:00", "3:00");
      weatherOne = WeatherHandler().getWeather();

    /*
      _dateToday = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ;
      _time = DateTime.now().millisecondsSinceEpoch;
      startTime = "22:00";
      //startTime = startTime.substring(startTime.indexOf(":"));
      var now = DateTime.now();
      _startTimeUpdated = startTime.substring(0, startTime.indexOf(":"));//startTime.substring(startTime.indexOf(":")+1)
      _startTimeUpdated = DateTime(now.year, now.month, now.day, int.parse(startTime.substring(0, startTime.indexOf(":"))), int.parse(startTime.substring(startTime.indexOf(":")+1)), 0, 0);

     */
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              '$_dateToday',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '$_time',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '$weatherOne',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(onPressed: () async{
              _isServiceEnabled = await _location.serviceEnabled();
              if(!_isServiceEnabled){
                _isServiceEnabled = await _location.requestService();
                if(_isServiceEnabled) return;
              }

              _permissionStatus = await _location.requestPermission();
              if(_permissionStatus == PermissionStatus.denied){
                _isServiceEnabled = await _location.requestService();
                if(_isServiceEnabled != PermissionStatus.granted) return;
              }

              _locationData = await _location.getLocation();
              setState(() {
                _isGetLocation = true;
              });
            }, child: Text('Get Location')),
            _isGetLocation ? Text('Location: ${_locationData.longitude}/${_locationData.latitude}') : Container(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
