import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/features/features.dart';

import 'logic/splash_screen_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashScreenCubit>(
      create: (context) => SplashScreenCubit(context.settings, context.session),
      child: BlocListener<SplashScreenCubit, SplashScreenState>(
        listenWhen: (_, state) => state.isDone,
        listener: (context, state) async {
          context.navigator.navigateAndClearRoute(const ProjectOverview());
          // context.navigator.navigateAndClearRoute(
          //   TestScenario(
          //     Modular.get<data.ITestScenarioRepository>()
          //             .getTestScenarios("com.zzkko")
          //             .firstOrNull ??
          //         data.TestScenario(applicationId: "com.zzkko"),
          //   ),
          // );
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
