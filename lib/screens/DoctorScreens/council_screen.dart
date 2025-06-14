import 'package:flutter/material.dart';
import 'package:webxhack/screens/DoctorScreens/dashboard_screen.dart';

class MedicalCouncilScreen extends StatefulWidget {
  const MedicalCouncilScreen({super.key});

  @override
  State<MedicalCouncilScreen> createState() => _MedicalCouncilScreenState();
}

class _MedicalCouncilScreenState extends State<MedicalCouncilScreen> {
  // Sample council data with added 'isCurrentDoctor' field
  final List<Map<String, dynamic>> _councilEvents = [
    {
      'id': 'COUNCIL-001',
      'title': 'Heart Transplant Review',
      'date': '2023-06-15',
      'patient': 'John Smith',
      'description': 'Review of heart transplant compatibility for patient with rare blood type.',
      'decision': 'Approved for transplant with close monitoring',
      'status': 'Pending Confirmation',
      'isCurrentDoctor': true, // This one belongs to current doctor
    },
    {
      'id': 'COUNCIL-002',
      'title': 'Liver Allocation Meeting',
      'date': '2025-06-10',
      'patient': 'Sarah Johnson',
      'description': 'Discussion of liver allocation between two priority patients.',
      'decision': 'Allocate to patient with higher MELD score',
      'status': 'Pending Confirmation',
      'isCurrentDoctor': false,
    },
    {
      'id': 'COUNCIL-002',
      'title': 'Liver Allocation Meeting',
      'date': '2025-06-10',
      'patient': 'Sarah Johnson',
      'description': 'Discussion of liver allocation between two priority patients.',
      'decision': 'Allocate to patient with higher MELD score',
      'status': 'Confirmed',
      'isCurrentDoctor': false,
    },
    {
      'id': 'COUNCIL-003',
      'title': 'Ethics Committee',
      'date': '2023-06-05',
      'patient': 'Michael Brown',
      'description': 'Ethical considerations for experimental transplant procedure.',
      'decision': 'Approved with additional consent requirements',
      'status': 'Rejected',
      'isCurrentDoctor': false,
    },
  ];

