import 'package:flutter/material.dart';

class ExpandableWidget extends StatefulWidget {
  final String title;
  final Widget widget;

  const ExpandableWidget(
      {super.key, required this.title, required this.widget});

  @override
  _ExpandableWidgetState createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      _isExpanded ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 20, right: 20),
          child: Stack(
            children: [
              // Blue container that expands and collapses from the bottom
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),

                height: _isExpanded
                    ? 100
                    : 70, // Controls the height of the container
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color:
                      const Color(0xffE0EAFF), // Blue color for the container
                  borderRadius:
                      BorderRadius.circular(15), // Set the border radius
                ),
                child: widget.widget, // The widget content when expanded
              ),
              // The button that toggles the expansion
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: const Color(0xffCADBFF),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: _toggleExpand,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const Spacer(),
                      Icon(_isExpanded ? Icons.expand_more : Icons.expand_less),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // The content that will be revealed when expanded
        SizeTransition(
          sizeFactor: _expandAnimation,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: widget.widget, // The widget that will expand
          ),
        ),
      ],
    );
  }
}
