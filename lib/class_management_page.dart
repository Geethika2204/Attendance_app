
import 'package:flutter/material.dart';
import 'add_student_page.dart';

class ClassManagementPage extends StatelessWidget {
  final String className;
  final String sectionName;

  ClassManagementPage({
    required this.className,
    required this.sectionName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Class $className - Section $sectionName'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Class Management',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Class $className - Section $sectionName',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 40),
            
            // Upload Attendance Button
            _buildManagementButton(
              context,
              'Upload Attendance',
              Icons.upload_file,
              Colors.blue,
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Upload Attendance feature will be implemented'),
                    backgroundColor: Colors.blue,
                  ),
                );
              },
            ),
            
            SizedBox(height: 20),
            
            // Edit Attendance Button
            _buildManagementButton(
              context,
              'Edit Attendance',
              Icons.edit,
              Colors.blue,
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Edit Attendance feature will be implemented'),
                    backgroundColor: Colors.blue,
                  ),
                );
              },
            ),
            
            SizedBox(height: 20),
            
            // Add Student Button
            _buildManagementButton(
              context,
              'Add Student',
              Icons.person_add,
              Colors.blue,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddStudentPage(
                      className: className,
                      sectionName: sectionName,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManagementButton(BuildContext context, String title, 
      IconData icon, Color color, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 24),
        label: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}