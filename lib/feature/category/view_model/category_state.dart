part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class GetMoviesGenresLoadingState extends CategoryState {}
final class GetMoviesGenresSuccessState extends CategoryState {}
final class GetMoviesGenresErrorState extends CategoryState {}

final class CategoryMovieLoadingState extends CategoryState {}
final class CategoryMovieSuccessState extends CategoryState {}
final class CategoryMovieErrorState extends CategoryState {}