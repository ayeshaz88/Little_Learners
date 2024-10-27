import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  // Dummy data for the module usage report
  final List<ModuleUsageData> moduleUsageData = [
    ModuleUsageData('Module 1', 15),
    ModuleUsageData('Module 2', 20),
    ModuleUsageData('Module 3', 30),
    ModuleUsageData('Module 4', 10),
    ModuleUsageData('Module 5', 25),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Child Report'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Child\'s Recent Activities and Progress',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Summary of completed tasks, quizzes, and lessons:',
              style: TextStyle(fontSize: 16),
            ),
            // Display other summary information here

            SizedBox(height: 20),
            Text(
              'Module Usage:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            _buildModuleUsageTable(), // Build the module usage table
          ],
        ),
      ),
    );
  }

  // Build the module usage table
  Widget _buildModuleUsageTable() {
    return DataTable(
      columns: [
        DataColumn(label: Text('Module')),
        DataColumn(label: Text('Usage Percentage')),
      ],
      rows: moduleUsageData.map((data) {
        return DataRow(cells: [
          DataCell(Text(data.moduleName)),
          DataCell(Text('${data.usagePercentage}%')),
        ]);
      }).toList(),
    );
  }
}

class ModuleUsageData {
  final String moduleName;
  final double usagePercentage;

  ModuleUsageData(this.moduleName, this.usagePercentage);
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Child Report Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReportPage(),
    );
  }
}
