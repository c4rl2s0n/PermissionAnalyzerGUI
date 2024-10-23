import 'package:permission_analyzer_gui/common/common.dart';
import 'package:flutter/material.dart';

class DataListTile extends StatelessWidget {
  const DataListTile(
    this.name, {
    this.textColor,
    this.nameTextDecoration,
    this.backgroundColor,
    this.image,
    this.circularImage = false,
    this.statusMarker,
    this.infoRow,
    this.onTap,
    this.onLongPress,
    this.trailing,
    this.padding,
    this.height,
    super.key,
  }) : assert(statusMarker == null || statusMarker.length <= 4);

  final String name;
  final Color? textColor;
  final TextDecoration? nameTextDecoration;
  final Color? backgroundColor;
  final Widget? image;
  final bool circularImage;
  final List<Widget>? statusMarker;
  final List<Widget>? infoRow;
  final Widget? trailing;

  final EdgeInsetsGeometry? padding;

  final double? height;

  final Future Function(BuildContext)? onTap;
  final Future Function(BuildContext)? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets
              .zero, // const EdgeInsets.symmetric(horizontal: style.margin),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          height: height ?? context.constants.listTileHeight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(context.constants.roundedCornerRadius),
              color: backgroundColor,
          ),
          child: InkWell(
            borderRadius: BorderRadius.all(context.constants.roundedCornerRadius),
            splashColor: context.colors.secondary,
            highlightColor: context.colors.highlight,
            hoverColor: context.colors.onBackground
                .withOpacity(context.constants.strongColorOpacity),
            splashFactory: InkRipple.splashFactory,
            mouseCursor:
                onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
            onTap: onTap == null ? null : () => _performDelayedTap(context),
            onLongPress: onLongPress == null
                ? null
                : () async => await onLongPress?.call(context),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Margin.horizontal(context.constants.spacing),
                      if (image != null) _buildImage(context),
                      _buildInfos(context),
                    ],
                  ),
                ),
                if (trailing != null) ...[
                  _buildTrailing(context),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _performDelayedTap(BuildContext context) async {
    // Delay to show ripple-effect before executing the command
    await Future.delayed(
      const Duration(milliseconds: 150),
      () {
        if (context.mounted) onTap!.call(context);
      },
    );
  }

  Widget _buildImage(BuildContext context) {
    return SizedBox(
      width: context.constants.listTileHeight,
      height: context.constants.listTileHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            width: context.constants.listTileHeight,
            height: context.constants.listTileHeight,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
                horizontal: context.constants.listTileImageMargin,
            ),
            child: ClipRRect(
              borderRadius: circularImage
                  ? BorderRadius.all(
                      Radius.circular(context.constants.listTileHeight / 2))
                  : BorderRadius.all(context.constants.roundedCornerRadius),
              child: image,
            ),
          ),
          if (statusMarker != null) ..._buildStatusMarker(context),
        ],
      ),
    );
  }

  List<Widget> _buildStatusMarker(BuildContext context) {
    assert(statusMarker != null);
    List<Widget> marker = [];
    for (int i = 0; i < 4 && i < statusMarker!.length; i++) {
      Alignment alignment = Alignment.topLeft;
      switch (i) {
        case 1:
          alignment = Alignment.topRight;
          break;
        case 2:
          alignment = Alignment.bottomLeft;
          break;
        case 3:
          alignment = Alignment.bottomRight;
          break;
        default:
          alignment = Alignment.topLeft;
          break;
      }
      marker.add(
        Align(
          alignment: alignment,
          child: SizedBox(
            width: context.constants.statusMarkerSize,
            height: context.constants.statusMarkerSize,
            child: statusMarker![i],
          ),
        ),
      );
    }
    return marker;
  }

  Widget _buildInfos(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            name,
            style: context.textTheme.labelLarge?.copyWith(
              color: textColor ?? context.colors.onBackground,
              decoration: nameTextDecoration,
            ),
          ),
          if (infoRow != null) ...[
            DefaultTextStyle(
              style: context.textTheme.labelSmall!.copyWith(
                color: textColor?.withOpacity(context.constants.subtleColorOpacity) ??
                    context.colors.onBackground
                        .withOpacity(context.constants.subtleColorOpacity),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: infoRow!,
              ),
            )
          ],
        ],
      ),
    );
  }

  Widget _buildTrailing(BuildContext context) {
    assert(trailing != null);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        trailing!,
        Margin.horizontal(context.constants.spacing / 2),
      ],
    );
  }
}
