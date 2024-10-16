import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_template/common/common.dart';
import 'package:flutter_template/features/features.dart';

import 'logic/splash_screen_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashScreenCubit>(
      create: (context) => SplashScreenCubit(),
      child: BlocListener<SplashScreenCubit, SplashScreenState>(
        listenWhen: (_, state) => state.isDone,
        listener: (context, state) async {
          context.navigator.navigateAndClearRoute(const HomePage());
        },
        child: Container(
          color: context.colors.background,
          child: Center(
            child: Image.asset("assets/images/ic_launcher.png"),
          ),
        ),
      ),
    );
  }
}
