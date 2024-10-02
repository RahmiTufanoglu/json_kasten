import "package:flutter/material.dart";
import "package:json_kasten/constants.dart";
import "package:json_kasten/json_formatter.dart";
import "package:json_kasten/theme_provider.dart";
import "package:json_kasten/themes.dart";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = ThemeNotifier(lightTheme);

    return ThemeProvider(
      notifier: themeNotifier,
      child: ListenableBuilder(
        listenable: themeNotifier,
        child: const JsonFormatter(),
        builder: (_, child) {
          return MaterialApp(
            title: appName,
            theme: themeNotifier.themeData,
            //darkTheme: darkTheme,
            themeAnimationCurve: Curves.fastLinearToSlowEaseIn,
            home: child,
          );
        },
      ),
    );
  }
}
