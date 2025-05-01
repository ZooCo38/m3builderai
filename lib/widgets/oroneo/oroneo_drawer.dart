import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OroneoDrawer extends StatelessWidget {
  final VoidCallback? onLogoutTap;

  const OroneoDrawer({
    super.key,
    this.onLogoutTap,
  });

  Widget _buildSvgIcon(String assetName, {double size = 24, Color? color}) {
    return SvgPicture.asset(
      'assets/oroneo/icons/$assetName.svg',
      width: size,
      height: size,
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: _buildSvgIcon('chat_rounded'),
            title: const Text('Messages'),
          ),
          ListTile(
            leading: _buildSvgIcon('account_balance'),
            title: const Text('PER'),
          ),
          ListTile(
            leading: _buildSvgIcon('shield_rounded'),
            title: const Text('Assurance vie'),
          ),
          const Divider(),
          ListTile(
            leading: _buildSvgIcon('history_rounded'),
            title: const Text('Historique des conversations'),
          ),
          const Divider(),
          ListTile(
            leading: _buildSvgIcon('logout_rounded'),
            title: const Text('Déconnexion'),
            onTap: onLogoutTap,
          ),
        ],
      ),
    );
  }
}