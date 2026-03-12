import 'package:flutter/material.dart';

class AdminOrderManagementApp extends StatelessWidget {
  const AdminOrderManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CanteenGo Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F6F6),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC6102E)),
        fontFamily: 'sans-serif',
      ),
      home: const AdminOrderManagementScreen(),
    );
  }
}

// ─── Constants ───────────────────────────────────────────────────────────────

const Color kPrimary = Color(0xFFC6102E);
const Color kSecondary = Color(0xFFFFC72C);
const Color kBackground = Color(0xFFF8F6F6);

// ─── Models ──────────────────────────────────────────────────────────────────

enum OrderStatus { pending, preparing, ready }

class LiveOrder {
  final String orderId;
  final String studentName;
  final String initials;
  final String items;
  final double totalPrice;
  OrderStatus status;

  LiveOrder({
    required this.orderId,
    required this.studentName,
    required this.initials,
    required this.items,
    required this.totalPrice,
    required this.status,
  });
}

// ─── Admin Order Management Screen ───────────────────────────────────────────

class AdminOrderManagementScreen extends StatefulWidget {
  const AdminOrderManagementScreen({super.key});

  @override
  State<AdminOrderManagementScreen> createState() =>
      _AdminOrderManagementScreenState();
}

class _AdminOrderManagementScreenState
    extends State<AdminOrderManagementScreen> {
  int _selectedNavIndex = 1; // Orders active

  final List<LiveOrder> _orders = [
    LiveOrder(
      orderId: '#ORD-9024',
      studentName: 'Alex Johnson',
      initials: 'AJ',
      items: '2x Burger, 1x Coke Zero',
      totalPrice: 15.50,
      status: OrderStatus.pending,
    ),
    LiveOrder(
      orderId: '#ORD-9023',
      studentName: 'Maria Garcia',
      initials: 'MG',
      items: '1x Pasta, 1x Garlic Bread',
      totalPrice: 12.00,
      status: OrderStatus.preparing,
    ),
    LiveOrder(
      orderId: '#ORD-9022',
      studentName: 'Liam Smith',
      initials: 'LS',
      items: '3x Tacos, 1x Sprite',
      totalPrice: 18.75,
      status: OrderStatus.ready,
    ),
    LiveOrder(
      orderId: '#ORD-9021',
      studentName: 'Jenny Wang',
      initials: 'JW',
      items: '1x Caesar Salad',
      totalPrice: 9.50,
      status: OrderStatus.pending,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Row(
        children: [
          // ── Side Navigation ──
          _buildSidebar(),
          // ── Main Content ──
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
                        _buildStatsRow(),
                        const SizedBox(height: 32),
                        _buildLiveOrdersTable(),
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
    final navItems = [
      _SideNavItem(icon: Icons.dashboard_outlined, label: 'Dashboard'),
      _SideNavItem(icon: Icons.receipt_long, label: 'Orders'),
      _SideNavItem(icon: Icons.menu_book_outlined, label: 'Menu'),
      _SideNavItem(icon: Icons.group_outlined, label: 'Students'),
      _SideNavItem(icon: Icons.analytics_outlined, label: 'Analytics'),
    ];

    return Container(
      width: 272,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Column(
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: kPrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.restaurant,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CanteenGo',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: kPrimary,
                        letterSpacing: -0.3,
                      ),
                    ),
                    Text(
                      'Admin Portal',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Nav items
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: List.generate(navItems.length, (index) {
                  final item = navItems[index];
                  final isActive = index == _selectedNavIndex;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedNavIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isActive ? kPrimary : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: isActive
                            ? [
                                BoxShadow(
                                  color: kPrimary.withValues(alpha: 0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : null,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item.icon,
                            size: 22,
                            color: isActive
                                ? Colors.white
                                : const Color(0xFF64748B),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isActive
                                  ? Colors.white
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

          // Admin profile footer
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                ClipOval(
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAg6aqUgAMtpIRB87Dn7ucEF9D2kR5wrS2dhHU_Lks5wU6PVh3r-7t4_p8UW7LVSgFQpIBCeDVyER086MPa3c8P8FQ0m4pdYOSCefd1qbuLEXVk74B2IxcMVWhERbD8zY-GNuaVTIvy0WF4lcfoeY4gZojM_A85ufwO6aVwV-Ea22L8PSaJfAszDD6Fka7gqUpfsTBOu359Zb37k7pNirr72iq8UP5zzsUuahoaPX1YOmPO6hp97rvWcUOpeeiW-u0vOY_fTYpTZORj',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      width: 40,
                      height: 40,
                      color: Colors.grey[300],
                      child: const Icon(Icons.person, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'James Wilson',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Canteen Manager',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF64748B),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.settings_outlined,
                  color: Color(0xFF94A3B8),
                  size: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Top Bar ───────────────────────────────────────────────────────────────

  Widget _buildTopBar() {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          const Text(
            'Order Management',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const Spacer(),
          // Search
          Container(
            width: 240,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: const [
                SizedBox(width: 12),
                Icon(Icons.search, color: Color(0xFF94A3B8), size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search orders...',
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
          const SizedBox(width: 16),
          // Notification bell
          Stack(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.notifications_outlined,
                  color: Color(0xFF475569),
                  size: 20,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: kPrimary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          // Calendar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.calendar_today_outlined,
              color: Color(0xFF475569),
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  // ── Stats Row ─────────────────────────────────────────────────────────────

  Widget _buildStatsRow() {
    return Row(
      children: [
        // Total Orders Today
        Expanded(
          child: _StatCard(
            iconBg: kPrimary.withValues(alpha: 0.1),
            icon: Icons.shopping_cart_outlined,
            iconColor: kPrimary,
            badge: '+12%',
            badgeColor: const Color(0xFF16A34A),
            label: 'Total Orders Today',
            value: '128',
          ),
        ),
        const SizedBox(width: 20),
        // Revenue Today — highlighted
        Expanded(child: _RevenueHighlightCard()),
        const SizedBox(width: 20),
        // Pending Orders
        Expanded(
          child: _StatCard(
            iconBg: const Color(0xFFDBEAFE),
            icon: Icons.pending_actions_outlined,
            iconColor: const Color(0xFF2563EB),
            badge: 'Needs Action',
            badgeColor: const Color(0xFFF59E0B),
            label: 'Pending Orders',
            value: '12',
          ),
        ),
        const SizedBox(width: 20),
        // Peak Hour Analytics
        Expanded(
          child: _StatCard(
            iconBg: const Color(0xFFF3E8FF),
            icon: Icons.shutter_speed,
            iconColor: const Color(0xFF9333EA),
            badge: 'Expected soon',
            badgeColor: const Color(0xFF94A3B8),
            label: 'Peak Hour Analytics',
            value: '12:30 PM - 1:15 PM',
            smallValue: true,
          ),
        ),
      ],
    );
  }

  // ── Live Orders Table ─────────────────────────────────────────────────────

  Widget _buildLiveOrdersTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Table header row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: Row(
              children: [
                const Text(
                  'Live Orders',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFF22C55E),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'Live Updating',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          // Column headers
          Container(
            color: const Color(0xFFF8FAFC),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: const Row(
              children: [
                SizedBox(width: 110, child: _ColHeader('ORDER ID')),
                SizedBox(width: 180, child: _ColHeader('STUDENT NAME')),
                Expanded(child: _ColHeader('ITEMS')),
                SizedBox(width: 100, child: _ColHeader('TOTAL PRICE')),
                SizedBox(width: 140, child: _ColHeader('STATUS')),
                SizedBox(
                  width: 130,
                  child: _ColHeader('ACTION', align: TextAlign.right),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          // Order rows
          ...List.generate(_orders.length, (i) {
            return Column(
              children: [
                _OrderRow(
                  order: _orders[i],
                  onStatusChanged: (newStatus) =>
                      setState(() => _orders[i].status = newStatus),
                ),
                if (i < _orders.length - 1)
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
              ],
            );
          }),

          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          // Pagination footer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            child: Row(
              children: [
                const Text(
                  'Showing 4 of 12 pending orders',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                // Prev
                _PaginationButton(
                  child: const Icon(
                    Icons.chevron_left,
                    size: 16,
                    color: Color(0xFF94A3B8),
                  ),
                  onTap: () {},
                ),
                const SizedBox(width: 6),
                // Page 1 active
                _PaginationButton(
                  active: true,
                  child: const Text(
                    '1',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {},
                ),
                const SizedBox(width: 6),
                // Page 2
                _PaginationButton(
                  child: const Text(
                    '2',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF475569),
                    ),
                  ),
                  onTap: () {},
                ),
                const SizedBox(width: 6),
                // Next
                _PaginationButton(
                  child: const Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: Color(0xFF94A3B8),
                  ),
                  onTap: () {},
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
  final Color badgeColor;
  final String label;
  final String value;
  final bool smallValue;

  const _StatCard({
    required this.iconBg,
    required this.icon,
    required this.iconColor,
    required this.badge,
    required this.badgeColor,
    required this.label,
    required this.value,
    this.smallValue = false,
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
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6),
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
              Text(
                badge,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: badgeColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
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
            style: TextStyle(
              fontSize: smallValue ? 18 : 28,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Revenue Highlight Card ───────────────────────────────────────────────────

class _RevenueHighlightCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kSecondary, width: 2),
        boxShadow: [
          BoxShadow(
            color: kSecondary.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: kSecondary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.payments_outlined,
                      color: Color(0xFFB45309),
                      size: 20,
                    ),
                  ),
                  const Text(
                    '+5.2%',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF16A34A),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Text(
                'Revenue Today',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '\$1,450.00',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          // Highlight badge top-right
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: const BoxDecoration(
                color: kSecondary,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
              ),
              child: const Text(
                'HIGHLIGHT',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E293B),
                  letterSpacing: 1,
                ),
              ),
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
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: Color(0xFF64748B),
        letterSpacing: 0.8,
      ),
    );
  }
}

// ─── Order Row ────────────────────────────────────────────────────────────────

class _OrderRow extends StatelessWidget {
  final LiveOrder order;
  final ValueChanged<OrderStatus> onStatusChanged;

  const _OrderRow({required this.order, required this.onStatusChanged});

  Color get _statusBg {
    switch (order.status) {
      case OrderStatus.pending:
        return const Color(0xFFFFFBEB);
      case OrderStatus.preparing:
        return const Color(0xFFEFF6FF);
      case OrderStatus.ready:
        return const Color(0xFFF0FDF4);
    }
  }

  Color get _statusColor {
    switch (order.status) {
      case OrderStatus.pending:
        return const Color(0xFFB45309);
      case OrderStatus.preparing:
        return const Color(0xFF1D4ED8);
      case OrderStatus.ready:
        return const Color(0xFF15803D);
    }
  }

  /* String get _statusLabel {
    switch (order.status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.ready:
        return 'Ready';
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Row(
        children: [
          // Order ID
          SizedBox(
            width: 110,
            child: Text(
              order.orderId,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: kPrimary,
              ),
            ),
          ),

          // Student Name
          SizedBox(
            width: 180,
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      order.initials,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF334155),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    order.studentName,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF0F172A),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // Items
          Expanded(
            child: Text(
              order.items,
              style: const TextStyle(fontSize: 13, color: Color(0xFF475569)),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Total Price
          SizedBox(
            width: 100,
            child: Text(
              '\$${order.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
          ),

          // Status dropdown
          SizedBox(
            width: 140,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _statusBg,
                borderRadius: BorderRadius.circular(999),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<OrderStatus>(
                  value: order.status,
                  isDense: true,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: 16,
                    color: _statusColor,
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: _statusColor,
                  ),
                  onChanged: (val) {
                    if (val != null) onStatusChanged(val);
                  },
                  items: OrderStatus.values
                      .map(
                        (s) => DropdownMenuItem(
                          value: s,
                          child: Text(
                            s.name[0].toUpperCase() + s.name.substring(1),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),

          // Action button
          SizedBox(
            width: 130,
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimary,
                  foregroundColor: Colors.white,
                  elevation: 1,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Update Status',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Pagination Button ────────────────────────────────────────────────────────

class _PaginationButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final bool active;

  const _PaginationButton({
    required this.child,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: active ? kPrimary : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: active ? kPrimary : const Color(0xFFE2E8F0),
          ),
        ),
        child: Center(child: child),
      ),
    );
  }
}

// ─── Side Nav Item Model ──────────────────────────────────────────────────────

class _SideNavItem {
  final IconData icon;
  final String label;
  const _SideNavItem({required this.icon, required this.label});
}
