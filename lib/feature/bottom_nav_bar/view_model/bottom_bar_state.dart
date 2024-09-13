part of 'bottom_bar_cubit.dart';

@immutable
sealed class BottomBarState {}

final class BottomBarInitial extends BottomBarState {}

final class ChangeIndexState extends BottomBarState {}
