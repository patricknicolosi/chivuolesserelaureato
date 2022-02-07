import 'package:flutter/material.dart';

class Helper extends StatefulWidget {
  final Icon icon;
  final String tooltipContent;
  final Function onTap;
  const Helper(this.icon, this.tooltipContent, this.onTap, {Key? key})
      : super(key: key);

  @override
  _HelperState createState() => _HelperState();
}

class _HelperState extends State<Helper> {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltipContent,
      child: InkWell(
        onTap: () {
          widget.onTap();
          _isUsed = !_isUsed;
          setState(() {});
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.white, width: 3),
            color:
                _isUsed ? Colors.amber : const Color.fromRGBO(34, 62, 149, 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: widget.icon,
          ),
        ),
      ),
    );
  }

  bool _isUsed = false;
}
