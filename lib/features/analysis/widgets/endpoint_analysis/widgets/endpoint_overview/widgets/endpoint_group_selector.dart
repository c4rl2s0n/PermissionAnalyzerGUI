import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/features/analysis/values.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/endpoint_analysis/logic/logic.dart';

class EndpointGroupSelector extends StatelessWidget {
  const EndpointGroupSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EndpointAnalysisCubit, EndpointAnalysisState>(
      builder: (context, state) {
        return InfoContainer(
            title: "Group Selection",
            action: IconTextButton(
              icon: Icon(context.icons.check),
              text: "Apply",
              onTap: () => context.endpointAnalysisCubit.reloadTrafficGroups(),
              padding: 2,
            ),
            child: TreeView.simple(
              showRootNode: false,
              shrinkWrap: true,
              indentation: const Indentation(style: IndentStyle.squareJoint),
              expansionIndicatorBuilder: _extensionIndicator,
              onTreeReady: (controller) =>
                  controller.expandAllChildren(controller.tree),
              builder: _buildTreeNode,
              tree: _generateTree(state.groups),
            ));
      },
    );
  }

  ExpansionIndicator _extensionIndicator(
          BuildContext context, ITreeNode<dynamic> node) =>
      ChevronIndicator.rightDown(
        tree: node,
        color: Colors.blue,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(8),
      );

  Widget _buildTreeNode(BuildContext context, TreeNode node) {
    AnalysisTrafficGroupCubit group = node.data as AnalysisTrafficGroupCubit;
    Color color = Colors.white70;
    for (var tag in group.tags) {
      if (tagColors.containsKey(tag)) {
        color = tagColors[tag]!;
        break;
      }
    }
    return BlocProvider.value(
      value: group,
      child: BlocBuilder<AnalysisTrafficGroupCubit, AnalysisTrafficGroupState>(
        builder: (context, state) {
          IconData icon;
          switch (state.selected) {
            case SelectionState.deselected:
              icon = context.icons.checkboxDeselected;
              break;
            case SelectionState.selected:
              icon = context.icons.checkboxSelected;
              break;
            case SelectionState.custom:
              icon = context.icons.checkboxCustom;
              break;
          }
          IconButton leading = IconButton(
            onPressed: context.analysisTrafficGroupCubit.toggleSelected,
            icon: Icon(icon),
          );
          Widget trailing = GestureDetector(
            onSecondaryTap: () => context.analysisTrafficGroupCubit.toggleShowChildren(),
            child: IconButton(
              onPressed: () => context.analysisTrafficGroupCubit.toggleShow(),
              icon: Icon(state.show ? context.icons.show : context.icons.hide),
            ),
          );
          return Card(
            color: color,
            child: ListTile(
              leading: leading,
              title: Text(group.name),
              subtitle: group.state.parent != null
                  ? Text(group.state.parent!.name)
                  : null,
              trailing: trailing,
            ),
          );
        },
      ),
    );
  }

  TreeNode _generateTree(List<AnalysisTrafficGroupCubit> groups) {
    TreeNode root = TreeNode.root();
    root.addAll(groups.map((g) => _addChildren(
          TreeNode(key: g.state.group.name, data: g),
          g.group.name,
          g.state.children,
        )));
    return root;
  }

  TreeNode _addChildren(
    TreeNode node,
    String keyPrefix,
    List<AnalysisTrafficGroupCubit> children,
  ) {
    if (children.isEmpty) return node;
    node.addAll(children.map((c) {
      String key = "${keyPrefix}_${c.group.name}";
      return _addChildren(
        TreeNode(key: key, data: c),
        key,
        c.state.children,
      );
    }));
    return node;
  }
}
