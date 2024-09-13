part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class LanguageChange extends HomeState {}
final class AddRateState extends HomeState {}

final class NewReleaseLoadingState extends HomeState {}
final class NewReleaseSuccessState extends HomeState {}
final class NewReleaseErrorState extends HomeState {}

final class TopRatedLoadingState extends HomeState {}
final class TopRatedSuccessState extends HomeState {}
final class TopRatedErrorState extends HomeState {}

final class PopularLoadingState extends HomeState {}
final class PopularSuccessState extends HomeState {}
final class PopularErrorState extends HomeState {}



final class SearchMovieLoadingState extends HomeState {}
final class SearchMovieSuccessState extends HomeState {}
final class SearchMovieErrorState extends HomeState {}

final class GetMovieTrailerLoadingState extends HomeState {}
final class GetMovieTrailerSuccessState extends HomeState {}
final class GetMovieTrailerErrorState extends HomeState {}



final class GetMovieDetailsLoadingState extends HomeState {}
final class GetMovieDetailsSuccessState extends HomeState {}
final class GetMovieDetailsErrorState extends HomeState {}

final class GetSimilarMovieLoadingState extends HomeState {}
final class GetSimilarMovieSuccessState extends HomeState {}
final class GetSimilarMovieErrorState extends HomeState {}