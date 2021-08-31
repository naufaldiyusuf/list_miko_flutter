part of 'pages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {

  AudioPlayer player = AudioPlayer();
  AudioCache cache = new AudioCache();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }


  openingActions() async { //add this
    player = await cache.play('bghome.mp3'); //add this
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        player.resume();
        break;
      case AppLifecycleState.inactive:
        player.stop();
      // widget is inactive
        break;
      case AppLifecycleState.paused:
        player.pause();
      // widget is paused
        break;
      case AppLifecycleState.detached:
        player.stop();
      // widget is detached
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    openingActions();
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: AssetImage("assets/homebackground.jpg"),
                fit: BoxFit.cover
              )
            ),
          ),
          new ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 165),
                      child: Column(
                        children: [
                          Text("Sakura Miko List",
                            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                          ),
                          Text("Your Activity",
                            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 150),
                    child: ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.width * 0.15,
                      buttonColor: Colors.pinkAccent,
                      child: RaisedButton(
                        onPressed: () {
                          context.read<PageBloc>().add(GoToInputPage());
                        },
                        child: Text("Input Activity"),
                        textColor: Colors.white,
                      )
                    )
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 70),
                      child: ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.width * 0.15,
                          buttonColor: Colors.pinkAccent,
                          child: RaisedButton(
                            onPressed: () {
                              context.read<PageBloc>().add(GoToListPage());
                              player.stop();
                            },
                            child: Text("List Activity"),
                            textColor: Colors.white,
                          )
                      )
                  )
                ],
              )
            ],
          )
        ],
      )
    );
  }
}