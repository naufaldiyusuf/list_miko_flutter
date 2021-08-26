part of 'pages.dart';

class InputActivityPage extends StatefulWidget {
  @override
  _InputActivityState createState() => _InputActivityState();
}

class _InputActivityState extends State<InputActivityPage> {

  FocusNode node = FocusNode();
  DateTime? date;
  TimeOfDay? time;
  TextEditingController activity = TextEditingController();
  bool validate = false;
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
          backgroundColor: Colors.pinkAccent,
          body: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 70),
                      child: Text("Input Activity",
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 80),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text("Nama Aktivitas: ",
                                style: TextStyle(fontSize: 16.5),),
                            ),
                            Container(
                              width: 170,
                              height: 40,
                              margin: EdgeInsets.only(left: 10),
                              child: TextField(
                                controller: activity,
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: 'Input Activity',
                                  errorText: validate ? 'Activity cannot be empty' : null
                                ),
                                focusNode: node,
                              ),
                            ),
                          ],
                        )
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 70),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: 150,
                              height: 40,
                              margin: EdgeInsets.only(left: 10),
                              child: ElevatedButton(
                                child: Text(
                                    'Pick Date'
                                ),
                                onPressed: () {
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now().add(const Duration(days: 365))
                                  ).then((val) {
                                    setState(() {
                                      date = val;
                                    });
                                  });
                                },
                              )
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                                date == null ? 'Date' : DateFormat('dd MMMM yyyy').format(date!)
                            ),
                          )
                        ],
                      )
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 70),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: 150,
                              height: 40,
                              margin: EdgeInsets.only(left: 10),
                              child: ElevatedButton(
                                child: Text(
                                    'Pick Time'
                                ),
                                onPressed: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((val) {
                                    setState(() {
                                      time = val;
                                    });
                                  });
                                },
                              )
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                                time == null ? 'Time' : time!.format(context).toString()
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 40,
                      margin: EdgeInsets.only(top: 70),
                      child: ElevatedButton(
                        child: Text('Save Activity'),
                        onPressed: () async {
                          DateTime reminder = new DateTime(date!.year, date!.month, date!.day, time!.hour, time!.minute);
                          if (activity.text.isEmpty || activity.text == "") {
                            emptyActivity(context);
                          } else if (date == null) {
                            emptyDate(context);
                          } else if (time == null) {
                            emptyTime(context);
                          } else {
                            try {

                              ListRepository repository = ListRepository();
                              ListModel model = ListModel(
                                id: DateTime.now().millisecondsSinceEpoch,
                                activity: activity.text,
                                date: DateFormat('dd MMMM yyyy').format(date!),
                                time: time!.format(context).toString(),
                              );
                              await repository.insert(model);
                              scheduleNotification(notifsPlugin: notifsPlugin,
                              id: DateTime.now().toString(),
                              body: "Reminder for you to do "+activity.text+" right now",
                              scheduledTime: reminder,
                              title: "List me miko");
                              successDialog(context);
                            } catch (e) {
                              failDialog(context, e.toString());
                            }
                          }
                        },
                      ),
                    )
                  ],
                ),
              ]
          ),
        )
    );
  }

  void emptyActivity(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Failed"),
      content: Text("Activity cannot be empty."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void emptyDate(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Failed"),
      content: Text("Date must be pick."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void emptyTime(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Failed"),
      content: Text("Time must be pick."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  void successDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Success"),
      content: Text("Activity has been save."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void failDialog(BuildContext context, String e) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Failed"),
      content: Text(e),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}