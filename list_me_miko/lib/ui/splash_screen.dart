part of 'pages.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage> {

  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      context.read<PageBloc>().add(GoToHomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width *0.7,
                height: 265,
                margin: EdgeInsets.only(top: 120),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/splashscreen.png"),
                    fit: BoxFit.fitWidth
                  )
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Text("List Me!",
                        style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold)
                    ),
                    Text("Sakura Miko Edition",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)
                    ),
                  ],
                ),
              )

            ],
          )
        ],
      ),
    );
  }
}
