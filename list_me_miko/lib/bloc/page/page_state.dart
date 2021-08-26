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