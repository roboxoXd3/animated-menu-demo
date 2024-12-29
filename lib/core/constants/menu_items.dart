import 'package:flutter/material.dart';
import '../../presentation/widgets/animated_menu/menu_item_data.dart';

final List<MenuItemData> menuItems = [
  MenuItemData(
    icon: Icons.camera_alt_rounded,
    color: Color(0xFF2196F3),
    label: 'Camera',
  ),
  MenuItemData(
    icon: Icons.favorite_rounded,
    color: Color(0xFFE91E63),
    label: 'Favorite',
  ),
  MenuItemData(
    icon: Icons.edit_rounded,
    color: Color(0xFF4CAF50),
    label: 'Edit',
  ),
  MenuItemData(
    icon: Icons.share_rounded,
    color: Color(0xFF9C27B0),
    label: 'Menu',
  ),
];
