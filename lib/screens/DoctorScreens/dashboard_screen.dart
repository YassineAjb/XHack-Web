

import 'package:flutter/material.dart';
import 'package:webxhack/screens/DoctorScreens/council_screen.dart';
import 'package:webxhack/screens/DoctorScreens/home_doctor_screen.dart';

class DashboardDoctor extends StatefulWidget {
  const DashboardDoctor({super.key,this.onSearchChanged,});

  final ValueChanged<String>? onSearchChanged;

  @override
  State<DashboardDoctor> createState() => _StaffHomePageState();
}

class _StaffHomePageState extends State<DashboardDoctor> with TickerProviderStateMixin {

    // Add these new variables at the top of your state class with other variables
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  bool _showSearch = false;


  int _currentTabIndex = 0;
  bool _showLists = true;
  late AnimationController _toggleAnimationController;
  late Animation<double> _toggleAnimation;
  
  // Enhanced color scheme
  static const Color primaryBlue = Color(0xFF1E3A8A);
  static const Color lightBlue = Color(0xFF3B82F6);
  static const Color accentGreen = Color(0xFF10B981);
  static const Color warningOrange = Color(0xFFF59E0B);
  static const Color lightGray = Color(0xFFF8FAFC);
  static const Color mediumGray = Color(0xFF64748B);
  static const Color darkGray = Color(0xFF1E293B);
  
  // Sample data
  final List<Map<String, dynamic>> _organs = [
    {'id': 'KID-001', 'type': 'Kidney', 'bloodType': 'A+', 'status': 'Available', 'donor': 'Anonymous', 'location': 'OR-1'},
    {'id': 'LIV-002', 'type': 'Liver', 'bloodType': 'O-', 'status': 'Reserved', 'donor': 'Anonymous', 'location': 'OR-2'},
    {'id': 'HRT-003', 'type': 'Heart', 'bloodType': 'B+', 'status': 'Available', 'donor': 'Anonymous', 'location': 'OR-3'},
    {'id': 'LNG-004', 'type': 'Lung', 'bloodType': 'AB+', 'status': 'In Transit', 'donor': 'Anonymous', 'location': 'Transport'},
  ];

  final List<Map<String, dynamic>> _patients = [
    {'id': 'PAT-001', 'name': 'John Smith', 'bloodType': 'A+', 'waitingSince': '2023-01-15', 'priority': 'High', 'organNeeded': 'Kidney'},
    {'id': 'PAT-002', 'name': 'Sarah Johnson', 'bloodType': 'O-', 'waitingSince': '2023-02-20', 'priority': 'Critical', 'organNeeded': 'Liver'},
    {'id': 'PAT-003', 'name': 'Michael Brown', 'bloodType': 'B+', 'waitingSince': '2023-03-10', 'priority': 'Medium', 'organNeeded': 'Heart'},
    {'id': 'PAT-004', 'name': 'Emily Davis', 'bloodType': 'AB+', 'waitingSince': '2023-04-05', 'priority': 'High', 'organNeeded': 'Lung'},
  ];

  // Form controllers
  final TextEditingController _organIdController = TextEditingController();
  final TextEditingController _organTypeController = TextEditingController();
  final TextEditingController _organBloodTypeController = TextEditingController();
  final TextEditingController _patientNameController = TextEditingController();
  final TextEditingController _patientBloodTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _toggleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _toggleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _toggleAnimationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _toggleAnimationController.dispose();
    _organIdController.dispose();
    _organTypeController.dispose();
    _organBloodTypeController.dispose();
    _patientNameController.dispose();
    _patientBloodTypeController.dispose();
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGray,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildEnhancedHeader(),
            Column(
              children: [
                _buildStatisticsSection(),
                _buildNavigationSection(),
                _showLists ? _buildListView() : _buildFormView(),
              ],
            ),
          ],
        ),
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
                    Text(
                      _showLists ? 'Medical Dashboard' : 'Add ${_currentTabIndex == 0 ? 'Organ' : 'Patient'}',
                      style: const TextStyle(
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
              // New TextButton added here
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OrganMatchingPage()));
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
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardDoctor()));
                },
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 153, 245, 176),
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
              // TextButton(
              //   onPressed: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => MedicalCouncilScreen()));
              //   },
              //   style: TextButton.styleFrom(
              //     foregroundColor: Colors.white,
              //     padding: const EdgeInsets.symmetric(horizontal: 12),
              //   ),
              //   child: const Text(
              //     'Medical council',
              //     style: TextStyle(
              //       fontSize: 14,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),
TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MedicalCouncilScreen()),
    );
  },
  style: TextButton.styleFrom(
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 12),
  ),
  child: Row(
    children: [
      const Text(
        'Medical council',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(width: 6),
      Stack(
        clipBehavior: Clip.none,
        children: const [
          Icon(Icons.notifications_none, size: 18),
          Positioned(
            top: -2,
            right: -2,
            child: CircleAvatar(
              radius: 4,
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    ],
  ),
),

              // Right side - Responsive spacer
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

  Widget _buildStatisticsSection() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(
        children: [
          _buildStatCard(
            icon: Icons.medical_services_rounded,
            title: 'Available Organs',
            value: _organs.where((o) => o['status'] == 'Available').length.toString(),
            subtitle: '${_organs.where((o) => o['status'] == 'Reserved').length} Reserved',
            color: accentGreen,
            gradient: [accentGreen.withOpacity(0.1), accentGreen.withOpacity(0.05)],
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            icon: Icons.people_rounded,
            title: 'Waiting Patients',
            value: _patients.length.toString(),
            subtitle: '${_patients.where((p) => p['priority'] == 'Critical').length} Critical',
            color: warningOrange,
            gradient: [warningOrange.withOpacity(0.1), warningOrange.withOpacity(0.05)],
          ),
        ],
      ),
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
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(16),
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
                  child: Icon(icon, color: color, size: 20),
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

  Widget _buildNavigationSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              _buildToggleButton(),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildTabButton('Organ Management', Icons.medical_services_rounded, 0),
              const SizedBox(width: 12),
              _buildTabButton('Patient Registry', Icons.people_rounded, 1),
            ],
          ),
        ],
      ),
    );
  }

