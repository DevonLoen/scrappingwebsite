import 'package:flutter/material.dart';

class SortPopup extends StatefulWidget {
  final String? selectedSort; // Tambahkan parameter selectedFilters

  const SortPopup({Key? key, this.selectedSort}) : super(key: key);
  @override
  _SortPopupState createState() => _SortPopupState();
}

class _SortPopupState extends State<SortPopup> {
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    // Periksa apakah 'termurah' atau 'termahal' ada di dalam selectedFilters
    if (widget.selectedSort != null) {
      if (widget.selectedSort == 'termurah') {
        _selectedOption = 'termurah';
      } else if (widget.selectedSort == 'termahal') {
        _selectedOption = 'termahal';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sort History'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            RadioListTile<String>(
              title: Text('Termahal'),
              value: 'termahal',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('Termurah'),
              value: 'termurah',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value;
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
            print(_selectedOption);
            // Return selected filters
            Navigator.of(context).pop(_selectedOption);
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
