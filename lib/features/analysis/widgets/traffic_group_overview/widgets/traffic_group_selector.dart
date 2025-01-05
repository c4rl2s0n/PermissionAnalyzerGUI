import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/features/analysis/values.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';

class TrafficGroupSelector extends StatelessWidget {
  const TrafficGroupSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalysisCubit, AnalysisState>(
      builder: (context, state) {
        return InfoContainer(
            title: "Group Selection",
            action: IconTextButton(
              icon: Icon(context.icons.check),
              text: "Apply",
              onTap: () => context.analysisCubit.reloadTrafficGroups(),
              padding: 2,
            ),
            child: Column(
              children: [
                Expanded(
                  child: TreeView.simple(
                    showRootNode: false,
                    shrinkWrap: true,
                    indentation:
                        const Indentation(style: IndentStyle.squareJoint),
                    expansionIndicatorBuilder: _extensionIndicator,
                    onTreeReady: _onTreeReady,
                    builder: _buildTreeNode,
                    tree: _generateTree(state.groups),
                  ),
                ),
              ],
            ));
      },
    );
  }

  List<TreeNode> _getAllNodes(INode node) {
    List<TreeNode> nodes = [];
    Iterable<TreeNode> children = node.childrenAsList.whereType<TreeNode>();
    nodes.addAll(children);
    for (var child in children) {
      nodes.addAll(_getAllNodes(child));
    }
    return nodes;
  }

  // expand the tree until there are multiple node on a level. Set them to show=true
  void _onTreeReady(TreeViewController controller) {
    bool showAny = false;
    List<TreeNode> allNodes = _getAllNodes(controller.tree.root);

    for (var node in allNodes) {
      if (node.data is! AnalysisTrafficGroupCubit) continue;
      AnalysisTrafficGroupCubit data = node.data as AnalysisTrafficGroupCubit;
      if (!data.state.show) continue;
      showAny = true;
      List<TreeNode> branch = [];
      // expand the whole path to this node
      while (node.parent is TreeNode) {
        node = node.parent as TreeNode;
        branch.add(node);
      }
      for (var n in branch.reversed) {
        if (!n.isExpanded) {
          controller.expandNode(n);
        }
      }
    }
    if (!showAny) {
      _showFirstNonSingleTreeLevel(controller);
    }
  }

  // expand the tree until there are multiple node on a level. Set them to show=true
  void _showFirstNonSingleTreeLevel(TreeViewController controller) {
    void showNode(TreeNode node, bool show) {
      if (node.data is AnalysisTrafficGroupCubit) {
        (node.data as AnalysisTrafficGroupCubit).setShow(show);
      }
    }

    try {
      TreeNode node = controller.tree.root as TreeNode;
      while (true) {
        showNode(node, false);
        var children = node.childrenAsList.whereType<TreeNode>();
        if (children.isEmpty) {
          // no more nodes, so show this one
          showNode(node, true);
          break;
        } else if (children.length > 1) {
          // if there are multiple child-nodes, expand them and set all to show=true
          //controller.expandAllChildren(node);
          controller.expandNode(node);
          for (var child in children) {
            showNode(child, true);
          }
          break;
        } else {
          // only one node, go to the next
          controller.expandNode(node);
          node = children.first;
        }
      }
    } catch (_) {
      controller.expandAllChildren(controller.tree);
    }
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
            onSecondaryTap: state.isSelected
                ? () => context.analysisTrafficGroupCubit.toggleShow()
                : null,
            child: IconButton(
              onPressed:
                  state.isSelected ? () => _toggleShow(node) : null,
              icon: Icon(state.show ? context.icons.show : context.icons.hide),
            ),
          );
          return Card(
            color: state.isSelected
                ? color
                : color.withOpacity(context.constants.mediumColorOpacity),
            child: ListTile(
              leading: leading,
              title: Text(group.name),
              subtitle: state.parent != null
                  ? Text(state.parent!.name)
                  : null,
              trailing: trailing,
            ),
          );
        },
      ),
    );
  }

  void _toggleShow(TreeNode node) {
    if (node.data is! AnalysisTrafficGroupCubit) return;

    AnalysisTrafficGroupCubit cubit = node.data as AnalysisTrafficGroupCubit;
    bool show = cubit.state.show;
    // if the group is already set to show=true, just toggle for the selected group
    if (show) {
      cubit.toggleShow();
      return;
    }

    // otherwise, disable show on all groups before setting the selected group + siblings to show=true
    Iterable<TreeNode> applications =
        node.root.childrenAsList.whereType<TreeNode>();
    for (TreeNode application in applications) {
      var cubit = application.data as AnalysisTrafficGroupCubit;
      cubit.setShowChildren(false);
    }

    // set show=true for selected node and siblings
    Iterable<TreeNode> siblings =
        node.parent?.childrenAsList.whereType<TreeNode>() ?? [];
    for (TreeNode n in siblings) {
      var cubit = n.data as AnalysisTrafficGroupCubit;
      if (!cubit.state.isSelected) continue;
      cubit.setShow(true);
    }
  }

  TreeNode _generateTree(List<AnalysisTrafficGroupCubit> groups) {
    TreeNode root = TreeNode.root();
    root.addAll(groups.map((g) => _addChildren(
          TreeNode(key: g.state.group.id, data: g),
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
      String key =
          "${keyPrefix}_${c.group.id}".replaceAll(INode.PATH_SEPARATOR, "_");
      return _addChildren(
        TreeNode(key: key, data: c),
        key,
        c.state.children,
      );
    }));
    return node;
  }
}