    // Get sorted events (newest first)
  List<Map<String, dynamic>> get _sortedEvents {
    final sorted = List<Map<String, dynamic>>.from(_councilEvents);
    sorted.sort((a, b) {
      final dateA = DateTime.parse(a['date']);
      final dateB = DateTime.parse(b['date']);
      return dateB.compareTo(dateA); // Newest first
    });
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // lightGray from your theme
      body: Column(
        children: [
          _buildEnhancedHeader(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _sortedEvents.length,
              itemBuilder: (context, index) {
                final event = _sortedEvents[index];
                return _buildCouncilCard(event);
              },
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
          colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)], // primaryBlue, lightBlue
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
                  child: Icon(Icons.medical_services_rounded, color: Color(0xFF1E3A8A), // primaryBlue
                  size: 26),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Medical Council',
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
                  // Navigate to Matching System
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
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
                  'Organs/Patients',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: null, // Current screen
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 153, 245, 176), 
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                child: const Text(
                  'Medical Council',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  final spacerWidth = constraints.maxWidth * 0.2;
                  return SizedBox(width: spacerWidth.clamp(8, 200));
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
                  onPressed: _logout,
                  tooltip: 'Logout',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCouncilCard(Map<String, dynamic> event) {
    Color statusColor;
    switch (event['status']) {
      case 'Confirmed':
        statusColor = const Color(0xFF10B981); // accentGreen
        break;
      case 'Rejected':
        statusColor = const Color(0xFFEF4444); // red
        break;
      default:
        statusColor = const Color(0xFFF59E0B); // warningOrange
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showCouncilDetails(event),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6).withOpacity(0.1), // lightBlue
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.groups_rounded, color: Color(0xFF3B82F6)), // lightBlue
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              event['title'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B), // darkGray
                              ),
                            ),
                            if (event['isCurrentDoctor'])
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF3B82F6).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: const Color(0xFF3B82F6)),
                                  ),
                                  child: const Text(
                                    'Your Case',
                                    style: TextStyle(
                                      color: Color(0xFF3B82F6),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: statusColor.withOpacity(0.3)),
                    ),
                    child: Text(
                      event['status'],
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Patient: ${event['patient']}',
                style: const TextStyle(
                  color: Color(0xFF64748B), // mediumGray
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Date: ${event['date']}',
                style: const TextStyle(
                  color: Color(0xFF64748B), // mediumGray
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCouncilDetails(Map<String, dynamic> event) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6).withOpacity(0.1), // lightBlue
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.groups_rounded,
                      color: Color(0xFF3B82F6), // lightBlue
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              event['title'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B), // darkGray
                              ),
                            ),
                            if (event['isCurrentDoctor'])
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF3B82F6).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: const Color(0xFF3B82F6)),
                                  ),
                                  child: const Text(
                                    'Your Case',
                                    style: TextStyle(
                                      color: Color(0xFF3B82F6),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Text(
                          'Patient: ${event['patient']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: const Color(0xFF64748B).withOpacity(0.8), // mediumGray
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildDetailRow('Date', event['date'], Icons.calendar_today_rounded),
              _buildDetailRow('Description', event['description'], Icons.description_rounded),
              _buildDetailRow('Council Decision', event['decision'], Icons.gavel_rounded),
              const SizedBox(height: 24),
              if (event['status'] == 'Pending Confirmation' && !event['isCurrentDoctor'])
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _updateCouncilStatus(event['id'], 'Rejected');
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: const BorderSide(color: Color(0xFFEF4444)), // red
                        ),
                        child: const Text(
                          'Reject Decision',
                          style: TextStyle(
                            color: Color(0xFFEF4444), // red
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _updateCouncilStatus(event['id'], 'Confirmed');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF10B981), // accentGreen
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Confirm Decision',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              else if (event['status'] == 'Pending Confirmation' && event['isCurrentDoctor'])
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC), // lightGray
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)), // lighter gray
                  ),
                  child: const Center(
                    child: Text(
                      'You cannot vote on your own case',
                      style: TextStyle(
                        color: Color(0xFF64748B), // mediumGray
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              else
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E3A8A), // primaryBlue
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Close'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC), // lightGray
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)), // lighter gray
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF64748B)), // mediumGray
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B), // darkGray
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: const Color(0xFF64748B), // mediumGray
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _updateCouncilStatus(String id, String newStatus) {
    setState(() {
      final index = _councilEvents.indexWhere((e) => e['id'] == id);
      if (index != -1) {
        _councilEvents[index]['status'] = newStatus;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Decision $newStatus successfully'),
        backgroundColor: newStatus == 'Confirmed' 
            ? const Color(0xFF10B981) // accentGreen
            : const Color(0xFFEF4444), // red
      ),
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pop(); // Close the current screen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444), // red
              foregroundColor: Colors.white,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:webxhack/screens/DoctorScreens/dashboard_screen.dart';

// class MedicalCouncilScreen extends StatefulWidget {
//   const MedicalCouncilScreen({super.key});

//   @override
//   State<MedicalCouncilScreen> createState() => _MedicalCouncilScreenState();
// }

// class _MedicalCouncilScreenState extends State<MedicalCouncilScreen> {
//   // Sample council data
//   final List<Map<String, dynamic>> _councilEvents = [
//     {
//       'id': 'COUNCIL-001',
//       'title': 'Heart Transplant Review',
//       'date': '2023-06-15',
//       'patient': 'John Smith',
//       'description': 'Review of heart transplant compatibility for patient with rare blood type.',
//       'decision': 'Approved for transplant with close monitoring',
//       'status': 'Pending Confirmation'
//     },
//     {
//       'id': 'COUNCIL-002',
//       'title': 'Liver Allocation Meeting',
//       'date': '2025-06-10',
//       'patient': 'Sarah Johnson',
//       'description': 'Discussion of liver allocation between two priority patients.',
//       'decision': 'Allocate to patient with higher MELD score',
//       'status': 'Confirmed'
//     },
//     {
//       'id': 'COUNCIL-003',
//       'title': 'Ethics Committee',
//       'date': '2023-06-05',
//       'patient': 'Michael Brown',
//       'description': 'Ethical considerations for experimental transplant procedure.',
//       'decision': 'Approved with additional consent requirements',
//       'status': 'Rejected'
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8FAFC), // lightGray from your theme
//       body: Column(
//         children: [
//           _buildEnhancedHeader(),
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(20),
//               itemCount: _councilEvents.length,
//               itemBuilder: (context, index) {
//                 final event = _councilEvents[index];
//                 return _buildCouncilCard(event);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEnhancedHeader() {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)], // primaryBlue, lightBlue
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 8,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Row(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 4,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: const CircleAvatar(
//                   radius: 22,
//                   backgroundColor: Colors.white,
//                   child: Icon(Icons.medical_services_rounded, color: Color(0xFF1E3A8A), // primaryBlue
//                   size: 26),
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Medical Council',
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     Text(
//                       'Doctor Portal',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.white.withOpacity(0.8),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   // Navigate to Matching System
//                 },
//                 style: TextButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                 ),
//                 child: const Text(
//                   'Matching System',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardDoctor()));
//                 },
//                 style: TextButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                 ),
//                 child: const Text(
//                   'Organs/Patients',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: null, // Current screen
//                 style: TextButton.styleFrom(
//                   foregroundColor: const Color.fromARGB(255, 153, 245, 176), 
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                 ),
//                 child: const Text(
//                   'Medical Council',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               LayoutBuilder(
//                 builder: (context, constraints) {
//                   final spacerWidth = constraints.maxWidth * 0.2;
//                   return SizedBox(width: spacerWidth.clamp(8, 200));
//                 },
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.white.withOpacity(0.2)),
//                 ),
//                 child: IconButton(
//                   icon: const Icon(Icons.logout_rounded, color: Colors.white, size: 22),
//                   onPressed: _logout,
//                   tooltip: 'Logout',
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCouncilCard(Map<String, dynamic> event) {
//     Color statusColor;
//     switch (event['status']) {
//       case 'Confirmed':
//         statusColor = const Color(0xFF10B981); // accentGreen
//         break;
//       case 'Rejected':
//         statusColor = const Color(0xFFEF4444); // red
//         break;
//       default:
//         statusColor = const Color(0xFFF59E0B); // warningOrange
//     }

//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(12),
//         onTap: () => _showCouncilDetails(event),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF3B82F6).withOpacity(0.1), // lightBlue
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Icon(Icons.groups_rounded, color: Color(0xFF3B82F6)), // lightBlue
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Text(
//                       event['title'],
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF1E293B), // darkGray
//                       ),
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: statusColor.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(color: statusColor.withOpacity(0.3)),
//                     ),
//                     child: Text(
//                       event['status'],
//                       style: TextStyle(
//                         color: statusColor,
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 'Patient: ${event['patient']}',
//                 style: const TextStyle(
//                   color: Color(0xFF64748B), // mediumGray
//                   fontSize: 14,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 'Date: ${event['date']}',
//                 style: const TextStyle(
//                   color: Color(0xFF64748B), // mediumGray
//                   fontSize: 14,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showCouncilDetails(Map<String, dynamic> event) {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20)),
//         child: Container(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF3B82F6).withOpacity(0.1), // lightBlue
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Icon(
//                       Icons.groups_rounded,
//                       color: Color(0xFF3B82F6), // lightBlue
//                       size: 24,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           event['title'],
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF1E293B), // darkGray
//                           ),
//                         ),
//                         Text(
//                           'Patient: ${event['patient']}',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: const Color(0xFF64748B).withOpacity(0.8), // mediumGray
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//               _buildDetailRow('Date', event['date'], Icons.calendar_today_rounded),
//               _buildDetailRow('Description', event['description'], Icons.description_rounded),
//               _buildDetailRow('Council Decision', event['decision'], Icons.gavel_rounded),
//               const SizedBox(height: 24),
//               if (event['status'] == 'Pending Confirmation')
//                 Row(
//                   children: [
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                           _updateCouncilStatus(event['id'], 'Rejected');
//                         },
//                         style: OutlinedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                           side: const BorderSide(color: Color(0xFFEF4444)), // red
//                         ),
//                         child: const Text(
//                           'Reject Decision',
//                           style: TextStyle(
//                             color: Color(0xFFEF4444), // red
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                           _updateCouncilStatus(event['id'], 'Confirmed');
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF10B981), // accentGreen
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                         ),
//                         child: const Text(
//                           'Confirm Decision',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               else
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () => Navigator.pop(context),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF1E3A8A), // primaryBlue
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                     ),
//                     child: const Text('Close'),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailRow(String label, String value, IconData icon) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF8FAFC), // lightGray
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: const Color(0xFFE2E8F0)), // lighter gray
//       ),
//       child: Row(
//         children: [
//           Icon(icon, size: 18, color: const Color(0xFF64748B)), // mediumGray
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xFF1E293B), // darkGray
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   value,
//                   style: TextStyle(
//                     color: const Color(0xFF64748B), // mediumGray
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _updateCouncilStatus(String id, String newStatus) {
//     setState(() {
//       final index = _councilEvents.indexWhere((e) => e['id'] == id);
//       if (index != -1) {
//         _councilEvents[index]['status'] = newStatus;
//       }
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Decision $newStatus successfully'),
//         backgroundColor: newStatus == 'Confirmed' 
//             ? const Color(0xFF10B981) // accentGreen
//             : const Color(0xFFEF4444), // red
//       ),
//     );
//   }

//   void _logout() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: const Text('Logout'),
//         content: const Text('Are you sure you want to logout?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Navigator.of(context).pop(); // Close the current screen
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFFEF4444), // red
//               foregroundColor: Colors.white,
//             ),
//             child: const Text('Logout'),
//           ),
//         ],
//       ),
//     );
//   }
// }



