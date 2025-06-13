import 'package:flutter/material.dart';

class OrganMatchingPage extends StatefulWidget {
  const OrganMatchingPage({super.key});

  @override
  State<OrganMatchingPage> createState() => _OrganMatchingPageState();
}

class _OrganMatchingPageState extends State<OrganMatchingPage> {
  // Sample organ data (kidneys available for donation)
  final List<Map<String, dynamic>> availableOrgans = [
    {'id': 'KID-123', 'type': 'Kidney', 'bloodType': 'A+', 'location': 'New York'},
    {'id': 'KID-456', 'type': 'Kidney', 'bloodType': 'O-', 'location': 'Chicago'},
    {'id': 'KID-789', 'type': 'Kidney', 'bloodType': 'B+', 'location': 'Los Angeles'},
    {'id': 'KID-101', 'type': 'Kidney', 'bloodType': 'AB+', 'location': 'Miami'},
    {'id': 'KID-112', 'type': 'Kidney', 'bloodType': 'A-', 'location': 'Seattle'},
  ];

  // Sample patient data that matches each organ
  final List<List<Map<String, dynamic>>> matchedPatients = [
    // Patients for KID-123 (A+)
    [
      {'name': 'John Smith', 'age': 42, 'bloodType': 'A+', 'waitingTime': '1y 3m', 'priority': 'High', 'location': 'Boston'},
      {'name': 'Emma Wilson', 'age': 35, 'bloodType': 'A+', 'waitingTime': '2y 1m', 'priority': 'Critical', 'location': 'Philadelphia'},
      {'name': 'Robert Johnson', 'age': 58, 'bloodType': 'A+', 'waitingTime': '8m', 'priority': 'Medium', 'location': 'New York'},
      {'name': 'Sarah Davis', 'age': 29, 'bloodType': 'A+', 'waitingTime': '1y 6m', 'priority': 'High', 'location': 'Hartford'},
      {'name': 'Michael Brown', 'age': 63, 'bloodType': 'A+', 'waitingTime': '3y 2m', 'priority': 'Critical', 'location': 'Albany'},
    ],
    // Patients for KID-456 (O-)
    [
      {'name': 'David Miller', 'age': 47, 'bloodType': 'O-', 'waitingTime': '1y 0m', 'priority': 'High', 'location': 'Chicago'},
      {'name': 'Jessica Lee', 'age': 31, 'bloodType': 'O-', 'waitingTime': '1y 8m', 'priority': 'Critical', 'location': 'Detroit'},
      {'name': 'Daniel Wilson', 'age': 52, 'bloodType': 'O-', 'waitingTime': '2y 3m', 'priority': 'High', 'location': 'Minneapolis'},
      {'name': 'Olivia Martin', 'age': 25, 'bloodType': 'O-', 'waitingTime': '6m', 'priority': 'Medium', 'location': 'Indianapolis'},
      {'name': 'James Anderson', 'age': 60, 'bloodType': 'O-', 'waitingTime': '3y 5m', 'priority': 'Critical', 'location': 'Milwaukee'},
    ],
    // Patients for KID-789 (B+)
    [
      {'name': 'William Taylor', 'age': 44, 'bloodType': 'B+', 'waitingTime': '1y 1m', 'priority': 'High', 'location': 'Los Angeles'},
      {'name': 'Sophia White', 'age': 38, 'bloodType': 'B+', 'waitingTime': '1y 9m', 'priority': 'Critical', 'location': 'San Diego'},
      {'name': 'Benjamin Clark', 'age': 55, 'bloodType': 'B+', 'waitingTime': '2y 0m', 'priority': 'High', 'location': 'Phoenix'},
      {'name': 'Ava Rodriguez', 'age': 27, 'bloodType': 'B+', 'waitingTime': '7m', 'priority': 'Medium', 'location': 'Las Vegas'},
      {'name': 'Mason Martinez', 'age': 62, 'bloodType': 'B+', 'waitingTime': '3y 1m', 'priority': 'Critical', 'location': 'Denver'},
    ],
    // Patients for KID-101 (AB+)
    [
      {'name': 'Ethan Hernandez', 'age': 41, 'bloodType': 'AB+', 'waitingTime': '1y 2m', 'priority': 'High', 'location': 'Miami'},
      {'name': 'Isabella Gonzalez', 'age': 33, 'bloodType': 'AB+', 'waitingTime': '1y 7m', 'priority': 'Critical', 'location': 'Orlando'},
      {'name': 'Alexander Lopez', 'age': 56, 'bloodType': 'AB+', 'waitingTime': '2y 2m', 'priority': 'High', 'location': 'Atlanta'},
      {'name': 'Mia Perez', 'age': 24, 'bloodType': 'AB+', 'waitingTime': '5m', 'priority': 'Medium', 'location': 'Charlotte'},
      {'name': 'Charlotte Sanchez', 'age': 61, 'bloodType': 'AB+', 'waitingTime': '3y 3m', 'priority': 'Critical', 'location': 'Tampa'},
    ],
    // Patients for KID-112 (A-)
    [
      {'name': 'Liam Ramirez', 'age': 45, 'bloodType': 'A-', 'waitingTime': '1y 4m', 'priority': 'High', 'location': 'Seattle'},
      {'name': 'Amelia Flores', 'age': 32, 'bloodType': 'A-', 'waitingTime': '1y 5m', 'priority': 'Critical', 'location': 'Portland'},
      {'name': 'Noah Washington', 'age': 54, 'bloodType': 'A-', 'waitingTime': '2y 4m', 'priority': 'High', 'location': 'Vancouver'},
      {'name': 'Evelyn Adams', 'age': 26, 'bloodType': 'A-', 'waitingTime': '4m', 'priority': 'Medium', 'location': 'Boise'},
      {'name': 'Lucas Campbell', 'age': 64, 'bloodType': 'A-', 'waitingTime': '3y 4m', 'priority': 'Critical', 'location': 'Spokane'},
    ],
  ];

