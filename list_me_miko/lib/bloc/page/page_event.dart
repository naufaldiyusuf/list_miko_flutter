part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();

  @override
  List<Object?> get props =>[];
}

class GoToHomePage extends PageEvent {}

class GoToInputPage extends PageEvent {}

class GoToListPage extends PageEvent {}

class GoToBackgroundTypeChangePage extends PageEvent {
  final String fromPage;

  GoToBackgroundTypeChangePage(this.fromPage);
}

class GoToBackgroundImageChangePage extends PageEvent {
  final String backToPage;
  final String backgroundType;

  GoToBackgroundImageChangePage(this.backToPage, this.backgroundType);
}