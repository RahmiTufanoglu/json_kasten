import "package:flutter/material.dart";
import "package:json_kasten/themes.dart";

class ThemeProvider extends InheritedWidget {
  const ThemeProvider({
    required super.child,
    required this.notifier,
    super.key,
  });

  final ThemeNotifier notifier;

  static ThemeNotifier of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>()!.notifier;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

class ThemeNotifier extends ChangeNotifier {
  ThemeNotifier(this._themeData);

  ThemeData _themeData;

  ThemeData get themeData => _themeData;

  void toggleTheme() {
    _themeData = _themeData == lightTheme ? darkTheme : lightTheme;

    notifyListeners();
  }
}
