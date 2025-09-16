import 'package:flutter/material.dart';
import '../models/school_class.dart';
import '../data/global_data.dart'; // contains the addedClasses list

class DeleteClassPage extends StatefulWidget {
  @override
  _DeleteClassPageState createState() => _DeleteClassPageState();
}

class _DeleteClassPageState extends State<DeleteClassPage> {
  @override
  Widget build(BuildContext context) {
    // Use the global addedClasses list and sort it
    List<SchoolClass> classSections = List.from(addedClasses)
      ..sort((a, b) {
        int classCompare = a.className.compareTo(b.className);
        if (classCompare != 0) return classCompare;
        return a.sectionName.compareTo(b.sectionName);
      });

    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Class'),
        backgroundColor: Colors.red[600],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delete Classes',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red[800],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Select a class to delete',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 30),

            Expanded(
              child: classSections.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.school_outlined,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 20),
                          Text(
                            'No classes available',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: classSections.length,
                      itemBuilder: (context, index) {
                        return _buildClassCard(classSections[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassCard(SchoolClass classSection) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(
            Icons.school,
            color: Colors.blue[600],
            size: 30,
          ),
        ),
        title: Text(
          'Class ${classSection.className} - Section ${classSection.sectionName}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          'Tap delete to remove this class',
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        trailing: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: () => _showDeleteDialog(classSection),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(SchoolClass classSection) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Class',
            style: TextStyle(color: Colors.red[800]),
          ),
          content: Text(
            'Are you sure you want to delete Class ${classSection.className} - Section ${classSection.sectionName}?\n\nThis action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteClass(classSection);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteClass(SchoolClass classSection) {
    setState(() {
      addedClasses.removeWhere((c) =>
          c.className == classSection.className &&
          c.sectionName == classSection.sectionName);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Class ${classSection.className} - Section ${classSection.sectionName} deleted successfully!'),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'UNDO',
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              addedClasses.add(classSection);
            });
          },
        ),
      ),
    );
  }
}
