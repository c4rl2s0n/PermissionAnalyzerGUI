import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

import 'widgets/widgets.dart';

class EndpointOverview extends StatelessWidget {
  const EndpointOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.constants.spacing),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            flex: 3,
            child: Column(
              children: <Widget>[
                const Flexible(child: TrafficGroupOverviewTable()),
                const Flexible(child: EndpointOverviewTable()),
              ].insertBetweenItems(
                  () => Margin.vertical(context.constants.spacing)),
            )),
        const Flexible(
          flex: 1,
          child: Column(
            children: [
              Expanded(child: EndpointGroupSelector()),
            ],
          ),
        ),
      ].insertBetweenItems(() => Margin.horizontal(context.constants.spacing)),
    );
  }
}
