import 'package:flutter/material.dart';

import '../models/school_class.dart';
import '../data/global_data.dart';

class AddClassPage extends StatefulWidget {
  @override
  _AddClassPageState createState() => _AddClassPageState();
}

class _AddClassPageState extends State<AddClassPage> {
  String? selectedClass;
  String? selectedSection;

  final List<String> classes = [
    '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'
  ];

  final List<String> sections = ['A', 'B', 'C'];

  void addClass() {
    if (selectedClass != null && selectedSection != null) {
      // Check if class already exists
      bool exists = addedClasses.any((c) =>
          c.className == selectedClass && c.sectionName == selectedSection);

      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Class $selectedClass-$selectedSection already exists!',
            ),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        // Save new class
        addedClasses.add(
          SchoolClass(
            className: selectedClass!,
            sectionName: selectedSection!,
          ),
        );

        // Sort by class then section
        addedClasses.sort((a, b) {
          int classComp = a.className.compareTo(b.className);
          if (classComp != 0) return classComp;
          return a.sectionName.compareTo(b.sectionName);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Class $selectedClass-$selectedSection added successfully!',
            ),
            backgroundColor: Colors.green,
          ),
        );

        // Reset dropdowns
        setState(() {
          selectedClass = null;
          selectedSection = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Class'),
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create New Class',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            SizedBox(height: 40),

            // Class Dropdown
            Text(
              'Select Class:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedClass,
                  hint: Text('Choose Class'),
                  isExpanded: true,
                  items: classes.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text('Class $value'),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedClass = newValue;
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: 30),

            // Section Dropdown
            Text(
              'Select Section:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedSection,
                  hint: Text('Choose Section'),
                  isExpanded: true,
                  items: sections.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text('Section $value'),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSection = newValue;
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: 50),

            // Add Button
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed:
                    (selectedClass != null && selectedSection != null)
                        ? addClass
                        : null,
                child: Text(
                  'Add Class',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
