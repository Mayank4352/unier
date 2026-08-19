import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Draws an exported SVG at an explicit size, tinted to a theme colour.
class AppSvgIcon extends StatelessWidget {
  const AppSvgIcon(
    this.asset, {
    required this.size,
    this.color,
    this.semanticLabel,
    super.key,
  });

  final String asset;
  final double size;
  final Color? color;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: SvgPicture.asset(
        asset,
        width: size,
        height: size,
        fit: BoxFit.contain,
        semanticsLabel: semanticLabel,
        colorFilter: color == null
            ? null
            : ColorFilter.mode(color!, BlendMode.srcIn),
      ),
    );
  }
}
