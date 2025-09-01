import 'package:flutter/material.dart';

class StyledAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  const StyledAppBar({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.transparent,
      title: Text('Welcome, $username!', style: TextStyle(color: Colors.white)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
