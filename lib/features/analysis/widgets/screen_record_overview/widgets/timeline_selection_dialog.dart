import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/common/keys.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/screen_record_overview/logic/logic.dart';

class TimelineSelectionDialog extends StatelessWidget {
  TimelineSelectionDialog(
    this.test,
    this.overviewCubit, {
    super.key,
  }) {
    _prepareTimelines();
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

  void _prepareTimelines(){
    timelines = overviewCubit.timelineCubits
        .where((t) => t.timeline.test == test)
        .toList();
    timelines.sort((a, b) => a.state.name.compareTo(b.state.name));
    timelines = [
      ...timelines.where((t) => t.state.name == kTlTotal),
      ...timelines.where((t) => t.state.name != kTlTotal),
    ];
    for(var t in timelines){
      if(t.state.color == null){
        t.setColor(Colors.cyan);
      }
    }
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
            _dialogFirstLine(context),
            Margin.vertical(context.constants.spacing),
            ..._dialogEntries(context),
          ].insertBetweenItems(
              () => Margin.horizontal(context.constants.largeSpacing))),
    );
  }

  Widget _dialogFirstLine(BuildContext context) {
    return Row(
      children: [
        Text(
          "Test:",
          style: context.textTheme.labelMedium,
        ),
        Margin.horizontal(context.constants.spacing),
        Expanded(child: Text(test.name)),
        IconButton(
          onPressed: () {
            for (var t in timelines) {
              t.setSelection(false);
            }
          },
          icon: Icon(
            context.icons.cancel,
            color: context.colors.negative,
          ),
        ),
        IconButton(
          onPressed: () {
            for (var t in timelines) {
              t.setSelection(true);
            }
          },
          icon: Icon(
            context.icons.check,
            color: context.colors.positive,
          ),
        )
      ],
    );
  }

  Iterable<Widget> _dialogEntries(BuildContext context) {
    return timelines.map((t) => BlocProvider.value(
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
        ));
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
