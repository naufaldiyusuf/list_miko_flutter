part of 'pages.dart';

class ListActivityPage extends StatefulWidget {
  @override
  _ListActivityState createState() => _ListActivityState();
}

class _ListActivityState extends State<ListActivityPage> {

  ListRepository repository = new ListRepository();
  AudioPlayer player = AudioPlayer();
  AudioCache cache = new AudioCache();

  openingActions() async { //add this
    player = await cache.play('bglist.mp3'); //add this
  }

  @override
  Widget build(BuildContext context) {
    openingActions();
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToHomePage());
        player.stop();
        return false;
      },
      child: Scaffold(
          body: new Stack(
            children: <Widget>[
              new Container(
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                          image: AssetImage("assets/listbackground.jpg"),
                          fit: BoxFit.cover
                      )
                  ),
                  child: ListView(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*0.8,
                          color: Colors.white,
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.13, left: MediaQuery.of(context).size.width*0.05, right: MediaQuery.of(context).size.width*0.05),
                          child: FutureBuilder(
                              future: repository.getList(),
                              builder: (_, snapshot) {
                                if (snapshot.hasData) {
                                  List<ListModel> list = (snapshot.data as List<ListModel>);
                                  if (list.length > 0) {
                                    return ListView(
                                        children: list.map((e) => Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.topCenter,
                                              margin: EdgeInsets.only(top: 20),
                                              width: MediaQuery.of(context).size.width*0.2,
                                              child: Text(e.activity!,
                                                style: TextStyle(
                                                    fontSize: 11.5
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.topCenter,
                                              margin: EdgeInsets.only(top: 20),
                                              width: MediaQuery.of(context).size.width*0.3,
                                              child: Text(e.date!,
                                                style: TextStyle(
                                                    fontSize: 11.5
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 20),
                                              width: MediaQuery.of(context).size.width*0.0917,
                                              child: Text(e.time!,
                                                style: TextStyle(
                                                    fontSize: 11.5
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  repository.delete(e.id);
                                                });
                                              },
                                              child: Container(
                                                height: MediaQuery.of(context).size.height*0.035,
                                                width: MediaQuery.of(context).size.width*0.09,
                                                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05, top: 20),
                                                color: Colors.pinkAccent,
                                                child: Icon(
                                                  Icons.delete,
                                                  size: MediaQuery.of(context).size.width*0.06,
                                                ),
                                              ),
                                            )
                                          ],
                                        )).toList()
                                    );
                                  }
                                }
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text("Activity Empty",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.03),
                                      width: MediaQuery.of(context).size.width*0.7,
                                      height: 265,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage("assets/mikoactivityempty.jpeg"),
                                              fit: BoxFit.fitWidth
                                          )
                                      ),
                                    )
                                  ],
                                );
                              }
                          )
                      )
                    ],
                  )
              ),
            ],
          )
      ),
    );
  }
}