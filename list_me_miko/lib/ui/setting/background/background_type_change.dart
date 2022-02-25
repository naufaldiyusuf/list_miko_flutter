part of '../../pages.dart';

class BackgroundTypeChangePage extends StatefulWidget {
  final String fromPage;

  BackgroundTypeChangePage(this.fromPage);

  @override
  _BackgroundTypeChangePageState createState() => _BackgroundTypeChangePageState();
}

class _BackgroundTypeChangePageState extends State<BackgroundTypeChangePage> {
  String? fromPage;

  @override
  void initState() {
    super.initState();
    fromPage = widget.fromPage;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (fromPage == "home") {
          context.read<PageBloc>().add(GoToHomePage());
        } else {
          setState(() {
            fromPage = "home";
          });
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Background Change'),
          leading: GestureDetector(
            onTap: () {
              if (fromPage == "home") {
                context.read<PageBloc>().add(GoToHomePage());
              } else {
                setState(() {
                  fromPage = "home";
                });
              }
            },
            child: Icon(Icons.arrow_back),
          )
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.83,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
              child: ListView(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text('Choose background type:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  if (fromPage == "home") ListTile(
                    title: Text('Home Background'),
                    onTap: () {
                      setState(() {
                        fromPage = "background_type";
                      });
                    }
                  ),
                  if (fromPage == "home") ListTile(
                    title: Text('List Background'),
                      onTap: () => context.read<PageBloc>().add(GoToBackgroundImageChangePage("home", "list"))
                  ),
                  if (fromPage == "home") ListTile(
                    title: Text('Input Background'),
                      onTap: () => context.read<PageBloc>().add(GoToBackgroundImageChangePage("home", "input"))
                  ),
                  if (fromPage == "background_type") ListTile(
                    title: Text('Morning Mode'),
                    onTap: () => context.read<PageBloc>().add(GoToBackgroundImageChangePage("background_type", "home_morning")),
                  ),
                  if (fromPage == "background_type") ListTile(
                    title: Text('Night Mode'),
                    onTap: () => context.read<PageBloc>().add(GoToBackgroundImageChangePage("background_type", "home_night")),
                  )
                ]
              )
            )
          ]
        ),
      )
    );
  }
}
