import 'package:flutter/material.dart';
class AdminStudentsManagementApp extends StatelessWidget {
  const AdminStudentsManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CanteenGo Admin - Students',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F6F6),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC6102E)),
        fontFamily: 'sans-serif',
      ),
      home: const AdminStudentsManagementScreen(),
    );
  }
}

// ─── Constants ───────────────────────────────────────────────────────────────

const Color kPrimary = Color(0xFFC6102E);
const Color kBackground = Color(0xFFF8F6F6);

// ─── Models ──────────────────────────────────────────────────────────────────

class Student {
  final String name;
  final String initials;
  final Color avatarBg;
  final Color avatarFg;
  final String studentId;
  final String email;
  final int totalOrders;
  final bool isActive;

  const Student({
    required this.name,
    required this.initials,
    required this.avatarBg,
    required this.avatarFg,
    required this.studentId,
    required this.email,
    required this.totalOrders,
    required this.isActive,
  });
}

const List<Student> kStudents = [
  Student(
    name: 'Johnathan Doe',
    initials: 'JD',
    avatarBg: Color(0xFFFFE4E6),
    avatarFg: kPrimary,
    studentId: 'STU2024-001',
    email: 'j.doe@university.edu',
    totalOrders: 124,
    isActive: true,
  ),
  Student(
    name: 'Sarah Miller',
    initials: 'SM',
    avatarBg: Color(0xFFFFEDD5),
    avatarFg: Color(0xFFEA580C),
    studentId: 'STU2024-042',
    email: 's.miller@university.edu',
    totalOrders: 45,
    isActive: true,
  ),
  Student(
    name: 'Robert Wilson',
    initials: 'RW',
    avatarBg: Color(0xFFF1F5F9),
    avatarFg: Color(0xFF475569),
    studentId: 'STU2023-112',
    email: 'r.wilson@university.edu',
    totalOrders: 12,
    isActive: false,
  ),
  Student(
    name: 'Emily Garcia',
    initials: 'EG',
    avatarBg: Color(0xFFF3E8FF),
    avatarFg: Color(0xFF9333EA),
    studentId: 'STU2024-089',
    email: 'e.garcia@university.edu',
    totalOrders: 238,
    isActive: true,
  ),
  Student(
    name: 'Kevin Patel',
    initials: 'KP',
    avatarBg: Color(0xFFCCFBF1),
    avatarFg: Color(0xFF0D9488),
    studentId: 'STU2024-015',
    email: 'k.patel@university.edu',
    totalOrders: 87,
    isActive: true,
  ),
];

// ─── Screen ───────────────────────────────────────────────────────────────────

class AdminStudentsManagementScreen extends StatefulWidget {
  const AdminStudentsManagementScreen({super.key});

  @override
  State<AdminStudentsManagementScreen> createState() =>
      _AdminStudentsManagementScreenState();
}

