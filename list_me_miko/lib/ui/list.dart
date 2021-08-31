part of 'pages.dart';

class ListActivityPage extends StatefulWidget {

  ListActivityPage({Key? key, this.title}) : super (key: key);
  final String? title;

  @override
  _ListActivityState createState() => _ListActivityState();
}

class _ListActivityState extends State<ListActivityPage> with WidgetsBindingObserver {

  GlobalKey<State<StatefulWidget>> _globalKey = new GlobalKey();

  ListRepository repository = new ListRepository();
  AudioPlayer player = AudioPlayer();
  AudioCache cache = new AudioCache();

  Future<Uint8List> _capturePng() async {
    RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    if (boundary.debugNeedsPaint) {
      print("Waiting for boundary to be painted.");
      await Future.delayed(const Duration(milliseconds: 20));
      return _capturePng();
    }

    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  void _printPngBytes() async {
    var status = await Permission.storage.status;

    if (!status.isGranted) {
      await Permission.storage.request();
    }

    if (await Permission.storage.request().isGranted) {
      var pngBytes = await _capturePng();
      var path = '/storage/emulated/0/Download';
      var date = DateFormat('dd-MMMM-yyyy hh-mm-ss').format(DateTime.now());
      String downloadpath = '$path/ActivityList $date.png';
      File filedownloadPath = new File(downloadpath);

      await filedownloadPath.writeAsBytes(pngBytes);
      await GallerySaver.saveImage(downloadpath);

      SuccessDialog(context, downloadpath, date);
    }
  }

  openingActions() async { //add this
    player = await cache.play('bglist.mp3'); //add this00
  }

  @override
  Widget build(BuildContext context) {
    openingActions();
    return RepaintBoundary(
      key: _globalKey,
      child: WillPopScope(
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
                          height: MediaQuery.of(context).size.height*0.07,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              InkWell(
                                onTap: () {
                                  _printPngBytes();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: MediaQuery.of(context).size.height*0.05,
                                  width: MediaQuery.of(context).size.width*0.25,
                                  margin: EdgeInsets.only(top: 10, right: 20),
                                  color: Colors.pinkAccent,
                                  child: Text("Screenshoot and share",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.8,
                            color: Colors.white,
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.05, left: MediaQuery.of(context).size.width*0.05, right: MediaQuery.of(context).size.width*0.05),
                            child: FutureBuilder(
                                future: repository.getList(),
                                builder: (_, snapshot) {
                                  if (snapshot.hasData) {
                                    List<ListModel> list = (snapshot.data as List<ListModel>);
                                    if (list.length > 0) {
                                      return ListView(
                                          children: list.map((e) => Container(
                                            child: Column(
                                              children: [
                                                Row(
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
                                                ),
                                              ],
                                            ),
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
      ),
    );
  }

  void SuccessDialog(BuildContext context, String file, String date) async {
    // set up the buttons
    Widget okButton = TextButton(
      child: Text("Ok"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget openButton = TextButton(
      child: Text("Open image"),
      onPressed:  () {
        OpenFile.open(file);
      },
    );

    Widget shareButton = TextButton(
      child: Text("Share activity list"),
      onPressed:  () async {
        Share.shareFiles(['$file'], text: 'Look at my list of activity on $date');
      },
    );
    // set up the AlertDialog

    Widget alert = AlertDialog(
      title: Text("Success"),
      content: Text("Activity list downloaded successfully."),
      actions: [
        Container(
//            alignment: Alignment.centerRight,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  openButton,
                  shareButton,
                  okButton,
                ]
            )
        )
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}