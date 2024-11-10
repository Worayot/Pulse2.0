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
    return Container(
      height: 140,
      decoration: const BoxDecoration(
        color: Color(0xff3362CC),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.selectedIndex,
        onTap: widget.onTap,
        selectedItemColor: Colors.blue,
        unselectedItemColor: const Color(0xffC6D8FF),
        backgroundColor: Colors.transparent,
        items: [
          _buildNavItem(FontAwesomeIcons.house, 'Home', 0),
          _buildNavItem(FontAwesomeIcons.users, 'Patient', 1),
          _buildNavItem(FontAwesomeIcons.fileArrowDown, 'Export', 2),
          _buildNavItem(FontAwesomeIcons.gear, 'Setting', 3),
        ],
        selectedFontSize: 15,
        unselectedFontSize: 12,
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      IconData icon, String label, int index) {
    bool isSelected = widget.selectedIndex == index;

    return BottomNavigationBarItem(
      icon: Container(
        padding: EdgeInsets.fromLTRB(
            isSelected ? 20 : 0, 10, isSelected ? 20 : 0, 10),
        decoration: isSelected
            ? BoxDecoration(
                color: Color(0xff407BFF),
                borderRadius: BorderRadius.circular(25),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              icon,
              size: 25,
              color: isSelected ? Colors.white : const Color(0xffC6D8FF),
            ),
            const SizedBox(height: 4),
            if (isSelected)
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
          ],
        ),
      ),
      label: '',
    );
  }
}
