import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:list_me_miko/bloc/blocs.dart';
import 'package:list_me_miko/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'page_state.dart';
part 'page_event.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(PageInitial());

  @override
  Stream<PageState> mapEventToState(
      PageEvent event,
      ) async * {
    if (event is GoToHomePage) {
      yield OnHomePage();
    } else if (event is GoToInputPage) {
      yield OnInputPage();
    } else if (event is GoToListPage) {
      yield OnListPage();
    } else if (event is GoToBackgroundTypeChangePage) {
      yield OnBackgroundTypeChangePage(event.fromPage);
    } else if (event is GoToBackgroundImageChangePage) {
      final prefs = await SharedPreferences.getInstance();
      String? defaultImage;
      String? imageSelected;


      if (event.backToPage == "home") {
        if (event.backgroundType == "home_morning") {
          defaultImage = "assets/homeBackgroundMorningMode.jpg";
          if (prefs.getString(ConstantString.HOME_MORNING_SELECTED) != "assets/homeBackgroundMorningMode.jpg") {
            imageSelected = prefs.getString(ConstantString.HOME_MORNING_SELECTED);
          }
        } else {
          defaultImage = "assets/homeBackgroundNightMode.png";
          if (prefs.getString(ConstantString.HOME_NIGHT_SELECTED) != "assets/homeBackgroundNightMode.png") {
            imageSelected = prefs.getString(ConstantString.HOME_NIGHT_SELECTED);
          }
        }
      } else {
        if (event.backgroundType == "input") {
          defaultImage = "assets/inputBackground.png";
          if (prefs.getString(ConstantString.INPUT_SELECTED) != "assets/homeBackgroundNightMode.png") {
            imageSelected = prefs.getString(ConstantString.INPUT_SELECTED);
          }
        } else {
          defaultImage = "assets/listbackground.jpg";
          if (prefs.getString(ConstantString.LIST_SELECTED) != "assets/homeBackgroundNightMode.png") {
            imageSelected = prefs.getString(ConstantString.LIST_SELECTED);
          }
        }
      }

      yield OnBackgroundImageChangePage(event.backToPage, event.backgroundType, defaultImage, imageSelected);
    }
  }
}