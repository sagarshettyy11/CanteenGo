import 'package:flutter/material.dart';

void main() {
  runApp(const CanteenGoOrderStatusApp());
}

class CanteenGoOrderStatusApp extends StatelessWidget {
  const CanteenGoOrderStatusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CanteenGo - Order Status',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Public Sans',
        scaffoldBackgroundColor: const Color(0xFFF8F6F6),
      ),
      home: const OrderStatusScreen(),
    );
  }
}

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({super.key});

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  static const Color _primary = Color(0xFFEC5B13);
  static const Color _success = Color(0xFF28A745);
  static const Color _bgLight = Color(0xFFF8F6F6);

  int _selectedNavIndex = 1; // Orders tab active

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        _buildOrderProgressSection(),
                        const SizedBox(height: 4),
                        _buildQRSection(),
                        const SizedBox(height: 4),
                        _buildBillSummarySection(),
                        _buildDownloadButton(),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
          ],
        ),
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: _bgLight.withValues(alpha: 0.9),
        border: Border(
          bottom: BorderSide(color: _primary.withValues(alpha: 0.1)),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
            style: IconButton.styleFrom(shape: const CircleBorder()),
          ),
          const Expanded(
            child: Text(
              'Order Status',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share_outlined, color: Color(0xFF0F172A)),
            style: IconButton.styleFrom(shape: const CircleBorder()),
          ),
        ],
      ),
    );
  }

  // ── Order Progress ───────────────────────────────────────────────────────────

  Widget _buildOrderProgressSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _primary.withValues(alpha: 0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Order ID + Est. Pickup
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ORDER ID',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      '#CG-88291',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'EST. PICKUP',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      '12:45 PM',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: _primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Step 1: Confirmed
            _buildStep(
              iconWidget: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: _success,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 16),
              ),
              lineColor: _success,
              showLine: true,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order Confirmed',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: _success,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Received at 12:30 PM',
                    style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),

            // Step 2: Preparing
            _buildStep(
              iconWidget: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: _primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.outdoor_grill,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              lineColor: const Color(0xFFE2E8F0),
              showLine: true,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Preparing Your Meal',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'The chef is working on it',
                    style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 10),
                  // Progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: SizedBox(
                      width: 192,
                      height: 8,
                      child: LinearProgressIndicator(
                        value: 0.65,
                        backgroundColor: const Color(0xFFF1F5F9),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          _primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Step 3: Ready for Pickup
            _buildStep(
              iconWidget: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.grey[400],
                  size: 16,
                ),
              ),
              lineColor: Colors.transparent,
              showLine: false,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ready for Pickup',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Waiting to be packed',
                    style: TextStyle(fontSize: 13, color: Colors.grey[400]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep({
    required Widget iconWidget,
    required Color lineColor,
    required bool showLine,
    required Widget content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon + vertical line
        SizedBox(
          width: 32,
          child: Column(
            children: [
              iconWidget,
              if (showLine) Container(width: 2, height: 60, color: lineColor),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 4, bottom: showLine ? 0 : 0),
            child: content,
          ),
        ),
      ],
    );
  }

  // ── QR Section ───────────────────────────────────────────────────────────────

  Widget _buildQRSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: _primary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _primary.withValues(alpha: 0.3),
            width: 2,
            // dashed effect approximated via decoration
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          children: [
            // QR placeholder
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: 160,
                height: 160,
                child: CustomPaint(painter: _QRPlaceholderPainter()),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Pickup Verification',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Show this QR code at the counter when your order status is "Ready"',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  // ── Bill Summary ─────────────────────────────────────────────────────────────

  Widget _buildBillSummarySection() {
    final items = [
      _BillItem(
        emoji: '🍔',
        name: 'Classic Zinger Burger',
        qty: 1,
        price: '\$8.50',
      ),
      _BillItem(
        emoji: '🍟',
        name: 'Peri Peri Fries (Large)',
        qty: 1,
        price: '\$4.25',
      ),
      _BillItem(emoji: '🥤', name: 'Iced Lemon Tea', qty: 1, price: '\$3.50'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _primary.withValues(alpha: 0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Row(
              children: [
                const Icon(Icons.receipt_long, color: _primary, size: 22),
                const SizedBox(width: 8),
                const Text(
                  'Bill Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Items
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          item.emoji,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            'Qty: ${item.qty}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      item.price,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Divider + totals
            const Divider(color: Color(0xFFF1F5F9), height: 1),
            const SizedBox(height: 12),
            _buildTotalRow('Subtotal', '\$16.25', isSmall: true),
            const SizedBox(height: 8),
            _buildTotalRow('Tax (5%)', '\$0.81', isSmall: true),
            const SizedBox(height: 8),
            _buildTotalRow('Total Amount', '\$17.06', isTotal: true),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.verified_user_outlined,
                  size: 14,
                  color: Colors.grey[400],
                ),
                const SizedBox(width: 4),
                Text(
                  'Paid via CanteenGo Wallet',
                  style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRow(
    String label,
    String value, {
    bool isSmall = false,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 17 : 13,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
            color: isTotal ? const Color(0xFF0F172A) : Colors.grey[500],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 17 : 13,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
            color: isTotal ? _primary : Colors.grey[500],
          ),
        ),
      ],
    );
  }

  // ── Download Button ──────────────────────────────────────────────────────────

  Widget _buildDownloadButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: _primary,
            side: BorderSide(color: _primary.withValues(alpha: 0.2)),
            backgroundColor: _primary.withValues(alpha: 0.05),
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Download PDF Invoice',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  // ── Bottom Navigation ────────────────────────────────────────────────────────

  Widget _buildBottomNav() {
    final tabs = [
      _NavTab(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
      _NavTab(
        icon: Icons.receipt_outlined,
        activeIcon: Icons.receipt,
        label: 'Orders',
      ),
      _NavTab(
        icon: Icons.account_balance_wallet_outlined,
        activeIcon: Icons.account_balance_wallet,
        label: 'Wallet',
      ),
      _NavTab(
        icon: Icons.person_outline,
        activeIcon: Icons.person,
        label: 'Profile',
      ),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(tabs.length, (index) {
          final selected = _selectedNavIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedNavIndex = index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  selected ? tabs[index].activeIcon : tabs[index].icon,
                  color: selected ? _primary : Colors.grey[400],
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  tabs[index].label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: selected ? _primary : Colors.grey[400],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// ── QR Placeholder Painter ────────────────────────────────────────────────────

class _QRPlaceholderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1A1A1A)
      ..style = PaintingStyle.fill;

    final cellSize = size.width / 21;

    // Simplified QR-like pattern
    final pattern = [
      // Top-left finder
      for (int r = 0; r < 7; r++)
        for (int c = 0; c < 7; c++)
          if (r == 0 ||
              r == 6 ||
              c == 0 ||
              c == 6 ||
              (r >= 2 && r <= 4 && c >= 2 && c <= 4))
            Offset(c.toDouble(), r.toDouble()),
      // Top-right finder
      for (int r = 0; r < 7; r++)
        for (int c = 14; c < 21; c++)
          if (r == 0 ||
              r == 6 ||
              c == 14 ||
              c == 20 ||
              (r >= 2 && r <= 4 && c >= 16 && c <= 18))
            Offset(c.toDouble(), r.toDouble()),
      // Bottom-left finder
      for (int r = 14; r < 21; r++)
        for (int c = 0; c < 7; c++)
          if (r == 14 ||
              r == 20 ||
              c == 0 ||
              c == 6 ||
              (r >= 16 && r <= 18 && c >= 2 && c <= 4))
            Offset(c.toDouble(), r.toDouble()),
      // Scattered data cells
      for (int i = 8; i < 13; i++) ...[
        Offset(i.toDouble(), 8),
        Offset(8, i.toDouble()),
        Offset(i.toDouble(), 12),
        Offset(12, i.toDouble()),
        Offset(i.toDouble(), 10),
      ],
      for (int i = 9; i < 20; i += 2) Offset(i.toDouble(), 16),
      for (int i = 9; i < 20; i += 3) Offset(15, i.toDouble()),
    ];

    for (final cell in pattern) {
      canvas.drawRect(
        Rect.fromLTWH(
          cell.dx * cellSize,
          cell.dy * cellSize,
          cellSize - 1,
          cellSize - 1,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Data Models ───────────────────────────────────────────────────────────────

class _BillItem {
  final String emoji;
  final String name;
  final int qty;
  final String price;

  _BillItem({
    required this.emoji,
    required this.name,
    required this.qty,
    required this.price,
  });
}

class _NavTab {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  _NavTab({required this.icon, required this.activeIcon, required this.label});
}
