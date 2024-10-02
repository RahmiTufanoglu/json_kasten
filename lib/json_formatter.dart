import "dart:convert";
import "dart:developer";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:json_kasten/colors.dart";
import "package:json_kasten/constants.dart";
import "package:json_kasten/theme_provider.dart";
import "package:json_kasten/themes.dart";

class JsonFormatter extends StatefulWidget {
  const JsonFormatter({super.key});

  @override
  State<JsonFormatter> createState() => _JsonFormatterState();
}

class _JsonFormatterState extends State<JsonFormatter> {
  final _jsonInputController = TextEditingController();
  var _formattedJson = "";

  @override
  void dispose() {
    _jsonInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              appName,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            ListenableBuilder(
              listenable: ThemeProvider.of(context),
              builder: (context, child) {
                return IconButton(
                  color: AppColors.white,
                  style: IconButton.styleFrom(
                    backgroundColor: ThemeProvider.of(context).themeData == lightTheme //
                        ? AppColors.black
                        : AppColors.white,
                    shape: const CircleBorder(),
                  ),
                  onPressed: () => ThemeProvider.of(context).toggleTheme(),
                  icon: Icon(
                    ThemeProvider.of(context).themeData == lightTheme //
                        ? Icons.nightlight_round
                        : Icons.wb_sunny,
                    color: ThemeProvider.of(context).themeData == lightTheme //
                        ? AppColors.white
                        : AppColors.black,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _jsonInputController,
              decoration: const InputDecoration(
                hintText: "Enter your JSON string here",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: AppColors.black10,
              ),
              maxLines: 15,
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: _format,
                    child: const Text(
                      "Format JSON",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: FilledButton(
                    onPressed: _clearWhitespace,
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                    child: const Text(
                      "Clear Whitespace",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            if (_formattedJson.isNotEmpty)
              Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.white10,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _formattedJson,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () => Clipboard.setData(ClipboardData(text: _formattedJson)),
                      icon: const Icon(Icons.copy),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _format() {
    final input = _jsonInputController.text;
    final readableJson = _beautifyJson(input);

    setState(() {
      _formattedJson = readableJson;
    });
  }

  String _beautifyJson(String input) {
    var beautified = "";
    var indentLevel = 0;
    var insideQuotes = false;

    for (var i = 0; i < input.length; i++) {
      final char = input[i];

      if (char == '"') {
        insideQuotes = !insideQuotes;
      }

      if (!insideQuotes) {
        if (char == "{" || char == "[") {
          beautified += char + "  " * ++indentLevel;
        } else if (char == "}" || char == "]") {
          beautified += "  " * --indentLevel + char;
        } else if (char == ",") {
          beautified += char + "  " * indentLevel;
        } else if (char == ":") {
          beautified += "$char ";
        } else {
          beautified += char;
        }
      } else {
        beautified += char;
      }
    }

    return beautified;
  }

  void _clearWhitespace() {
    try {
      if (_jsonInputController.text.isEmpty) {
        throw Exception("Input is empty!");
      }

      final jsonString = _jsonInputController.text.trim();
      final processed = jsonString.replaceAll(RegExp(r"\s+"), "");

      setState(() {
        _formattedJson = processed;
      });
    } catch (e, s) {
      log(e.toString(), stackTrace: s, name: "clearWhitespace()");

      setState(() {
        _formattedJson = "Invalid JSON format!";
      });
    }
  }
}
