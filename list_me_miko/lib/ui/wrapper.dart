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
          } else if (state is OnBackgroundTypeChangePage) {
            return BackgroundTypeChangePage(state.fromPage);
          } else if (state is OnBackgroundImageChangePage) {
            return BackgroundImageChangePage(state.backToPage, state.backgroundType, state.imageDefault, state.imageSelected);
          } else {
            return SplashScreenPage();
          }
        }
    );
  }
}