Widget _buildToggleButton() {
  return Row(
    mainAxisSize: MainAxisSize.min, // Makes the row take minimum space
    children: [
      // Your existing toggle button
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          borderRadius: BorderRadius.circular(14),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: LinearGradient(
                colors: _showLists 
                    ? [accentGreen, accentGreen.withOpacity(0.8)]
                    : [lightBlue, lightBlue.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () {
                setState(() {
                  _showLists = !_showLists;
                  if (_showLists) {
                    _toggleAnimationController.reverse();
                  } else {
                    _toggleAnimationController.forward();
                    _clearForms();
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        _showLists ? Icons.add_circle_rounded : Icons.list_alt_rounded,
                        color: Colors.white,
                        size: 20,
                        key: ValueKey(_showLists),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      _showLists ? 'Add New ${_currentTabIndex == 0 ? 'Organ' : 'Patient'}' 
                                : 'View ${_currentTabIndex == 0 ? 'Organs' : 'Patients'} List',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(width: 10), // Spacing between toggle and search button
      // Always-visible search field
      Container(
        width: 200, // Fixed width or use Flexible for dynamic width
        height: 30, // Match your toggle button height
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(14),
        ),
        child: TextField(
          controller: _searchController,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            prefixIcon: Icon(Icons.search, color: const Color.fromARGB(255, 206, 46, 46), size: 20),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.close, color: const Color.fromARGB(255, 21, 3, 3), size: 20),
                    onPressed: () {
                      _searchController.clear();
                      if (widget.onSearchChanged != null) {
                        widget.onSearchChanged!('');
                      }
                    },
                  )
                : null,
          ),
          style: const TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
          onChanged: widget.onSearchChanged ?? (value) {
            // Handle search if no callback provided
          },
        ),
      ),
    ],
  );
}



  Widget _buildTabButton(String title, IconData icon, int index) {
    final isActive = _currentTabIndex == index;
    return Expanded(
      child: Material(
        borderRadius: BorderRadius.circular(12),
        elevation: isActive ? 4 : 0,
        shadowColor: primaryBlue.withOpacity(0.3),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isActive ? primaryBlue : Colors.white,
            border: Border.all(
              color: isActive ? primaryBlue : Colors.grey[300]!,
              width: isActive ? 2 : 1,
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => setState(() => _currentTabIndex = index),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: isActive ? Colors.white : mediumGray,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isActive ? Colors.white : darkGray,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: _currentTabIndex == 0 ? _buildOrganList() : _buildPatientList(),
    );
  }

  Widget _buildOrganList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _organs.length,
      itemBuilder: (context, index) {
        final organ = _organs[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(20),
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getOrganColor(organ['type']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getOrganIcon(organ['type']),
                size: 24,
                color: _getOrganColor(organ['type']),
              ),
            ),
            title: Text(
              '${organ['type']} - ${organ['id']}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: darkGray,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.bloodtype_rounded, size: 16, color: mediumGray),
                      const SizedBox(width: 4),
                      Text(
                        organ['bloodType'],
                        style: TextStyle(color: mediumGray, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.location_on_rounded, size: 16, color: mediumGray),
                      const SizedBox(width: 4),
                      Text(
                        organ['location'],
                        style: TextStyle(color: mediumGray, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getStatusColor(organ['status']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _getStatusColor(organ['status']).withOpacity(0.3)),
              ),
              child: Text(
                organ['status'],
                style: TextStyle(
                  color: _getStatusColor(organ['status']),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () => _showOrganDetails(context, organ),
          ),
        );
      },
    );
  }

  Widget _buildPatientList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _patients.length,
      itemBuilder: (context, index) {
        final patient = _patients[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(20),
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getPriorityColor(patient['priority']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.person_rounded,
                size: 24,
                color: _getPriorityColor(patient['priority']),
              ),
            ),
            title: Text(
              patient['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: darkGray,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.bloodtype_rounded, size: 16, color: mediumGray),
                      const SizedBox(width: 4),
                      Text(
                        patient['bloodType'],
                        style: TextStyle(color: mediumGray, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.medical_services_rounded, size: 16, color: mediumGray),
                      const SizedBox(width: 4),
                      Text(
                        patient['organNeeded'],
                        style: TextStyle(color: mediumGray, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Waiting since ${patient['waitingSince']}',
                    style: TextStyle(color: mediumGray, fontSize: 12),
                  ),
                ],
              ),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getPriorityColor(patient['priority']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _getPriorityColor(patient['priority']).withOpacity(0.3)),
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
            onTap: () => _showPatientDetails(context, patient),
          ),
        );
      },
    );
  }

  Widget _buildFormView() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: primaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _currentTabIndex == 0 ? Icons.medical_services_rounded : Icons.person_add_rounded,
                      color: primaryBlue,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add New ${_currentTabIndex == 0 ? 'Organ' : 'Patient'}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: darkGray,
                        ),
                      ),
                      Text(
                        'Fill in the required information below',
                        style: TextStyle(
                          fontSize: 14,
                          color: mediumGray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
              _currentTabIndex == 0 ? _buildOrganForm() : _buildPatientForm(),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 4,
                    shadowColor: primaryBlue.withOpacity(0.3),
                  ),
                  child: const Text(
                    'Save Information',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrganForm() {
    return Column(
      children: [
        _buildFormField(
          controller: _organIdController,
          label: 'Organ ID',
          icon: Icons.qr_code_rounded,
          hint: 'e.g., KID-001',
        ),
        const SizedBox(height: 20),
        _buildFormField(
          controller: _organTypeController,
          label: 'Organ Type',
          icon: Icons.medical_services_rounded,
          hint: 'e.g., Kidney, Liver, Heart',
        ),
        const SizedBox(height: 20),
        _buildFormField(
          controller: _organBloodTypeController,
          label: 'Blood Type',
          icon: Icons.bloodtype_rounded,
          hint: 'e.g., A+, O-, B+, AB-',
        ),
      ],
    );
  }

  Widget _buildPatientForm() {
    return Column(
      children: [
        _buildFormField(
          controller: _patientNameController,
          label: 'Patient Name',
          icon: Icons.person_rounded,
          hint: 'Enter full name',
        ),
        const SizedBox(height: 20),
        _buildFormField(
          controller: _patientBloodTypeController,
          label: 'Blood Type',
          icon: Icons.bloodtype_rounded,
          hint: 'e.g., A+, O-, B+, AB-',
        ),
      ],
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: darkGray,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: mediumGray.withOpacity(0.7)),
            prefixIcon: Icon(icon, color: primaryBlue, size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: primaryBlue, width: 2),
            ),
            filled: true,
            fillColor: lightGray,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  Color _getOrganColor(String type) {
    switch (type.toLowerCase()) {
      case 'kidney': return const Color(0xFF8B5CF6);
      case 'liver': return const Color(0xFFF59E0B);
      case 'heart': return const Color(0xFFEF4444);
      case 'lung': return const Color(0xFF06B6D4);
      default: return primaryBlue;
    }
  }

  IconData _getOrganIcon(String type) {
    switch (type.toLowerCase()) {
      case 'kidney': return Icons.water_drop_rounded;
      case 'liver': return Icons.restaurant_rounded;
      case 'heart': return Icons.favorite_rounded;
      case 'lung': return Icons.air_rounded;
      default: return Icons.medical_services_rounded;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'available': return accentGreen;
      case 'reserved': return warningOrange;
      case 'in transit': return lightBlue;
      default: return mediumGray;
    }
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

  void _clearForms() {
    _organIdController.clear();
    _organTypeController.clear();
    _organBloodTypeController.clear();
    _patientNameController.clear();
    _patientBloodTypeController.clear();
  }

  void _saveForm() {
    if (_currentTabIndex == 0) {
      if (_organIdController.text.isEmpty || 
          _organTypeController.text.isEmpty || 
          _organBloodTypeController.text.isEmpty) {
        _showSnackBar('Please fill all fields', isError: true);
        return;
      }

      final newOrgan = {
        'id': _organIdController.text,
        'type': _organTypeController.text,
        'bloodType': _organBloodTypeController.text,
        'status': 'Available',
        'donor': 'Anonymous',
        'location': 'OR-${_organs.length + 1}',
      };
      setState(() {
        _organs.add(newOrgan);
        _showLists = true;
      });
      _showSnackBar('Organ added successfully', isError: false);
      _clearForms();
    } else {
      if (_patientNameController.text.isEmpty || 
          _patientBloodTypeController.text.isEmpty) {
        _showSnackBar('Please fill all fields', isError: true);
        return;
      }

      final newPatient = {
        'id': 'PAT-${(_patients.length + 1).toString().padLeft(3, '0')}',
        'name': _patientNameController.text,
        'bloodType': _patientBloodTypeController.text,
        'waitingSince': DateTime.now().toString().split(' ')[0],
        'priority': 'Medium',
        'organNeeded': 'Kidney',
      };
      setState(() {
        _patients.add(newPatient);
        _showLists = true;
      });
      _showSnackBar('Patient added successfully', isError: false);
      _clearForms();
    }
  }

  void _showSnackBar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_rounded : Icons.check_circle_rounded,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              message,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
        backgroundColor: isError ? const Color(0xFFDC2626) : accentGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showOrganDetails(BuildContext context, Map<String, dynamic> organ) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _getOrganColor(organ['type']).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getOrganIcon(organ['type']),
                      color: _getOrganColor(organ['type']),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Organ Details',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: darkGray,
                          ),
                        ),
                        Text(
                          organ['id'],
                          style: TextStyle(
                            fontSize: 14,
                            color: mediumGray,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildDetailRow('Type', organ['type'], Icons.medical_services_rounded),
              _buildDetailRow('Blood Type', organ['bloodType'], Icons.bloodtype_rounded),
              _buildDetailRow('Status', organ['status'], Icons.info_rounded),
              _buildDetailRow('Location', organ['location'], Icons.location_on_rounded),
              _buildDetailRow('Donor', organ['donor'], Icons.person_rounded),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Close',
                        style: TextStyle(
                          fontSize: 14,
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
                        // Edit functionality would go here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPatientDetails(BuildContext context, Map<String, dynamic> patient) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _getPriorityColor(patient['priority']).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.person_rounded,
                      color: _getPriorityColor(patient['priority']),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Patient Details',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: darkGray,
                          ),
                        ),
                        Text(
                          patient['name'],
                          style: TextStyle(
                            fontSize: 14,
                            color: mediumGray,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildDetailRow('Patient ID', patient['id'], Icons.badge_rounded),
              _buildDetailRow('Blood Type', patient['bloodType'], Icons.bloodtype_rounded),
              _buildDetailRow('Organ Needed', patient['organNeeded'], Icons.medical_services_rounded),
              _buildDetailRow('Priority', patient['priority'], Icons.priority_high_rounded),
              _buildDetailRow('Waiting Since', patient['waitingSince'], Icons.calendar_today_rounded),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Close',
                        style: TextStyle(
                          fontSize: 14,
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
                        // Edit functionality would go here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
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
        color: lightGray,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: mediumGray),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: darkGray,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: mediumGray,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
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
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              foregroundColor: Colors.white,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

