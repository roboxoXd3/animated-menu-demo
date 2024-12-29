import 'package:flutter/material.dart';
import 'circular_flow_delegate.dart';
import 'menu_item_data.dart';
import '../../../core/constants/menu_items.dart';

class AnimatedMenu extends StatefulWidget {
  const AnimatedMenu({super.key});

  @override
  State<AnimatedMenu> createState() => _AnimatedMenuState();
}

class _AnimatedMenuState extends State<AnimatedMenu>
    with SingleTickerProviderStateMixin {
  bool isMenuOpen = false;
  late AnimationController _animationController;
  late Animation<double> _menuAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _menuAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
      reverseCurve: Curves.easeInBack,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
      if (isMenuOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Flow(
        delegate: CircularFlowMenuDelegate(
          animation: _menuAnimation,
          itemCount: menuItems.length,
          radius: 100,
        ),
        children: _buildMenuItems(),
      ),
    );
  }

  List<Widget> _buildMenuItems() {
    return menuItems.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      return _buildMenuItem(index, item);
    }).toList();
  }

  Widget _buildMenuItem(int index, MenuItemData item) {
    return SizedBox(
      width: 60,
      height: 60,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: index == menuItems.length - 1 ? 1.0 : _menuAnimation.value,
            child: child,
          );
        },
        child: _buildFloatingActionButton(index, item),
      ),
    );
  }

  Widget _buildFloatingActionButton(int index, MenuItemData item) {
    final isMainButton = index == menuItems.length - 1;

    return FloatingActionButton(
      heroTag: 'fab_${item.label}',
      onPressed: () => _handleMenuItemTap(item),
      backgroundColor:
          isMainButton
              ? (isMenuOpen
                  ? Colors.deepPurple.shade700
                  : Colors.deepPurple) // Darker when open
              : item.color,
      elevation:
          isMainButton
              ? (isMenuOpen ? 12 : 8) // Higher elevation for main button
              : 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: SizedBox(
        width: isMainButton ? 65 : 60, // Slightly larger main button
        height: isMainButton ? 65 : 60,
        child: Center(
          child:
              isMainButton
                  ? AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: _animationController,
                    size: 30, // Larger icon for main button
                    color: Colors.white,
                  )
                  : Icon(item.icon, size: 28, color: Colors.white),
        ),
      ),
    );
  }

  void _handleMenuItemTap(MenuItemData item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.label} clicked'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1500),
      ),
    );
    _toggleMenu();
  }
}
