part of 'pages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  AudioPlayer player = AudioPlayer();
  AudioCache cache = new AudioCache();
  String? timeNow;
  String? dateNow;
  bool headerActivity = false;
  bool headerSetting = false;
  int timeNowInt = 7;

  @override
  void initState() {
    super.initState();
    openingActions();
    Timer.periodic(Duration(seconds: 1), (Timer t) => getDateTimeNow());
  }

  void getDateTimeNow() {
    final DateTime now = DateTime.now();
    final String formattedDateNow = DateFormat('dd/MM/yyyy').format(now);
    final String formattedTimeNow = DateFormat('kk:mm:ss').format(now);
    setState(() {
      dateNow = formattedDateNow;
      timeNow = formattedTimeNow;
      timeNowInt = int.parse(DateFormat('kk').format(now));
    });
  }

  openingActions() async { //add this
    // player = await cache.play('bghome.mp3'); //add this
  }

  AssetImage homeBackGroundImage() {
    if (timeNowInt > 6 && timeNowInt < 18) {
      return AssetImage("assets/homeBackgroundMorningMode.jpg");
    } else {
      return AssetImage("assets/homeBackgroundNightMode.png");
    }
  }

  Color titleColor() {
    if (timeNowInt > 6 && timeNowInt < 18) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  Color dateTimeColor() {
    if (timeNowInt > 6 && timeNowInt < 18) {
      return Colors.black;
    } else {
      return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/drawerHeader.png"),
                        fit: BoxFit.fitWidth
                    )
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (headerActivity) {
                            headerActivity = false;
                          } else {
                            headerActivity = true;
                          }
                        });
                      },
                      child: Container(
                        color: Colors.transparent,
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2),
                        child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.topCenter,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: 30,
                                            child: Image.asset("assets/drawerIcon.png",
                                            )
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text('Daily Activity')
                                        )
                                      ]
                                  )
                              ),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(headerActivity ? Icons.arrow_drop_up_outlined : Icons.arrow_drop_down_outlined)
                              )
                            ]
                        ),
                      ),
                    ),
                    if (headerActivity) ListTile(
                      title: const Text('Input Activity'),
                      onTap: () {
                        context.read<PageBloc>().add(GoToInputPage());
                        player.stop();
                      },
                      focusColor: Colors.pinkAccent,
                    ),
                    if (headerActivity) ListTile(
                      title: const Text('List Activity'),
                      onTap: () {
                        context.read<PageBloc>().add(GoToListPage());
                        player.stop();
                      },
                      selectedTileColor: Colors.pinkAccent,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (headerSetting) {
                            headerSetting = false;
                          } else {
                            headerSetting = true;
                          }
                        });
                      },
                      child: Container(
                        color: Colors.transparent,
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2, top: 20),
                        child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.topCenter,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: 35,
                                            child: Image.asset("assets/drawerIconSetting.png",
                                            )
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text('Settings')
                                        )
                                      ]
                                  )
                              ),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(headerSetting ? Icons.arrow_drop_up_outlined : Icons.arrow_drop_down_outlined)
                              )
                            ]
                        ),
                      )
                    ),
                    if (headerSetting) ListTile(
                      title: const Text('Background Image'),
                      onTap: () {
                        context.read<PageBloc>().add(GoToBackgroundTypeChangePage("home"));
                        player.stop();
                      },
                      focusColor: Colors.pinkAccent,
                    ),
                  ]
              )
            )
          ]
        )
      ),
      body: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: homeBackGroundImage(),
                fit: BoxFit.cover
              )
            ),
          ),
          new ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            icon: Icon(Icons.menu, color: titleColor()),
                            onPressed: () => scaffoldKey.currentState!.openDrawer()
                        )
                      )
                    ]
                  ),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                      child: Column(
                        children: [
                          Text("Sakura Miko List",
                            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: titleColor()),
                          ),
                          Text("Your Activity",
                            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: titleColor()),
                          ),
                        ],
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
                    child: Text(dateNow ?? "", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: dateTimeColor()))
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(timeNow ?? "", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: dateTimeColor()))
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