  void _showMatchingPatientsDialog(BuildContext context, int organIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Matching Patients for ${availableOrgans[organIndex]['id']}'),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Age')),
                  DataColumn(label: Text('Blood')),
                  DataColumn(label: Text('Waiting')),
                  DataColumn(label: Text('Priority')),
                  DataColumn(label: Text('Location')),
                ],
                rows: matchedPatients[organIndex].map((patient) {
                  return DataRow(cells: [
                    DataCell(Text(patient['name'])),
                    DataCell(Text(patient['age'].toString())),
                    DataCell(Text(patient['bloodType'])),
                    DataCell(Text(patient['waitingTime'])),
                    DataCell(
                      Text(patient['priority']),
                      onTap: () {
                        // You could add specific actions when priority is tapped
                      },
                    ),
                    DataCell(Text(patient['location'])),
                  ]);
                }).toList(),
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Select Patient', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                // Add your patient selection logic here
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Row(
    children: [
      // Doctor Avatar
      CircleAvatar(
        radius: 18, // Small size
        backgroundImage: NetworkImage(
          'https://www.shutterstock.com/image-vector/male-doctor-smiling-happy-face-600nw-2481032615.jpg', // Doctor icon URL
        ),
      ),
      SizedBox(width: 12), // Spacing between avatar and text
      // Greeting text
      
          Row(
            children: [
              Text(
                'Hey Doctor,',
                style: TextStyle(
                  fontSize: 14,
                  color: const Color.fromARGB(179, 37, 30, 132),
                ),
              ),
              SizedBox(width: 500,),
              Text(
                'Organ Matching System',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ), 
    ],
  ),
  centerTitle: false, // Changed from true to align left
  elevation: 4,
  automaticallyImplyLeading: false,
  actions: [
    IconButton(
      icon: const Icon(Icons.logout_rounded),
      onPressed: () {
        // Add logout functionality
      },
    ),
  ],
),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
// Statistics Row
  Row(
    children: [
      // Available Kidneys Count
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.medical_services, color: Colors.blue),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Available Kidneys',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  '${availableOrgans.length}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(width: 30,),
      // Potential Operations Count
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.health_and_safety, color: Colors.green),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Potential Operations',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  '${availableOrgans.length * 5}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  ),
  const SizedBox(height: 16),
            const Text(
              'Available Kidneys for Matching',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.2,
                ),
                itemCount: availableOrgans.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _showMatchingPatientsDialog(context, index),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Image Container
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12)),
                            child: SizedBox(
                              width: double.infinity,
                              height: 100,
                              child: Image.network(
                                'https://med.stanford.edu/news/all-news/2014/06/adult-kidneys-constantly-grow/_jcr_content/_cq_featuredimage.coreimg.jpg/1745379238460/lksc.jpg',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[200],
                                    child: const Icon(Icons.medical_services,
                                        size: 50, color: Colors.red),
                                  );
                                },
                              ),
                            ),
                          ),
                          // Organ Info
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  availableOrgans[index]['id'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Blood: ${availableOrgans[index]['bloodType']}',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Show Patient Matches',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}