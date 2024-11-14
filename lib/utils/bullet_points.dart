import 'package:flutter/material.dart';

class ExpandableWidget extends StatefulWidget {
  final String title;
  final Widget widget;
  final double box_height;
  final String image;

  const ExpandableWidget(
      {super.key,
      required this.title,
      required this.widget,
      required this.box_height,
      required this.image});

  @override
  // ignore: library_private_types_in_public_api
  _ExpandableWidgetState createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Fade animation for content
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
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
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Stack(
            children: [
              // Animated container with resizing and fading content
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Container(
                    constraints: _isExpanded
                        ? BoxConstraints(minHeight: widget.box_height)
                        : const BoxConstraints(minHeight: 70),
                    decoration: BoxDecoration(
                      color: const Color(0xffE0EAFF), // Blue container color
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: _isExpanded ? widget.widget : Container(),
                    ),
                  ),
                ),
              ),

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
                      Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                    ],
                  ),
                ),
              ),
              Positioned(
                  right: 0,
                  child: IgnorePointer(child: Image.asset(widget.image))),
              Positioned(
                  top: 17,
                  right: 20,
                  child: IgnorePointer(
                    child: Icon(
                        _isExpanded ? Icons.expand_less : Icons.expand_more),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
