part of 'watch_list_cubit.dart';

sealed class WatchListState {}

final class WatchListInitial extends WatchListState {}
final class LoadMoviesState extends WatchListState {}


final class GetMoviesWatchListLoadingState extends WatchListState {}
final class GetMoviesWatchListSuccessState extends WatchListState {}
final class GetMoviesWatchListErrorState extends WatchListState {}

final class AddMoviesWatchListLoadingState extends WatchListState {}
final class AddMoviesWatchListSuccessState extends WatchListState {}
final class AddMoviesWatchListErrorState extends WatchListState {}

final class GetProfileDataLoadingState extends WatchListState {}
final class GetProfileDataSuccessState extends WatchListState {}
final class GetProfileDataErrorState extends WatchListState {}

final class GetRatedMoviesLoadingState extends WatchListState {}
final class GetRatedMoviesSuccessState extends WatchListState {}
final class GetRatedMoviesErrorState extends WatchListState {}

final class AddRatedMoviesLoadingState extends WatchListState {}
final class AddRatedMoviesSuccessState extends WatchListState {}
final class AddRatedMoviesErrorState extends WatchListState {}

final class DeleteRatedMoviesLoadingState extends WatchListState {}
final class DeleteRatedMoviesSuccessState extends WatchListState {}
final class DeleteRatedMoviesErrorState extends WatchListState {}