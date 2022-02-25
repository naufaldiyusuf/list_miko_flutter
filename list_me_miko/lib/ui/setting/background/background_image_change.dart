part of '../../pages.dart';

class BackgroundImageChangePage extends StatefulWidget {

  final String backToPage;
  final String backgroundType;
  final String defaultImage;
  final String? imageSelected;

  BackgroundImageChangePage(this.backToPage, this.backgroundType, this.defaultImage, this.imageSelected);

  @override
  _BackgroundImageChangePageState createState() => _BackgroundImageChangePageState();
}

class _BackgroundImageChangePageState extends State<BackgroundImageChangePage> {
  String defaultImage = "assets/homeBackgroundMorningMode.png";
  String? imageSelected;

  @override
  void initState() {
    super.initState();
    if (widget.backgroundType == "home_morning") {
      defaultImage = "assets/homeBackgroundMorningMode.jpg";
    } else if (widget.backgroundType == "home_night") {
      defaultImage = "assets/homeBackgroundNightMode.png";
    } else if (widget.backgroundType == "list") {
      defaultImage = "assets/listbackground.jpg";
    } else {
      defaultImage = "assets/inputBackground.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.backToPage == "home") {
          context.read<PageBloc>().add(GoToBackgroundTypeChangePage("home"));
        } else {
          context.read<PageBloc>().add(GoToBackgroundTypeChangePage("background_type"));
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text('Background Change'),
            leading: GestureDetector(
              onTap: () {
                if (widget.backToPage == "home") {
                  context.read<PageBloc>().add(GoToBackgroundTypeChangePage("home"));
                } else {
                  context.read<PageBloc>().add(GoToBackgroundTypeChangePage("background_type"));
                }
              },
              child: Icon(Icons.arrow_back),
            )
        ),
        body:Container(
            height: MediaQuery.of(context).size.height * 0.83,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: Text('Choose background Image:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Container(
                        child: ListTile(
                          title: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  height: MediaQuery.of(context).size.height * 0.3,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(defaultImage),
                                      fit: BoxFit.fitWidth
                                    )
                                  )
                                )
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.check)
                              )
                            ]
                          )
                        )
                      )
                    ]
                  )
                )
              ]
            )
        )
      )
    );
  }
}