//-------------------------------------------------------------------------------------------------------

// import 'package:flutter/material.dart';
// import 'package:webxhack/screens/DoctorScreens/dashboard_screen.dart';

// class MedicalCouncilScreen extends StatefulWidget {
//   const MedicalCouncilScreen({super.key});

//   @override
//   State<MedicalCouncilScreen> createState() => _MedicalCouncilScreenState();
// }

// class _MedicalCouncilScreenState extends State<MedicalCouncilScreen> {
//   bool _showMyDecisions = true; // Toggle state
  
//   // Sample council data
//   final List<Map<String, dynamic>> _allCouncilEvents = [
//     {
//       'id': 'COUNCIL-001',
//       'title': 'Heart Transplant Review',
//       'date': '2023-06-15',
//       'patient': 'John Smith',
//       'description': 'Review of heart transplant compatibility for patient with rare blood type.',
//       'decision': 'Approved for transplant with close monitoring',
//       'status': 'Pending Confirmation',
//       'myDecision': false
//     },
//     {
//       'id': 'COUNCIL-002',
//       'title': 'Liver Allocation Meeting',
//       'date': '2025-06-10',
//       'patient': 'Sarah Johnson',
//       'description': 'Discussion of liver allocation between two priority patients.',
//       'decision': 'Allocate to patient with higher MELD score',
//       'status': 'Confirmed',
//       'myDecision': true
//     },
//     {
//       'id': 'COUNCIL-003',
//       'title': 'Ethics Committee',
//       'date': '2023-06-05',
//       'patient': 'Michael Brown',
//       'description': 'Ethical considerations for experimental transplant procedure.',
//       'decision': 'Approved with additional consent requirements',
//       'status': 'Rejected',
//       'myDecision': true
//     },
//     {
//       'id': 'COUNCIL-004',
//       'title': 'Kidney Transplant Review',
//       'date': '2023-06-18',
//       'patient': 'Emily Davis',
//       'description': 'Review of kidney transplant compatibility.',
//       'decision': 'Approved for transplant',
//       'status': 'Confirmed',
//       'myDecision': false
//     },
//   ];

