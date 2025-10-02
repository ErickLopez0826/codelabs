// Copyright 2018-present the Flutter authors. All Rights Reserved.

import 'package:flutter/material.dart';

import 'backdrop.dart';
import 'category_menu_page.dart';              // <-- importa el menú de categorías
import 'colors.dart';
import 'home.dart';
import 'login.dart';
import 'model/product.dart';                   // <-- para Category
import 'supplemental/cut_corners_border.dart';

// =====================
//  ShrineApp Stateful
// =====================
class ShrineApp extends StatefulWidget {
  const ShrineApp({Key? key}) : super(key: key);

  @override
  _ShrineAppState createState() => _ShrineAppState();
}

class _ShrineAppState extends State<ShrineApp> {
  // Categoría seleccionada (por defecto: todas)
  Category _currentCategory = Category.all;

  // Callback cuando se toca una categoría en el menú
  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shrine',
      initialRoute: '/login',
      theme: _kShrineTheme, // usa el tema personalizado del codelab
      routes: {
        '/login': (BuildContext context) => const LoginPage(),

        // Backdrop con HomePage y CategoryMenuPage
        '/': (BuildContext context) => Backdrop(
              // pasa la categoría seleccionada
              currentCategory: _currentCategory,

              // Front layer: HomePage (debe aceptar la categoría en tu Home)
              // Si tu HomePage aún no recibe categoría, cámbialo a: HomePage()
              frontLayer: HomePage(category: _currentCategory),

              // Back layer: menú de categorías con callback
              backLayer: CategoryMenuPage(
                currentCategory: _currentCategory,
                onCategoryTap: _onCategoryTap,
              ),

              // Títulos de AppBar para cada capa
              frontTitle: const Text('SHRINE'),
              backTitle: const Text('MENU'),
            ),
      },
    );
  }
}

// =====================
//  Tema Shrine (MDC-103)
// =====================
final ThemeData _kShrineTheme = _buildShrineTheme();

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light(useMaterial3: true);
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: kShrinePink100,
      onPrimary: kShrineBrown900,
      secondary: kShrineBrown900,
      error: kShrineErrorRed,
    ),
    textTheme: _buildShrineTextTheme(base.textTheme),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: kShrinePink100,
    ),
    // Iconografía opcional:
    iconTheme: base.iconTheme.copyWith(color: kShrineBrown900),

    // Estilo de inputs (usa el borde recortado del codelab)
    inputDecorationTheme: const InputDecorationTheme(
      border: CutCornersBorder(),
      focusedBorder: CutCornersBorder(
        borderSide: BorderSide(width: 2.0, color: kShrineBrown900),
      ),
      floatingLabelStyle: TextStyle(color: kShrineBrown900),
    ),
  );
}

// Tipografías (ajusta a tu font 'Rubik' ya declarada en pubspec.yaml)
TextTheme _buildShrineTextTheme(TextTheme base) {
  return base.copyWith(
    headlineSmall: base.headlineSmall?.copyWith(fontWeight: FontWeight.w500),
    headlineLarge: base.headlineLarge?.copyWith(fontSize: 18.0),
    bodySmall: base.bodySmall?.copyWith(fontWeight: FontWeight.w400, fontSize: 14.0),
    bodyLarge: base.bodyLarge?.copyWith(fontWeight: FontWeight.w500, fontSize: 16.0),
  ).apply(
    fontFamily: 'Rubik',
    displayColor: kShrineBrown900,
    bodyColor: kShrineBrown900,
  );
}
