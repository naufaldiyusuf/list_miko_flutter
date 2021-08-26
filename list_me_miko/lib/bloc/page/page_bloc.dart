import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

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
    }
  }
}