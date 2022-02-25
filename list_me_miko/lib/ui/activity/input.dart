part of '../pages.dart';

class InputActivityPage extends StatefulWidget {
  @override
  _InputActivityState createState() => _InputActivityState();
}

class _InputActivityState extends State<InputActivityPage> with WidgetsBindingObserver {

  DateTime? date;
  TimeOfDay? time;
  TextEditingController activity = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController timeController = new TextEditingController();
  bool validate = false;
  AudioPlayer player = AudioPlayer();
  AudioCache cache = new AudioCache();

  openingActions() async { //add this
    // player = await cache.play('bglist.mp3'); //add this
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
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              new Container(
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        image: AssetImage("assets/inputBackground.png"),
                        fit: BoxFit.cover
                    )
                ),
                child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Column(
                      children: [
                        Stack(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: GestureDetector(
                                  onTap: () => context.read<PageBloc>().add(GoToHomePage()),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.1,
                                    height: MediaQuery.of(context).size.height * 0.1,
                                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03, left: MediaQuery.of(context).size.width * 0.065),
                                    child: Icon(Icons.arrow_back, color: Colors.black),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07, left: MediaQuery.of(context).size.width * 0.02),
                                  child: Text("Input Activity",
                                      style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)
                                  ),
                                ),
                              ),
                            ]
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.84,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                          child: ListView(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text("Activity Name",
                                              style: TextStyle(fontSize: 16.5),),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.8,
                                            height: 40,
                                            margin: EdgeInsets.only(left: 10, top: 10),
                                            child: TextField(
                                              controller: activity,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(left: 20, bottom: 10),
                                                border: UnderlineInputBorder(),
                                                hintText: 'Input Activity',
                                                errorText: validate ? 'Activity cannot be empty' : null,
                                              ),
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(top: 40, left: 10),
                                              child: Text('Activity Date',
                                              style: TextStyle(fontSize: 16.5))
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.8,
                                            height: 40,
                                            margin: EdgeInsets.only(left: 10, top: 10),
                                            child: TextField(
                                              showCursor: true,
                                              readOnly: true,
                                              controller: dateController,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(left: 20, bottom: 10),
                                                border: UnderlineInputBorder(),
                                                hintText: 'Pick Date',
                                              ),
                                              onTap: () {
                                                showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime.now().add(const Duration(days: 365))
                                                ).then((val) {
                                                  setState(() {
                                                    date = val;
                                                    dateController.text = DateFormat('dd MMMM yyyy').format(val!);
                                                  });
                                                });
                                              },
                                            )
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(top: 40, left: 10),
                                              child: Text('Activity Time',
                                                  style: TextStyle(fontSize: 16.5))
                                          ),
                                          Container(
                                              width: MediaQuery.of(context).size.width * 0.8,
                                              height: 40,
                                              margin: EdgeInsets.only(left: 10, top: 10),
                                              child: TextField(
                                                showCursor: true,
                                                readOnly: true,
                                                controller: timeController,
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.only(left: 20, bottom: 10),
                                                  border: UnderlineInputBorder(),
                                                  hintText: 'Pick Time',
                                                ),
                                                onTap: () {
                                                  showTimePicker(
                                                    context: context,
                                                    initialTime: TimeOfDay.now(),
                                                  ).then((val) {
                                                    setState(() {
                                                      time = val;
                                                      timeController.text = val!.format(context).toString();
                                                    });
                                                  });
                                                },
                                              )
                                          ),
                                        ]
                                    )
                                ),
                                Container(
                                  width: 150,
                                  height: MediaQuery.of(context).size.height * 0.07,
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width * 0.1,
                                      right: MediaQuery.of(context).size.width * 0.1,
                                      top: MediaQuery.of(context).size.height * 0.1),
                                  child: ButtonTheme(
                                    buttonColor: Colors.pinkAccent,
                                    child: ElevatedButton(
                                      child: Text('Save Activity'),
                                      onPressed: () async {
                                        // DateTime reminder = new DateTime(date!.year, date!.month, date!.day, time!.hour, time!.minute);
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
                                            // scheduleNotification(notifsPlugin: notifsPlugin,
                                            //     id: DateTime.now().toString(),
                                            //     body: "Reminder for you to do "+activity.text+" right now",
                                            //     scheduledTime: reminder,
                                            //     title: "List me miko");
                                            successDialog(context);
                                          } catch (e) {
                                            failDialog(context, e.toString());
                                          }
                                        }
                                      },
                                    ),
                                  )
                                )
                              ]
                          ),
                        )
                      ]
                  ),
                )
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