import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ColorsTool extends StatelessWidget {
  final Color splashColor;
  final void Function(Color selectedColor) onColorSelected;
  const ColorsTool(
      {super.key, required this.splashColor,required this.onColorSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.9.h,
      width: 26.1.w,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        color: splashColor,
      ),
      child: Center(
        child: SizedBox(
          height: 17.7.h,
          width: 18.7.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buildColorRows(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildColorRows(BuildContext context) {
    final colors = [
      const Color.fromRGBO(87, 220, 54, 1),
      const Color.fromRGBO(0, 0, 0, 1),
      const Color.fromRGBO(40, 46, 193, 1),
      const Color.fromRGBO(232, 201, 39, 1),
      const Color.fromRGBO(205, 41, 41, 1),
      const Color.fromRGBO(187, 45, 190, 1),
      const Color.fromRGBO(255, 255, 255, 1),
      const Color.fromRGBO(204, 204, 204, 1),
    ];

    List<Widget> rows = [];
    for (int i = 0; i < colors.length; i += 2) {
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildColorTile(context, colors[i]),
          _buildColorTile(context, colors[i + 1]),
        ],
      ));
    }
    return rows;
  }

  Widget _buildColorTile(BuildContext context, Color color) {
    return GestureDetector(
      onTap: () =>
        onColorSelected(color),
      child: Container(
        height: 3.9.h,
        width: 3.9.h,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: color,
        ),
      ),
    );
  }
}
