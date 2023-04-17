import 'package:flutter/material.dart';

class PreferencePage extends StatefulWidget {
  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  final List<String> _options = [
    'Hospital',
    'School',
    'City Area',
    'Super Market',
    'Cinema',
    'Option 6',
    'Option 7',
    'Option 8'
  ];
  final List<String> _selectedOptions = [];

  void _toggleOption(String option) {
    setState(() {
      if (_selectedOptions.contains(option)) {
        _selectedOptions.remove(option);
      } else {
        if (_selectedOptions.length < 4) {
          _selectedOptions.add(option);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please select up to 4 options.'),
              action: SnackBarAction(
                label: 'OK',
                onPressed: () {},
              ),
            ),
          );
        }
      }
    });
  }

  Widget _buildOptionCheckbox(String option) {
    final bool isChecked = _selectedOptions.contains(option);

    return CheckboxListTile(
      title: Text(option),
      value: isChecked,
      onChanged: (bool? value) {
        if (value != null) {
          _toggleOption(option);
        }
      },
    );
  }

  Future<void> _showConfirmationDialog() async {
    bool? result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Preferences'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to save your preferences?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                // Perform save operation
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Preferences saved.'),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    } else {
      setState(() {
        _selectedOptions.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preference Page'),
      ),
      body: ListView(
        children: _options.map((String option) {
          return _buildOptionCheckbox(option);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showConfirmationDialog();
        },
        label: Text('Save Preferences'),
        icon: Icon(Icons.save),
      ),
    );
  }
}
