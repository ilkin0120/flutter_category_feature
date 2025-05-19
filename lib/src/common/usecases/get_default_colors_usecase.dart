import 'package:flutter/material.dart';

class GetDefaultColorsUseCase {
  List<Color> call(int rows, int columns) {
    final colors = <Color>[];

    const materialColors = [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.brown,
      Colors.grey,
      Colors.blueGrey,
    ];

    const mainShades = [300, 400, 500, 600, 700];
    for (final color in materialColors) {
      for (final shade in mainShades) {
        colors.add(color[shade]!);
      }
    }

    colors.addAll([
      Colors.redAccent.shade200,
      Colors.blueAccent.shade200,
      Colors.greenAccent.shade200,
      Colors.yellowAccent.shade200,
      Colors.orangeAccent.shade200,
    ]);

    colors.addAll([
      Colors.black,
      Colors.white,
      Colors.grey.shade800,
      Colors.brown.shade300,
      Colors.pink.shade100,
    ]);

    const hsvRows = 12;
    const hsvColumns = 6;

    for (int row = 0; row < hsvRows; row++) {
      for (int col = 0; col < hsvColumns; col++) {
        final hue = (row * 360 / hsvRows) % 360;
        final saturation = 0.6 + (col / hsvColumns) * 0.3;
        final value = 0.7 - (col / hsvColumns) * 0.3;
        colors.add(HSVColor.fromAHSV(1.0, hue, saturation, value).toColor());
      }
    }

    return colors.toSet().toList();
  }
}