class _AdminStudentsManagementScreenState
    extends State<AdminStudentsManagementScreen> {
  int _selectedNavIndex = 1; // Students active

  final _navItems = const [
    _NavItem(icon: Icons.dashboard_outlined, label: 'Dashboard'),
    _NavItem(icon: Icons.group_outlined, label: 'Students'),
    _NavItem(icon: Icons.shopping_cart_outlined, label: 'Orders'),
    _NavItem(icon: Icons.restaurant_menu_outlined, label: 'Menu'),
    _NavItem(icon: Icons.bar_chart_outlined, label: 'Reports'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildTopBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPageHeader(),
                        const SizedBox(height: 28),
                        _buildStatsRow(),
                        const SizedBox(height: 28),
                        _buildStudentDirectory(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Sidebar ───────────────────────────────────────────────────────────────

  Widget _buildSidebar() {
    return Container(
      width: 272,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kPrimary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.restaurant,
                      color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                const Text(
                  'CanteenGo',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),

          // Section label
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 8),
            child: Text(
              'MAIN MENU',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Color(0xFF94A3B8),
                letterSpacing: 1.2,
              ),
            ),
          ),

          // Nav items
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: List.generate(_navItems.length, (i) {
                  final item = _navItems[i];
                  final isActive = i == _selectedNavIndex;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedNavIndex = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      margin: const EdgeInsets.only(bottom: 2),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isActive
                            ? kPrimary.withValues(alpha: 0.08)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item.icon,
                            size: 20,
                            color: isActive
                                ? kPrimary
                                : const Color(0xFF64748B),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isActive
                                  ? kPrimary
                                  : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          // Settings footer
          Container(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.settings_outlined,
                        size: 20, color: Color(0xFF64748B)),
                    SizedBox(width: 12),
                    Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Top Bar ───────────────────────────────────────────────────────────────

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          // Search bar
          Expanded(
            child: Container(
              height: 40,
              constraints: const BoxConstraints(maxWidth: 400),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  SizedBox(width: 12),
                  Icon(Icons.search,
                      color: Color(0xFF94A3B8), size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search students, IDs, or emails...',
                        hintStyle: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 13,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          // Notification bell
          Stack(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Icon(Icons.notifications_outlined,
                    color: Color(0xFF475569), size: 22),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: kPrimary,
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: Colors.white, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),

          // Admin info
          Container(
            padding: const EdgeInsets.only(left: 16),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xFFE2E8F0)),
              ),
            ),
            child: Row(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Admin Portal',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      'Super Admin',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: kPrimary.withValues(alpha: 0.2),
                      width: 2,
                    ),
                  ),
                  child: const Icon(Icons.person_outline,
                      color: Color(0xFF94A3B8), size: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Page Header ───────────────────────────────────────────────────────────

  Widget _buildPageHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Students Management',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Overview and management of all registered student accounts.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add, size: 18),
          label: const Text(
            'Add New Student',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
                horizontal: 22, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            elevation: 4,
            shadowColor: kPrimary.withValues(alpha: 0.25),
          ),
        ),
      ],
    );
  }

  // ── Stats Row ─────────────────────────────────────────────────────────────

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            iconBg: const Color(0xFFDBEAFE),
            icon: Icons.person_outline,
            iconColor: const Color(0xFF2563EB),
            badge: '+12%',
            badgeBg: const Color(0xFFF0FDF4),
            badgeColor: const Color(0xFF16A34A),
            label: 'Total Students',
            value: '2,845',
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _StatCard(
            iconBg: kPrimary.withValues(alpha: 0.08),
            icon: Icons.shopping_bag_outlined,
            iconColor: kPrimary,
            badge: '+8%',
            badgeBg: const Color(0xFFF0FDF4),
            badgeColor: const Color(0xFF16A34A),
            label: 'Active Subscriptions',
            value: '1,920',
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _StatCard(
            iconBg: const Color(0xFFF1F5F9),
            icon: Icons.pending_actions_outlined,
            iconColor: const Color(0xFF475569),
            badge: 'New',
            badgeBg: const Color(0xFFF8FAFC),
            badgeColor: const Color(0xFF64748B),
            label: 'Pending Requests',
            value: '42',
          ),
        ),
      ],
    );
  }

  // ── Student Directory Table ────────────────────────────────────────────────

  Widget _buildStudentDirectory() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Table title row
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
            child: Row(
              children: [
                const Text(
                  'Student Directory',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: const [
                      Icon(Icons.filter_list,
                          size: 18, color: Color(0xFF64748B)),
                      SizedBox(width: 6),
                      Text(
                        'Filter List',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          // Column headers
          Container(
            color: const Color(0xFFF8FAFC),
            padding: const EdgeInsets.symmetric(
                horizontal: 24, vertical: 12),
            child: const Row(
              children: [
                SizedBox(
                    width: 220,
                    child: _ColHeader('STUDENT NAME')),
                SizedBox(
                    width: 150,
                    child: _ColHeader('STUDENT ID')),
                Expanded(child: _ColHeader('COLLEGE EMAIL')),
                SizedBox(
                    width: 110,
                    child: _ColHeader('TOTAL ORDERS')),
                SizedBox(
                    width: 110,
                    child: _ColHeader('STATUS')),
                SizedBox(
                  width: 90,
                  child: _ColHeader('ACTIONS',
                      align: TextAlign.right),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          // Student rows
          ...List.generate(kStudents.length, (i) {
            return Column(
              children: [
                _StudentRow(student: kStudents[i]),
                if (i < kStudents.length - 1)
                  const Divider(
                      height: 1, color: Color(0xFFF1F5F9)),
              ],
            );
          }),

          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          // Pagination footer
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 24, vertical: 14),
            child: Row(
              children: [
                const Text(
                  'Showing 1 to 5 of 2,845 students',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF334155),
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Previous',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Stat Card ────────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final Color iconBg;
  final IconData icon;
  final Color iconColor;
  final String badge;
  final Color badgeBg;
  final Color badgeColor;
  final String label;
  final String value;

  const _StatCard({
    required this.iconBg,
    required this.icon,
    required this.iconColor,
    required this.badge,
    required this.badgeBg,
    required this.badgeColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeBg,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: badgeColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Column Header ────────────────────────────────────────────────────────────

class _ColHeader extends StatelessWidget {
  final String text;
  final TextAlign align;

  const _ColHeader(this.text, {this.align = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: Color(0xFF64748B),
        letterSpacing: 0.8,
      ),
    );
  }
}

// ─── Student Row ──────────────────────────────────────────────────────────────

class _StudentRow extends StatefulWidget {
  final Student student;
  const _StudentRow({required this.student});

  @override
  State<_StudentRow> createState() => _StudentRowState();
}

class _StudentRowState extends State<_StudentRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final s = widget.student;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        color: _hovered
            ? const Color(0xFFF8FAFC)
            : Colors.transparent,
        padding: const EdgeInsets.symmetric(
            horizontal: 24, vertical: 14),
        child: Row(
          children: [
            // Name with avatar
            SizedBox(
              width: 220,
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: s.avatarBg,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        s.initials,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: s.avatarFg,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      s.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0F172A),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // Student ID
            SizedBox(
              width: 150,
              child: Text(
                s.studentId,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF475569),
                ),
              ),
            ),

            // Email
            Expanded(
              child: Text(
                s.email,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Total Orders
            SizedBox(
              width: 110,
              child: Text(
                '${s.totalOrders}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0F172A),
                ),
              ),
            ),

            // Status badge
            SizedBox(
              width: 110,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: s.isActive
                      ? const Color(0xFFDCFCE7)
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  s.isActive ? 'Active' : 'Inactive',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: s.isActive
                        ? const Color(0xFF15803D)
                        : const Color(0xFF475569),
                  ),
                ),
              ),
            ),

            // Actions
            SizedBox(
              width: 90,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 150),
                opacity: _hovered ? 1.0 : 0.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(Icons.edit_outlined,
                            size: 18,
                            color: Color(0xFF94A3B8)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(Icons.delete_outline,
                            size: 18,
                            color: Color(0xFF94A3B8)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Nav Item Model ───────────────────────────────────────────────────────────

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}