import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OroneoLogo extends StatelessWidget {
  final double size;
  final bool isLight;
  final bool useFullLogo;

  const OroneoLogo({
    Key? key,
    this.size = 48.0,
    this.isLight = false,
    this.useFullLogo = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Correction des chemins pour pointer vers le dossier logos
    final String assetName = useFullLogo
        ? (isLight ? 'assets/oroneo/logos/Logolight.svg' : 'assets/oroneo/logos/Logodark.svg')
        : (isLight
            ? 'assets/oroneo/logos/Olight.svg'
            : Theme.of(context).brightness == Brightness.dark
                ? 'assets/oroneo/logos/Odark.svg'
                : 'assets/oroneo/logos/Ogrey.svg');

    return SvgPicture.asset(
      assetName,
      width: useFullLogo ? size * 3 : size,
      height: size,
      semanticsLabel: 'Oroneo Logo',
    );
  }
}