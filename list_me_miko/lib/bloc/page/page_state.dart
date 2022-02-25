part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();

  @override
  List<Object?> get props => [];
}

class PageInitial extends PageState {}

class OnHomePage extends PageState {}

class OnInputPage extends PageState {}

class OnListPage extends PageState {}

class OnBackgroundTypeChangePage extends PageState {
  final String fromPage;

  OnBackgroundTypeChangePage(this.fromPage);
}

class OnBackgroundImageChangePage extends PageState {
  final String backToPage;
  final String backgroundType;
  final String imageDefault;
  final String? imageSelected;

  OnBackgroundImageChangePage(this.backToPage, this.backgroundType, this.imageDefault, this.imageSelected);
}