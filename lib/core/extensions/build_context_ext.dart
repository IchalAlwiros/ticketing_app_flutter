import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ticketapp/core/core.dart';

extension BuildContextExt on BuildContext {
  double get deviceHeight => MediaQuery.of(this).size.height;

  double get deviceWidth => MediaQuery.of(this).size.width;

  void showErrorSnackbar(String message) {
    ScaffoldMessenger.of(this)
        .showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.info, color: Colors.white),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            duration: const Duration(milliseconds: 1500),
            backgroundColor: Colors.red,
            dismissDirection: DismissDirection.down,
            behavior: SnackBarBehavior.floating,
          ),
        )
        .closed
        .then((value) => ScaffoldMessenger.of(this).clearSnackBars());
  }

  void showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(this)
        .showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.info, color: Colors.white),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            duration: const Duration(milliseconds: 1500),
            backgroundColor: AppColors.success,
            dismissDirection: DismissDirection.down,
            behavior: SnackBarBehavior.floating,
          ),
        )
        .closed
        .then((value) => ScaffoldMessenger.of(this).clearSnackBars());
  }
}

extension NavigatorExt on BuildContext {
  void pop<T extends Object>([T? result]) {
    Navigator.pop(this, result);
  }

  void popToRoot<T extends Object>() {
    Navigator.popUntil(this, (route) => route.isFirst);
  }

  Future<T?> push<T extends Object>(Widget widget, [String? name]) async {
    return Navigator.push<T>(
      this,
      MaterialPageRoute(
        builder: (context) => widget,
        settings: RouteSettings(name: name),
      ),
    );
  }

  Future<T?> pushReplacement<T extends Object, TO extends Object>(
      Widget widget) async {
    return Navigator.pushReplacement<T, TO>(
      this,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  Future<T?> pushAndRemoveUntil<T extends Object>(
      Widget widget, bool Function(Route<dynamic> route) predicate) async {
    return Navigator.pushAndRemoveUntil<T>(
      this,
      MaterialPageRoute(builder: (context) => widget),
      predicate,
    );
  }
}
