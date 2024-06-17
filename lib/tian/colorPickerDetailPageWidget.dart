import 'package:flutter/material.dart';

class DetailPickerWidget extends StatefulWidget {
  final List list;
  final bool colorPick;
  DetailPickerWidget({required this.list, required this.colorPick});
  @override
  _DetailPickerWidgetState createState() => _DetailPickerWidgetState();
}

class _DetailPickerWidgetState extends State<DetailPickerWidget> {
  // Define a list of colors
  // Keep track of the selected color index
  int? selectedColorIndex;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: 25),
      child: ListView.builder(
        itemCount: widget.list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          bool isSelected = index == selectedColorIndex;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedColorIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: 25,
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        // spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 5),
                        color: const Color.fromARGB(255, 144, 141, 141)
                            .withOpacity(0.5))
                  ],
                  color: widget.colorPick
                      ? widget.list[index]
                      : const Color(0xFFD6D6D6),
                  borderRadius: BorderRadius.all(
                      Radius.circular(100)), // Set shape to circle
                  border: isSelected
                      ? Border.all(color: Colors.black, width: 1.5)
                      : null,
                ),
                alignment: Alignment.center,
                child:
                    widget.colorPick ? Container() : Text(widget.list[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
