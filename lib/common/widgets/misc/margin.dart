import 'package:flutter/cupertino.dart';

class Margin extends StatelessWidget {
  const Margin({this.marginHorizontal = 0, this.marginVertical = 0, super.key});
  const Margin.all(double margin, {Key? key})
      : this(marginVertical: margin, marginHorizontal: margin, key: key);
  const Margin.vertical(double margin, {Key? key})
      : this(marginVertical: margin, key: key);
  const Margin.horizontal(double margin, {Key? key})
      : this(marginHorizontal: margin, key: key);

  final double marginHorizontal;
  final double marginVertical;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: marginHorizontal,
      height: marginVertical,
    );
  }
}
