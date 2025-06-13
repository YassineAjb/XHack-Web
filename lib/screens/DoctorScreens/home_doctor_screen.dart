import 'package:flutter/material.dart';
import 'package:webxhack/screens/DoctorScreens/dashboard_screen.dart';

class OrganMatchingPage extends StatefulWidget {
  const OrganMatchingPage({super.key});

  @override
  State<OrganMatchingPage> createState() => _OrganMatchingPageState();
}

class _OrganMatchingPageState extends State<OrganMatchingPage> {
  // Color scheme from previous implementation
  static const Color primaryBlue = Color(0xFF1E3A8A);
  static const Color lightBlue = Color(0xFF3B82F6);
  static const Color accentGreen = Color(0xFF10B981);
  static const Color warningOrange = Color(0xFFF59E0B);
  static const Color lightGray = Color(0xFFF8FAFC);
  static const Color mediumGray = Color(0xFF64748B);
  static const Color darkGray = Color(0xFF1E293B);

  // Sample organ data (kidneys available for donation)
  final List<Map<String, dynamic>> availableOrgans = [
    {'id': 'KID-123', 'type': 'Kidney', 'bloodType': 'A+', 'location': 'New York'},
    {'id': 'KID-456', 'type': 'Kidney', 'bloodType': 'O-', 'location': 'Chicago'},
    {'id': 'KID-789', 'type': 'Kidney', 'bloodType': 'B+', 'location': 'Los Angeles'},
    {'id': 'KID-101', 'type': 'Kidney', 'bloodType': 'AB+', 'location': 'Miami'},
    {'id': 'KID-112', 'type': 'Kidney', 'bloodType': 'A-', 'location': 'Seattle'},
    {'id': 'KID-456', 'type': 'Kidney', 'bloodType': 'O-', 'location': 'Chicago'},
    {'id': 'KID-789', 'type': 'Kidney', 'bloodType': 'B+', 'location': 'Los Angeles'},
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
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: primaryBlue,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.medical_services, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Matching Patients for ${availableOrgans[organIndex]['id']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: SingleChildScrollView(
                    child: DataTable(
                      showCheckboxColumn: false,
                      columns: const [
                        DataColumn(label: Text('Name', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Age', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Blood', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Priority', style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                      rows: matchedPatients[organIndex].map((patient) {
                        return DataRow(
                          onSelectChanged: (_) {
                            _showPatientDetailsDialog(context, patient, availableOrgans[organIndex]);
                          },
                          cells: [
                            DataCell(
                              Text(patient['name']),
                              onTap: () {
                                _showPatientDetailsDialog(context, patient, availableOrgans[organIndex]);
                              },
                            ),
                            DataCell(Text(patient['age'].toString())),
                            DataCell(Text(patient['bloodType'])),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getPriorityColor(patient['priority']).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: _getPriorityColor(patient['priority']).withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  patient['priority'],
                                  style: TextStyle(
                                    color: _getPriorityColor(patient['priority']),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: mediumGray,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

void _showPatientDetailsDialog(BuildContext context, Map<String, dynamic> patient, Map<String, dynamic> organ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: primaryBlue,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.network(
                          'https://cdn-icons-png.flaticon.com/512/2922/2922506.png',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Patient: ${patient['name']}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow("Organ ID", organ['id']),
                        _buildDetailRow("Organ Type", organ['type']),
                        _buildDetailRow("Organ Blood Type", organ['bloodType']),
                        _buildDetailRow("Organ Location", organ['location']),
                        const Divider(),
                        _buildDetailRow("Patient Name", patient['name']),
                        _buildDetailRow("Age", patient['age'].toString()),
                        _buildDetailRow("Blood Type", patient['bloodType']),
                        _buildDetailRow("Waiting Time", patient['waitingTime']),
                        _buildDetailRow("Priority", patient['priority']),
                        _buildDetailRow("Location", patient['location']),
                        const SizedBox(height: 20),
                        const Text(
                          "Compatibility Analysis:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        _buildDetailRow("Blood Type Match", "Perfect Match"),
                        _buildDetailRow("Distance", "250 km"),
                        _buildDetailRow("Success Probability", "92%"),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: mediumGray,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Back'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentGreen,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          _showSurgeryConfirmationDialog(context, patient, organ);
                        },
                        child: const Text('Schedule Surgery'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


  void _showSurgeryConfirmationDialog(BuildContext context, Map<String, dynamic> patient, Map<String, dynamic> organ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: primaryBlue,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.medical_services, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "Confirm Surgery",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Confirm surgery for ${patient['name']}?"),
                      const SizedBox(height: 8),
                      Text(
                        "Organ: ${organ['id']} (${organ['bloodType']})", 
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "This action cannot be undone.", 
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: mediumGray,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentGreen,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          _scheduleSurgery(patient, organ);
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Surgery scheduled for ${patient['name']}'),
                              backgroundColor: accentGreen,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        },
                        child: const Text('Confirm'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _scheduleSurgery(Map<String, dynamic> patient, Map<String, dynamic> organ) {
    // Implement your actual surgery scheduling logic here
    print('Surgery scheduled:');
    print('Patient: ${patient['name']}');
    print('Organ: ${organ['id']}');
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: mediumGray,
              ),
            ),
          ),
          const Text(": "),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: darkGray),
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'critical': return const Color(0xFFDC2626);
      case 'high': return warningOrange;
      case 'medium': return lightBlue;
      case 'low': return accentGreen;
      default: return mediumGray;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGray,
      body: Column(
        children: [
          _buildEnhancedHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatisticsSection(),
                  const SizedBox(height: 24),
                  const Text(
                    'Available Kidneys for Matching',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkGray,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: availableOrgans.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _showMatchingPatientsDialog(context, index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image Container
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child: Container(
                                  height: 100,
                                  width: double.infinity,
                                  color: lightBlue.withOpacity(0.1),
                                  child: Image.network(
                                    'https://med.stanford.edu/news/all-news/2014/06/adult-kidneys-constantly-grow/_jcr_content/_cq_featuredimage.coreimg.jpg/1745379238460/lksc.jpg',
                                    width: double.infinity,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  )
                                ),
                              ),
                              // Organ Info
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      availableOrgans[index]['id'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: darkGray,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Blood: ${availableOrgans[index]['bloodType']}',
                                      style: TextStyle(
                                        color: mediumGray,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          'Show matches',
                                          style: TextStyle(
                                            color: lightBlue,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          size: 14,
                                          color: lightBlue,
                                        ),
                                      ],
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryBlue, lightBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.medical_services_rounded, color: primaryBlue, size: 26),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Organ Matching System',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Doctor Portal',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => OrganMatchingPage()));
                },
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 153, 245, 176),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                child: const Text(
                  'Matching System',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardDoctor()));
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                child: const Text(
                  'Organs/Patiens',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  final spacerWidth = constraints.maxWidth * 0.2; // 20% of available width
                  return SizedBox(width: spacerWidth.clamp(8, 200)); // Min 100, max 200
                },
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: IconButton(
                  icon: const Icon(Icons.logout_rounded, color: Colors.white, size: 22),
                  onPressed: () {
                    // Add logout functionality
                  },
                  tooltip: 'Logout',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticsSection() {
    return Row(
      children: [
        _buildStatCard(
          icon: Icons.medical_services_rounded,
          title: 'Available Kidneys',
          value: availableOrgans.length.toString(),
          subtitle: 'Ready for matching',
          color: accentGreen,
          gradient: [accentGreen.withOpacity(0.1), accentGreen.withOpacity(0.05)],
        ),
        const SizedBox(width: 16),
        _buildStatCard(
          icon: Icons.health_and_safety,
          title: 'Potential Operations',
          value: '${availableOrgans.length * 5}',
          subtitle: 'Possible matches',
          color: lightBlue,
          gradient: [lightBlue.withOpacity(0.1), lightBlue.withOpacity(0.05)],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color color,
    required List<Color> gradient,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 20,
                  ),
                ),
                const Spacer(),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: darkGray,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: mediumGray,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
