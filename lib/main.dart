import 'package:bar_code/pages/camera_page.dart';
import 'package:bar_code/pages/home.dart';
import 'package:bar_code/pages/loading.dart';
import 'package:flutter/material.dart';

import 'package:dynamic_color/dynamic_color.dart';

const _brandBlue = Color(0xFF1EE5A6);

void main() => runApp(const BarcodeScanner());

class BarcodeScanner extends StatelessWidget {
  const BarcodeScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && darkDynamic != null) {
          // On Android S+ devices, use the provided dynamic color scheme.
          // (Recommended) Harmonize the dynamic color scheme' built-in semantic colors.
          lightColorScheme = lightDynamic.harmonized();

          // Repeat for the dark color scheme.
          darkColorScheme = darkDynamic.harmonized();
        } else {
          // Otherwise, use fallback schemes.
          lightColorScheme = ColorScheme.fromSeed(
            seedColor: _brandBlue,
          );
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: _brandBlue,
            brightness: Brightness.dark,
          );
        }
        return MaterialApp(
            theme: ThemeData(colorScheme: lightColorScheme, useMaterial3: true),
            darkTheme:
                ThemeData(colorScheme: darkColorScheme, useMaterial3: true),
              initialRoute: "/home",
            routes: {
              "/home": (context) =>  HomeScreen(),
              "/camera_page": (context) => const CameraPage(),
              // "loading": (context) => const LoadingScreen(),
            });
      },
    );
  }
}
