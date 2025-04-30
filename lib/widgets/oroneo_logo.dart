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
    final colorScheme = Theme.of(context).colorScheme;
    final String assetName = useFullLogo
        ? 'assets/oroneo/logos/Logodark.svg'
        : 'assets/oroneo/logos/Ogrey.svg';

    return SvgPicture.asset(
      assetName,
      width: useFullLogo ? size * 3 : size,
      height: size,
      semanticsLabel: 'Oroneo Logo',
      colorFilter: ColorFilter.mode(
        colorScheme.onBackground,
        BlendMode.srcIn,
      ),
    );
  }
}