//   List<Map<String, dynamic>> get _filteredCouncilEvents {
//     return _showMyDecisions
//         ? _allCouncilEvents.where((event) => event['myDecision']).toList()
//         : _allCouncilEvents;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8FAFC),
//       body: Column(
//         children: [
//           _buildEnhancedHeader(),
//           _buildToggleFilter(),
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(20),
//               itemCount: _filteredCouncilEvents.length,
//               itemBuilder: (context, index) {
//                 final event = _filteredCouncilEvents[index];
//                 return _buildCouncilCard(event);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildToggleFilter() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           _buildFilterButton('My Decisions', true),
//           const SizedBox(width: 16),
//           _buildFilterButton('All Decisions', false),
//         ],
//       ),
//     );
//   }

//   Widget _buildFilterButton(String text, bool isMyDecisions) {
//     final isActive = _showMyDecisions == isMyDecisions;
    
//     return Expanded(
//       child: Material(
//         borderRadius: BorderRadius.circular(12),
//         elevation: isActive ? 4 : 0,
//         shadowColor: const Color(0xFF1E3A8A).withOpacity(0.3),
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 250),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             color: isActive ? const Color(0xFF1E3A8A) : Colors.white,
//             border: Border.all(
//               color: isActive ? const Color(0xFF1E3A8A) : Colors.grey[300]!,
//               width: isActive ? 2 : 1,
//             ),
//           ),
//           child: InkWell(
//             borderRadius: BorderRadius.circular(12),
//             onTap: () => setState(() => _showMyDecisions = isMyDecisions),
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               child: Center(
//                 child: Text(
//                   text,
//                   style: TextStyle(
//                     color: isActive ? Colors.white : const Color(0xFF1E293B),
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildEnhancedHeader() {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 8,
//             offset: Offset(0, 2),)
//         ],
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Row(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 4,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: const CircleAvatar(
//                   radius: 22,
//                   backgroundColor: Colors.white,
//                   child: Icon(Icons.medical_services_rounded, color: Color(0xFF1E3A8A), size: 26),
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Medical Council',
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     Text(
//                       'Doctor Portal',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.white.withOpacity(0.8),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   // Navigate to Matching System
//                 },
//                 style: TextButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                 ),
//                 child: const Text(
//                   'Matching System',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardDoctor()));
//                 },
//                 style: TextButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                 ),
//                 child: const Text(
//                   'Organs/Patients',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: null,
//                 style: TextButton.styleFrom(
//                   foregroundColor: const Color.fromARGB(255, 153, 245, 176),
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                 ),
//                 child: const Text(
//                   'Medical Council',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               LayoutBuilder(
//                 builder: (context, constraints) {
//                   final spacerWidth = constraints.maxWidth * 0.2;
//                   return SizedBox(width: spacerWidth.clamp(8, 200));
//                 },
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.white.withOpacity(0.2)),
//                 ),
//                 child: IconButton(
//                   icon: const Icon(Icons.logout_rounded, color: Colors.white, size: 22),
//                   onPressed: _logout,
//                   tooltip: 'Logout',
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCouncilCard(Map<String, dynamic> event) {
//     Color statusColor;
//     switch (event['status']) {
//       case 'Confirmed':
//         statusColor = const Color(0xFF10B981);
//         break;
//       case 'Rejected':
//         statusColor = const Color(0xFFEF4444);
//         break;
//       default:
//         statusColor = const Color(0xFFF59E0B);
//     }

//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(12),
//         onTap: () => _showCouncilDetails(event),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF3B82F6).withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Icon(Icons.groups_rounded, color: Color(0xFF3B82F6)),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Text(
//                       event['title'],
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF1E293B),
//                       ),
//                     ),
//                   ),
//                   if (event['myDecision'])
//                     Container(
//                       margin: const EdgeInsets.only(right: 8),
//                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF1E3A8A).withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: const Color(0xFF1E3A8A).withOpacity(0.3)),
//                       ),
//                       child: const Text(
//                         'My Decision',
//                         style: TextStyle(
//                           color: Color(0xFF1E3A8A),
//                           fontSize: 10,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: statusColor.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(color: statusColor.withOpacity(0.3)),
//                     ),
//                     child: Text(
//                       event['status'],
//                       style: TextStyle(
//                         color: statusColor,
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 'Patient: ${event['patient']}',
//                 style: const TextStyle(
//                   color: Color(0xFF64748B),
//                   fontSize: 14,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 'Date: ${event['date']}',
//                 style: const TextStyle(
//                   color: Color(0xFF64748B),
//                   fontSize: 14,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// /*
//   void _showCouncilDetails(Map<String, dynamic> event) {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20)),
//         child: Container(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF3B82F6).withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Icon(
//                       Icons.groups_rounded,
//                       color: Color(0xFF3B82F6),
//                       size: 24,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           event['title'],
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF1E293B),
//                           ),
//                         ),
//                         Text(
//                           'Patient: ${event['patient']}',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: const Color(0xFF64748B).withOpacity(0.8),
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//               _buildDetailRow('Date', event['date'], Icons.calendar_today_rounded),
//               _buildDetailRow('Description', event['description'], Icons.description_rounded),
//               _buildDetailRow('Council Decision', event['decision'], Icons.gavel_rounded),
//               if (event['myDecision']) 
//                 _buildDetailRow('Your Involvement', 'You participated in this decision', Icons.person),
//               const SizedBox(height: 24),
//               if (event['status'] == 'Pending Confirmation' && event['myDecision'])
//                 Row(
//                   children: [
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                           _updateCouncilStatus(event['id'], 'Rejected');
//                         },
//                         style: OutlinedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                           side: const BorderSide(color: Color(0xFFEF4444)),
//                         ),
//                         child: const Text(
//                           'Reject Decision',
//                           style: TextStyle(
//                             color: Color(0xFFEF4444),
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                           _updateCouncilStatus(event['id'], 'Confirmed');
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF10B981),
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                         ),
//                         child: const Text(
//                           'Confirm Decision',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               else
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () => Navigator.pop(context),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF1E3A8A),
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                     ),
//                     child: const Text('Close'),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// */
// void _showCouncilDetails(Map<String, dynamic> event) {
//   showDialog(
//     context: context,
//     builder: (context) => Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20)),
//       child: Container(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ... (keep existing header content) ...

