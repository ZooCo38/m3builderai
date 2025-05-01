import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/oroneo_logo.dart';

class OroneoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenuPressed;
  final VoidCallback? onBackPressed;  // Ajout du callback
  final List<Widget>? additionalActions;

  const OroneoAppBar({
    super.key,
    required this.onMenuPressed,
    this.onBackPressed,  // Paramètre optionnel
    this.additionalActions,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      centerTitle: true,
      backgroundColor: colorScheme.surface,
      leading: IconButton(
        icon: onBackPressed != null 
            ? Icon(Icons.arrow_back, color: colorScheme.onSurface)
            : SvgPicture.asset(
                'assets/oroneo/icons/menu.svg',
                colorFilter: ColorFilter.mode(colorScheme.onSurface, BlendMode.srcIn),
              ),
        onPressed: onBackPressed ?? onMenuPressed,
      ),
      title: const OroneoLogo(size: 20, useFullLogo: true),
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            'assets/oroneo/icons/notifications.svg',
            colorFilter: ColorFilter.mode(colorScheme.onSurface, BlendMode.srcIn),
          ),
          onPressed: () {},
        ),
        ...?additionalActions,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}