import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/screen_record_overview/logic/logic.dart';


class TimelineSelectionDialog extends StatelessWidget {
  TimelineSelectionDialog(
    this.test,
    this.overviewCubit, {
    super.key,
  }){
    timelines = overviewCubit.timelineCubits.where((t) => t.timeline.test == test).toList();
    timelines.sort((a,b) => a.state.name.compareTo(b.state.name));
  }

  final TestRun test;
  final ScreenRecorderOverviewCubit overviewCubit;
  late final List<TimelineCubit> timelines;

  static Future showTimelineSelection(
    BuildContext context,
    TestRun test,
    ScreenRecorderOverviewCubit overviewCubit,
  ) async {
    await showDialog<List<ConnectionTimeline>?>(
      context: context,
      barrierDismissible: true,
      builder: (context) => TimelineSelectionDialog(
        test,
        overviewCubit,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: overviewCubit,
      child: CustomDialog(
        title: "Timeline Selection",
        expand: false,
        content: _options(context),
        icon: Icon(context.icons.settings),
        actions: const [CloseButton()],
      ),
    );
  }

  Widget _options(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(children: [
            Text("Test:", style: context.textTheme.labelMedium,),
            Margin.horizontal(context.constants.spacing),
            Text(test.name),
          ],),
          Margin.vertical(context.constants.spacing),
          ...timelines.map((t) => BlocProvider.value(
                value: t,
                child: BlocBuilder<TimelineCubit, TimelineState>(
                  buildWhen: (oldState, state) => oldState.name != state.name,
                  builder: (context, state) {
                    return MultiActionSetting(
                      name: state.name,
                      actions: [
                        _colorPicker(context, t),
                        _switch(context, t),
                      ],
                    );
                  },
                ),
              ))
        ].insertBetweenItems(
            () => Margin.horizontal(context.constants.largeSpacing)),
      ),
    );
  }

  Widget _colorPicker(BuildContext context, TimelineCubit timeline) {
    return BlocBuilder<TimelineCubit, TimelineState>(
      buildWhen: (oldState, state) => oldState.color != state.color,
      builder: (context, state) => ColorPicker.openButton(
        context,
        onColorSelected: (color) {
          if (color == null) return;
          timeline.setColor(color);
        },
        availableColors: overviewCubit.state.graphColors,
        selectedColor: state.color,
      ),
    );
  }

  Widget _switch(BuildContext context, TimelineCubit timeline) {
    return BlocBuilder<TimelineCubit, TimelineState>(
      buildWhen: (oldState, state) => oldState.selected != state.selected,
      builder: (context, state) {
        return Switch(
          value: state.selected,
          onChanged: (_) => timeline.toggleSelection(),
        );
      },
    );
  }
}
