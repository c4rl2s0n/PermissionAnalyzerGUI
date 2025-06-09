import 'package:flutter/services.dart';
import 'package:replay_bloc/replay_bloc.dart';

class KeyboardReplayCubit<State> extends ReplayCubit<State>{
  KeyboardReplayCubit(super.state){

    ServicesBinding.instance.keyboard.addHandler(_onKey);
  }

  @override
  Future<void> close() {
    ServicesBinding.instance.keyboard.removeHandler(_onKey);
    return super.close();
  }

  final Map<LogicalKeyboardKey, bool> _keyStates = {};
  bool get _shiftDown =>
      (_keyStates[LogicalKeyboardKey.shift] ?? false) ||
          (_keyStates[LogicalKeyboardKey.shiftLeft] ?? false) ||
          (_keyStates[LogicalKeyboardKey.shiftRight] ?? false);
  bool get _ctrlDown =>
      (_keyStates[LogicalKeyboardKey.control] ?? false) ||
          (_keyStates[LogicalKeyboardKey.controlLeft] ?? false) ||
          (_keyStates[LogicalKeyboardKey.controlRight] ?? false);

  bool _onKey(KeyEvent event) {
    final key = event.logicalKey; //.keyLabel;

    if (event is KeyDownEvent) {
      _keyStates[key] = true;
      _keyDownAction(key);
    } else if (event is KeyUpEvent) {
      _keyStates[key] = false;
    } else if (event is KeyRepeatEvent) {

    }
    return false;
  }

  void _keyDownAction(LogicalKeyboardKey key) {
    // handle undo / redo
    if (key == LogicalKeyboardKey.keyZ) {
      if (_ctrlDown) {
        if (_shiftDown) {
          redo();
        } else {
          undo();
        }
      }
    }
  }


}