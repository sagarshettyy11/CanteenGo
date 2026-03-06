import 'package:flutter/material.dart';

void main() {
  runApp(const CanteenGoProfileApp());
}

class CanteenGoProfileApp extends StatelessWidget {
  const CanteenGoProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CanteenGo - Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Plus Jakarta Sans',
        scaffoldBackgroundColor: const Color(0xFFF8F6F6),
      ),
      home: const StudentProfileScreen(),
    );
  }
}

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  static const Color _primary = Color(0xFFC6102E);
  static const Color _bgLight = Color(0xFFF8F6F6);

  int _selectedNavIndex = 3; // Profile tab active

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildProfileSection(),
                    const SizedBox(height: 8),
                    _buildMenuSection(),
                    const SizedBox(height: 32),
                    _buildLogoutButton(),
                    const SizedBox(height: 16),
                    _buildVersionText(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Container(
      color: _bgLight.withValues(alpha: 0.8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Back button
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Color(0xFF0F172A),
              size: 20,
            ),
          ),
          const Expanded(
            child: Text(
              'My Profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
                letterSpacing: -0.3,
              ),
            ),
          ),
          // Settings button
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.settings_outlined,
              color: Color(0xFF0F172A),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  // ── Profile Section ──────────────────────────────────────────────────────────

  Widget _buildProfileSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          // Avatar with edit button
          Stack(
            children: [
              Container(
                width: 128,
                height: 128,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  color: const Color(0xFF2D4A6B),
                ),
                child: ClipOval(
                  child: Container(
                    color: const Color(0xFF2D4A6B),
                    child: const Icon(
                      Icons.person,
                      size: 72,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: _primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x44C6102E),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.edit, color: Colors.white, size: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Name
          const Text(
            'Alex Johnson',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),

          // Email
          const Text(
            'alex.j@college.edu',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 10),

          // Student ID badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: _primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(99),
            ),
            child: const Text(
              'Student ID: CG-2024-0891',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Menu Section ─────────────────────────────────────────────────────────────

  Widget _buildMenuSection() {
    final menuItems = [
      _MenuItem(
        icon: Icons.receipt_long_outlined,
        title: 'My Orders',
        subtitle: 'Order history and status',
      ),
      _MenuItem(
        icon: Icons.favorite_outline,
        title: 'Saved Meals',
        subtitle: 'Your favorite canteen treats',
      ),
      _MenuItem(
        icon: Icons.credit_card_outlined,
        title: 'Payment Methods',
        subtitle: 'Manage cards and wallets',
      ),
      _MenuItem(
        icon: Icons.notifications_outlined,
        title: 'Notifications',
        subtitle: 'Alerts and updates',
      ),
      _MenuItem(
        icon: Icons.help_outline,
        title: 'Support',
        subtitle: 'FAQs and help desk',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: menuItems.map((item) => _buildMenuItem(item)).toList(),
        ),
      ),
    );
  }

  Widget _buildMenuItem(_MenuItem item) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Icon box
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item.icon, color: _primary, size: 22),
              ),
              const SizedBox(width: 16),
              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0F172A),
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Color(0xFF94A3B8),
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Logout Button ────────────────────────────────────────────────────────────

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.logout, size: 20),
          label: const Text(
            'Logout',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: _primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            shadowColor: _primary.withValues(alpha: 0.35),
          ),
        ),
      ),
    );
  }

  // ── Version Text ─────────────────────────────────────────────────────────────

  Widget _buildVersionText() {
    return const Text(
      'CanteenGo App Version 2.4.0',
      style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
    );
  }

  // ── Bottom Navigation ────────────────────────────────────────────────────────

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'HOME',
            index: 0,
          ),
          _buildNavItem(icon: Icons.search, label: 'EXPLORE', index: 1),
          _buildNavItemCart(index: 2),
          _buildNavItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: 'PROFILE',
            index: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    IconData? activeIcon,
    required String label,
    required int index,
  }) {
    final selected = _selectedNavIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedNavIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            selected && activeIcon != null ? activeIcon : icon,
            color: selected ? _primary : const Color(0xFF94A3B8),
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
              color: selected ? _primary : const Color(0xFF94A3B8),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItemCart({required int index}) {
    final selected = _selectedNavIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedNavIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                color: selected ? _primary : const Color(0xFF94A3B8),
                size: 24,
              ),
              Positioned(
                top: -2,
                right: -4,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: _primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'CART',
            style: TextStyle(
              fontSize: 10,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
              color: selected ? _primary : const Color(0xFF94A3B8),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Data Model ────────────────────────────────────────────────────────────────

class _MenuItem {
  final IconData icon;
  final String title;
  final String subtitle;

  _MenuItem({required this.icon, required this.title, required this.subtitle});
}
