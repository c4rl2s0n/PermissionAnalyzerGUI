
import 'package:flutter/material.dart';

/// Wrapper for some navigation functionality
///
/// DO NOT reuse this, always create a new NavigationService as the context might have changed!!
class NavigationService{
  const NavigationService(this.context);
  final BuildContext context;
  
  void pop() {
    Navigator.of(context).pop();
  }

  void maybePop() {
    Navigator.of(context).pop();
  }

  void popUntil(RoutePredicate predicate) {
    Navigator.of(context).popUntil(predicate);
  }

  void navigateAndClearRoute(Widget destination) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (ctx) => destination,
      ), (_) => false,
    );
  }

  void navigateTo(Widget destination, {String? name}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => destination,
        settings: RouteSettings(name: name),
      ),
    );
  }
}