//             if (event['status'] == 'Pending Confirmation') // Changed condition
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                         _updateCouncilStatus(event['id'], 'Rejected');
//                       },
//                       style: OutlinedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         side: const BorderSide(color: Color(0xFFEF4444)),
//                       ),
//                       child: const Text(
//                         'Reject Decision',
//                         style: TextStyle(
//                           color: Color(0xFFEF4444),
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                         _updateCouncilStatus(event['id'], 'Confirmed');
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF10B981),
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                       ),
//                       child: const Text(
//                         'Confirm Decision',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             else
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () => Navigator.pop(context),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF1E3A8A),
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                   ),
//                   child: const Text('Close'),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     ),
//   );
// }


//   Widget _buildDetailRow(String label, String value, IconData icon) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF8FAFC),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: const Color(0xFFE2E8F0)),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, size: 18, color: const Color(0xFF64748B)),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xFF1E293B),
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   value,
//                   style: TextStyle(
//                     color: const Color(0xFF64748B),
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _updateCouncilStatus(String id, String newStatus) {
//     setState(() {
//       final index = _allCouncilEvents.indexWhere((e) => e['id'] == id);
//       if (index != -1) {
//         _allCouncilEvents[index]['status'] = newStatus;
//       }
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Decision $newStatus successfully'),
//         backgroundColor: newStatus == 'Confirmed' 
//             ? const Color(0xFF10B981)
//             : const Color(0xFFEF4444),
//       ),
//     );
//   }

//   void _logout() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: const Text('Logout'),
//         content: const Text('Are you sure you want to logout?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Navigator.of(context).pop();
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFFEF4444),
//               foregroundColor: Colors.white,
//             ),
//             child: const Text('Logout'),
//           ),
//         ],
//       ),
//     );
//   }
// }


