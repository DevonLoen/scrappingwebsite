import 'package:flutter/material.dart';

class FilterPopup extends StatefulWidget {
  final List<String>? selectedFilters; // Tambahkan parameter selectedFilters

  const FilterPopup({Key? key, this.selectedFilters}) : super(key: key);

  @override
  _FilterPopupState createState() => _FilterPopupState();
}

class _FilterPopupState extends State<FilterPopup> {
  bool _option1 = false;
  bool _option2 = false;
  bool _option3 = false;
  bool _option4 = false;
  bool _option5 = false;

  @override
  void initState() {
    super.initState();
    // Periksa apakah 'REGULAR' ada di dalam selectedFilters
    if (widget.selectedFilters != null &&
        widget.selectedFilters!.contains('selesai')) {
      _option2 = true;
    }

    if (widget.selectedFilters != null &&
        widget.selectedFilters!.contains('pengiriman')) {
      _option1 = true;
    }

    if (widget.selectedFilters != null &&
        widget.selectedFilters!.contains('tiba')) {
      _option3 = true;
    }

    if (widget.selectedFilters != null &&
        widget.selectedFilters!.contains('beli')) {
      _option4 = true;
    }

    if (widget.selectedFilters != null &&
        widget.selectedFilters!.contains('batal')) {
      _option5 = true;
    }
  }

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Filter History'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            CheckboxListTile(
              title: Text('selesai'),
              value: _option1,
              onChanged: (value) {
                setState(() {
                  _option1 = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('pengiriman'),
              value: _option2,
              onChanged: (value) {
                setState(() {
                  _option2 = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('tiba'),
              value: _option3,
              onChanged: (value) {
                setState(() {
                  _option3 = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('beli'),
              value: _option4,
              onChanged: (value) {
                setState(() {
                  _option4 = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('batal'),
              value: _option5,
              onChanged: (value) {
                setState(() {
                  _option5 = value ?? false;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the filter popup
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Collect selected filters
            List<String> selectedFilters = [];
            if (_option1) {
              selectedFilters.add('selesai');
            }
            if (_option2) {
              selectedFilters.add('pengiriman');
            }

            if (_option3) {
              selectedFilters.add('tiba');
            }

            if (_option4) {
              selectedFilters.add('beli');
            }

            if (_option5) {
              selectedFilters.add('batal');
            }

            // Return selected filters
            Navigator.of(context).pop(selectedFilters);
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text('Apply'),
        ),
      ],
    );
  }
}
