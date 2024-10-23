import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';

import '../logic/logic.dart';

class TestConstellationsOverview extends StatelessWidget {
  const TestConstellationsOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoContainer(
        title: "Test Constellations",
        child: BlocBuilder<TestScenarioCubit, TestScenarioState>(
            buildWhen: (oldState, state) =>
                oldState.testConstellations != state.testConstellations,
            builder: (context, state) {
              double columnWidth = 50;
              return ScrollContainer(
                scrollDirection: Axis.horizontal,
                scrollbarOrientation: ScrollbarOrientation.bottom,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _columnHeaders(
                      context,
                      columnWidth: columnWidth,
                      state: state,
                    ),
                    Expanded(
                      child: ScrollContainer(
                        //scrollbarOrientation: ScrollbarOrientation.right,
                        scrollDirection: Axis.vertical,
                        child: _rows(
                          context,
                          columnWidth: columnWidth,
                          state: state,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }));
  }

  Widget _columnHeaders(
    BuildContext context, {
    required double columnWidth,
    required TestScenarioState state,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.constants.spacing),
      child: Container(
        decoration: BoxDecoration(
            border: BorderDirectional(
          bottom: BorderSide(color: context.colors.onBackground),
        )),
        padding:
            EdgeInsets.symmetric(horizontal: context.constants.smallSpacing),
        child: Row(
          children: [
            SizedBox(
              width: columnWidth/2,
              child: Text("#"),
            ),
            ...state.permissions.map<Widget>(
              (p) => SizedBox(
                width: columnWidth,
                child: Tooltip(
                  message: p.permission,
                  child: Text(p.permission
                      .split(".")
                      .last
                      .split("_")
                      .map((p) => p.substring(0, 1))
                      .join(), textAlign: TextAlign.center,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rows(
    BuildContext context, {
    required double columnWidth,
    required TestScenarioState state,
  }) {
    return Column(
      children: state.testConstellations
          .map<Widget>((c) => TapContainer(
                onTap: () => print(c.permissions),
                padding: EdgeInsets.symmetric(
                    horizontal: context.constants.smallSpacing),
                child: Row(
                  children: [
                    SizedBox(
                      width: columnWidth/2,
                      child: Text(
                          (state.testConstellations.indexOf(c) + 1).toString()),
                    ),
                    ...c.permissions.map<Widget>((p) => SizedBox(
                          width: columnWidth,
                          child: context.permissionStateIcon(p.state),
                        ))
                  ], //.insertBetweenItems(() =>Margin.horizontal(context.constants.smallSpacing)),
                ),
              ))
          .toList()
          .insertBetweenItems(
              () => Margin.vertical(context.constants.smallSpacing)),
    );
  }
}
