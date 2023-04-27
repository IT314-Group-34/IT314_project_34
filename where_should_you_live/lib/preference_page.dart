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
                content:
                    Text('My apologies but you can only select 4 options.'),
                action: SnackBarAction(
                  label: 'OK',
                  onPressed: () {},
                )),
          );
        }
      }
    });
  }

  Widget _buildOptionCheckbox(String option) {
    final bool isChecked = _selectedOptions.contains(option);

    return CheckboxListTile(
      title: Text(
        option,
        style: TextStyle(fontSize: 16),
      ),
      value: isChecked,
      onChanged: (bool? value) {
        if (value != null) {
          _toggleOption(option);
        }
      },
      activeColor: Colors.deepPurple,
      checkColor: Colors.white,
      controlAffinity: ListTileControlAffinity.leading,
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
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
        ),
      );
    } else {
      setState(() {
        _selectedOptions.clear();
      });
    }
  }

  void _resetOptions() {
    setState(() {
      _selectedOptions.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preference Page'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Select your top 4 preferences:',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              child: ListView(
                children: _options.map((String option) {
                  return _buildOptionCheckbox(option);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            label: Text('Save Preferences'),
            onPressed: () {
              if (_selectedOptions.length == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please select at least one option.'),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {},
                    ),
                  ),
                );
              } else {
                _showConfirmationDialog();
              }
            },
            icon: Icon(Icons.save),
            backgroundColor: Colors.deepPurple,
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _selectedOptions.clear();
              });
            },
            child: Icon(Icons.refresh),
            backgroundColor: Colors.deepPurple,
          ),
        ],
      ),
    );
  }
}
