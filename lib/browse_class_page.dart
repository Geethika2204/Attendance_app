import 'package:flutter/material.dart';
import 'class_management_page.dart';

// import '../models/school_class.dart';
import '../data/global_data.dart';

class BrowseClassPage extends StatefulWidget {
  @override
  _BrowseClassPageState createState() => _BrowseClassPageState();
}

class _BrowseClassPageState extends State<BrowseClassPage> {
  String? selectedClass;
  String? selectedSection;

  @override
  Widget build(BuildContext context) {
    // Get classes and sort them
    final classes = addedClasses.map((c) => c.className).toSet().toList()
      ..sort();

    // Get sections for the selected class and sort them
    final sections = selectedClass != null
        ? (addedClasses
              .where((c) => c.className == selectedClass)
              .map((c) => c.sectionName)
              .toSet()
              .toList()
          ..sort())
        : [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Browse Class'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Class to Browse',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
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
                      selectedSection = null;
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
                  items: sections.map((value) {
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

            // Continue Button
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: (selectedClass != null && selectedSection != null)
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClassManagementPage(
                              className: selectedClass!,
                              sectionName: selectedSection!,
                            ),
                          ),
                        );
                      }
                    : null,
                child: Text(
                  'Continue',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
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
