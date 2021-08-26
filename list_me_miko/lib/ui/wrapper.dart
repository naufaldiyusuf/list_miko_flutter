part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageBloc, PageState>(
        builder: (_, state) {
          if (state is OnHomePage) {
            return HomePage();
          } else if (state is OnListPage) {
            return ListActivityPage();
          } else if (state is OnInputPage) {
            return InputActivityPage();
          } else {
            return SplashScreenPage();
          }
        }
    );
  }
}