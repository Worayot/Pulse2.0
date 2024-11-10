import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const MainNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  _MainNavigationBarState createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenWidth * 0.04;
    double fontSize = screenWidth * 0.03;
    double containerMaxWidth = screenWidth * 0.25;
    double containerMinWidth = screenWidth * 0.12;
    EdgeInsets containerPadding = EdgeInsets.symmetric(
      vertical: screenWidth * 0.015,
      horizontal: screenWidth * 0.025,
    );

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.selectedIndex,
      onTap: widget.onTap,
      selectedItemColor: Colors.white,
      unselectedItemColor: const Color(0xffC6D8FF),
      backgroundColor: const Color(0xff3362CC),
      items: [
        _buildNavItem(FontAwesomeIcons.house, 'home'.tr(), 0, iconSize,
            fontSize, containerPadding, containerMaxWidth, containerMinWidth),
        _buildNavItem(FontAwesomeIcons.users, 'Patients', 1, iconSize, fontSize,
            containerPadding, containerMaxWidth, containerMinWidth),
        _buildNavItem(FontAwesomeIcons.fileArrowDown, 'Export', 2, iconSize,
            fontSize, containerPadding, containerMaxWidth, containerMinWidth),
        _buildNavItem(FontAwesomeIcons.gear, 'Settings', 3, iconSize, fontSize,
            containerPadding, containerMaxWidth, containerMinWidth),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(
      IconData icon,
      String label,
      int index,
      double iconSize,
      double fontSize,
      EdgeInsets containerPadding,
      double maxContainerWidth,
      double minContainerWidth) {
    return BottomNavigationBarItem(
      icon: _buildIconContainer(icon, label, index, iconSize, fontSize,
          containerPadding, maxContainerWidth, minContainerWidth),
      label: '',
      backgroundColor: const Color(0xFF3362CC),
    );
  }

  Widget _buildIconContainer(
      IconData icon,
      String label,
      int index,
      double iconSize,
      double fontSize,
      EdgeInsets containerPadding,
      double maxContainerWidth,
      double minContainerWidth) {
    bool isSelected = widget.selectedIndex == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300), // Duration for the animation
      padding: isSelected
          ? containerPadding
          : EdgeInsets.all(iconSize * 0.4), // Adjust padding for unselected
      constraints: BoxConstraints(
        maxWidth: isSelected
            ? maxContainerWidth
            : minContainerWidth, // Dynamic width based on selection
      ),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            icon,
            size: iconSize,
            color: isSelected ? Colors.white : const Color(0xffC6D8FF),
          ),
          if (isSelected)
            SizedBox(
                width: iconSize * 0.2), // Adjust spacing based on icon size

          if (isSelected)
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}
