import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/common/widgets/factories/context_menu_factory.dart';
import 'package:permission_analyzer_gui/data/data.dart';

import '../logic/logic.dart';

class FirewallSelector extends StatelessWidget {
  const FirewallSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestScenarioCubit, TestScenarioState>(
      buildWhen: (oldState, state) =>
          oldState.firewallSettings != state.firewallSettings,
      builder: (context, state) => InfoContainer(
        title: "Firewall Settings (${state.firewallSettings.length})",
        scrollable: true,
        action: _buildActions(context),
        child: Column(
            children: state.firewallSettings
                .map((f) => _buildContainer(context, f))
                .toList()),
      ),
    );
  }

  Widget _buildContainer(
      BuildContext context, FirewallSetting firewallSetting) {
    return Optional.tooltip(
      tooltip: firewallSetting.endpoint!.serverNames.join("\n"),
      show: firewallSetting.endpoint?.hasServerName ?? false,
      child: TapContainer(
        backgroundColor: Colors.transparent,
        onTap: (_) =>
            context.testScenarioCubit.toggleFirewallState(firewallSetting.ip),
        onSecondaryTap: (o) => _buildContextMenu(context, o, firewallSetting),
        padding: EdgeInsets.symmetric(horizontal: context.constants.smallSpacing),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                      firewallSetting.endpoint?.hostname ?? firewallSetting.ip)),
              firewallSetting.blocked
                  ? Icon(
                      context.icons.cancel,
                      color: context.colors.negative,
                    )
                  : Icon(
                      context.icons.check,
                      color: context.colors.positive,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void _buildContextMenu(BuildContext context, Offset? position, FirewallSetting firewallSetting) {
    if (position == null) return;
    TestScenarioCubit tsc = context.testScenarioCubit;
    List<String> ipParts = firewallSetting.ip.split(".");
    ContextMenuFactory.showContextMenuOnPosition(
      context,
      position,
      [
        if(firewallSetting.blocked)...[
          ContextMenuItem(name: "Unblock IP Range (${ipParts[0]}.${ipParts[1]}.${ipParts[2]}.0/24)", onTap: (context)=>tsc.setFirewallStateIpRange(firewallSetting.ip, 3, false), icon: Icon(context.icons.check, color: context.colors.positive,)),
          ContextMenuItem(name: "Unblock IP Range (${ipParts[0]}.${ipParts[1]}.0.0/16)", onTap: (context)=>tsc.setFirewallStateIpRange(firewallSetting.ip, 2, false), icon: Icon(context.icons.check, color: context.colors.positive,)),
          ContextMenuItem(name: "Unblock in IP Range (${ipParts[0]}.0.0.0/8)", onTap: (context)=>tsc.setFirewallStateIpRange(firewallSetting.ip, 1, false), icon: Icon(context.icons.check, color: context.colors.positive,)),
          if(firewallSetting.endpoint?.domainString != null) ContextMenuItem(name: "Unblock Domain (${firewallSetting.endpoint!.domainString!})", onTap: (context)=>tsc.setFirewallStateByDomain(firewallSetting.endpoint!.domainString!, false), icon: Icon(context.icons.check, color: context.colors.positive,)),
        ]else...[
          ContextMenuItem(name: "Block IP Range (${ipParts[0]}.${ipParts[1]}.${ipParts[2]}.0/24; known Endpoints only)", onTap: (context)=>tsc.setFirewallStateIpRange(firewallSetting.ip, 3, true), icon: Icon(context.icons.cancel, color: context.colors.negative,)),
          ContextMenuItem(name: "Block IP Range (${ipParts[0]}.${ipParts[1]}.0.0/16; known Endpoints only)", onTap: (context)=>tsc.setFirewallStateIpRange(firewallSetting.ip, 2, true), icon: Icon(context.icons.cancel, color: context.colors.negative,)),
          ContextMenuItem(name: "Block IP Range (${ipParts[0]}.0.0.0/8; known Endpoints only)", onTap: (context)=>tsc.setFirewallStateIpRange(firewallSetting.ip, 1, true), icon: Icon(context.icons.cancel, color: context.colors.negative,)),
          if(firewallSetting.endpoint?.domainString != null) ContextMenuItem(name: "Block Domain (${firewallSetting.endpoint!.domainString!}; known Endpoints only)", onTap: (context)=>tsc.setFirewallStateByDomain(firewallSetting.endpoint!.domainString!, true), icon: Icon(context.icons.cancel, color: context.colors.negative,)),
        ]
        
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: <Widget>[
        IconTextButton(
          text: "Reset",
          icon: Icon(context.icons.reset),
          color: context.colors.negative,
          onTap: context.testScenarioCubit.resetAllFirewallStates,
          verticalPadding: 2,
        ),
        IconTextButton(
          text: "Toggle all",
          icon: Icon(context.icons.toggle),
          onTap: context.testScenarioCubit.toggleAllFirewallStates,
          verticalPadding: 2,
        ),
      ].insertBetweenItems(() => Margin.horizontal(context.constants.spacing)),
    );
  }
}
