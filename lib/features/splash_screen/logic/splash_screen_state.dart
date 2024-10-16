part of 'splash_screen_cubit.dart';


class SplashScreenState extends Equatable {
  const SplashScreenState({this.isDone = false});

  final bool isDone;

  @override
  List<Object?> get props => [isDone];

  SplashScreenState copyWith({bool? isDone}) {
    return SplashScreenState(isDone: isDone ?? this.isDone);
  }
}
