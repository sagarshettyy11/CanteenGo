import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const AdminAnalyticsApp());
}

class AdminAnalyticsApp extends StatelessWidget {
  const AdminAnalyticsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CanteenGo Analytics',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F6F6),
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimary),
        fontFamily: 'sans-serif',
      ),
      home: const AdminAnalyticsScreen(),
    );
  }
}

// ─── Constants ───────────────────────────────────────────────────────────────

const Color kPrimary = Color(0xFFC6102E);
const Color kHighlight = Color(0xFFFFC72C);
const Color kBackground = Color(0xFFF8F6F6);

// ─── Models ──────────────────────────────────────────────────────────────────

class PopularItem {
  final String name;
  final String orders;
  final double fraction;
  final Color barColor;

  const PopularItem({
    required this.name,
    required this.orders,
    required this.fraction,
    required this.barColor,
  });
}

class Transaction {
  final String id;
  final String user;
  final String items;
  final String amount;
  final bool completed;

  const Transaction({
    required this.id,
    required this.user,
    required this.items,
    required this.amount,
    required this.completed,
  });
}

// ─── Static Data ─────────────────────────────────────────────────────────────

const List<PopularItem> kPopularItems = [
  PopularItem(
      name: 'Spicy Chicken Bowl',
      orders: '2,401 orders',
      fraction: 0.92,
      barColor: kPrimary),
  PopularItem(
      name: 'Veggie Buddha Salad',
      orders: '1,850 orders',
      fraction: 0.75,
      barColor: kPrimary),
  PopularItem(
      name: 'Iced Matcha Latte',
      orders: '1,240 orders',
      fraction: 0.55,
      barColor: kHighlight),
  PopularItem(
      name: 'Double Cheese Burger',
      orders: '980 orders',
      fraction: 0.42,
      barColor: kPrimary),
];

// hour, height fraction, isPeak, isHighlight
const List<Map<String, dynamic>> kHourBars = [
  {'label': '08:00', 'height': 0.20, 'peak': false, 'yellow': false},
  {'label': '10:00', 'height': 0.35, 'peak': false, 'yellow': false},
  {'label': '12:00', 'height': 0.95, 'peak': true, 'yellow': false},
  {'label': '14:00', 'height': 0.85, 'peak': true, 'yellow': false},
  {'label': '16:00', 'height': 0.40, 'peak': false, 'yellow': false},
  {'label': '18:00', 'height': 0.70, 'peak': false, 'yellow': true},
  {'label': '20:00', 'height': 0.25, 'peak': false, 'yellow': false},
];

const List<Transaction> kTransactions = [
  Transaction(
    id: '#TXN-88219',
    user: 'Sarah Jenkins',
    items: 'Chicken Bowl, Iced Tea',
    amount: r'$24.50',
    completed: true,
  ),
  Transaction(
    id: '#TXN-88218',
    user: 'Mark Thompson',
    items: 'Veggie Salad',
    amount: r'$12.00',
    completed: true,
  ),
  Transaction(
    id: '#TXN-88217',
    user: 'Elena Rodriguez',
    items: 'Espresso, Muffin',
    amount: r'$8.75',
    completed: false,
  ),
];

// Monthly revenue curve points (normalized 0–1 x,y for drawing)
final List<Offset> kRevenueCurve = [
  const Offset(0.00, 0.75),
  const Offset(0.10, 0.78),
  const Offset(0.20, 0.60),
  const Offset(0.30, 0.70),
  const Offset(0.40, 0.45),
  const Offset(0.50, 0.20),
  const Offset(0.60, 0.35),
  const Offset(0.70, 0.15),
  const Offset(0.80, 0.30),
  const Offset(0.90, 0.10),
  const Offset(1.00, 0.05),
];

final List<Offset> kTargetLine = [
  const Offset(0.00, 0.90),
  const Offset(1.00, 0.35),
];

// ─── Screen ───────────────────────────────────────────────────────────────────

class AdminAnalyticsScreen extends StatefulWidget {
  const AdminAnalyticsScreen({super.key});

  @override
  State<AdminAnalyticsScreen> createState() => _AdminAnalyticsScreenState();
}

class _AdminAnalyticsScreenState extends State<AdminAnalyticsScreen> {
  int _navIndex = 1; // Analytics active

  final _navItems = const [
    _NavItem(icon: Icons.dashboard_outlined, label: 'Dashboard'),
    _NavItem(icon: Icons.insights_outlined, label: 'Analytics'),
    _NavItem(icon: Icons.receipt_long_outlined, label: 'Orders'),
    _NavItem(icon: Icons.restaurant_outlined, label: 'Menu Management'),
    _NavItem(icon: Icons.group_outlined, label: 'Users'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Column(
        children: [
          _buildTopBar(),
          Expanded(
            child: Row(
              children: [
                _buildSidebar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPageHeader(),
                        const SizedBox(height: 28),
                        _buildMetricCards(),
                        const SizedBox(height: 28),
                        _buildChartsRow(),
                        const SizedBox(height: 28),
                        _buildBottomRow(),
                        const SizedBox(height: 28),
                        _buildTransactionsTable(),
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

  // ── Top Bar ───────────────────────────────────────────────────────────────

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        border: Border(
            bottom: BorderSide(color: kPrimary.withValues(alpha: 0.1))),
      ),
      child: Row(
        children: [
          // Logo
          Row(
            children: [
              Icon(Icons.close, color: kPrimary, size: 26),
              const SizedBox(width: 8),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                  children: [
                    TextSpan(text: 'CanteenGo '),
                    TextSpan(
                        text: 'Admin',
                        style: TextStyle(color: kPrimary)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 32),

          // Search bar
          Container(
            width: 280,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              children: const [
                SizedBox(width: 12),
                Icon(Icons.search, size: 16, color: Color(0xFF94A3B8)),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search analytics, orders, users...',
                      hintStyle: TextStyle(
                          fontSize: 12, color: Color(0xFF94A3B8)),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // Notification
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.notifications_outlined,
                size: 20, color: Color(0xFF334155)),
          ),
          const SizedBox(width: 10),

          // Settings
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.settings_outlined,
                size: 20, color: Color(0xFF334155)),
          ),

          Container(
            width: 1,
            height: 32,
            color: const Color(0xFFE2E8F0),
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),

          // User info
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Alex Rivera',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              Text(
                'Fleet Manager',
                style: TextStyle(
                    fontSize: 11, color: Color(0xFF64748B)),
              ),
            ],
          ),
          const SizedBox(width: 10),

          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: kPrimary,
              shape: BoxShape.circle,
              border:
                  Border.all(color: kHighlight, width: 2),
            ),
            child: const Center(
              child: Text(
                'AR',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Sidebar ───────────────────────────────────────────────────────────────

  Widget _buildSidebar() {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            right: BorderSide(color: kPrimary.withValues(alpha: 0.05))),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),

          // Nav items
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  ...List.generate(_navItems.length, (i) {
                    final item = _navItems[i];
                    final isActive = i == _navIndex;
                    return GestureDetector(
                      onTap: () =>
                          setState(() => _navIndex = i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        margin: const EdgeInsets.only(bottom: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: isActive
                              ? kPrimary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: isActive
                              ? [
                                  BoxShadow(
                                    color: kPrimary.withValues(alpha: 0.25),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  )
                                ]
                              : null,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              item.icon,
                              size: 20,
                              color: isActive
                                  ? Colors.white
                                  : const Color(0xFF64748B),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              item.label,
                              style: TextStyle(
                                fontSize: 13,
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
                  const SizedBox(height: 40),
                  // Sign Out
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.logout_outlined,
                              size: 20,
                              color: Color(0xFF64748B)),
                          SizedBox(width: 12),
                          Text(
                            'Sign Out',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Pro Tip card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: kHighlight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: kHighlight.withValues(alpha: 0.25)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PRO TIP',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1E293B),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Exported CSVs now include breakdown by payment method.',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF475569),
                    height: 1.4,
                  ),
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
                'Analytics & Reports',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Real-time performance monitoring for Central Canteen Hub',
                style: TextStyle(
                    fontSize: 13, color: Color(0xFF64748B)),
              ),
            ],
          ),
        ),
        Row(
          children: [
            // Last 30 Days
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                children: const [
                  Icon(Icons.calendar_today_outlined,
                      size: 16, color: Color(0xFF334155)),
                  SizedBox(width: 8),
                  Text(
                    'Last 30 Days',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Export Report
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.file_download_outlined,
                  size: 16),
              label: const Text(
                'Export Report',
                style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w700),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 18, vertical: 11),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
                elevation: 6,
                shadowColor: kPrimary.withValues(alpha: 0.35),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Metric Cards ──────────────────────────────────────────────────────────

  Widget _buildMetricCards() {
    final cards = [
      _MetricData(
        icon: Icons.payments_outlined,
        iconBg: kPrimary.withValues(alpha: 0.1),
        iconColor: kPrimary,
        badge: '+12.4%',
        badgeColor: const Color(0xFF10B981),
        badgeBg: const Color(0xFF10B981).withValues(alpha: 0.1),
        label: 'Total Revenue',
        value: r'$42,950.40',
      ),
      _MetricData(
        icon: Icons.shopping_cart_outlined,
        iconBg: kHighlight.withValues(alpha: 0.12),
        iconColor: kHighlight,
        badge: '+5.1%',
        badgeColor: const Color(0xFF10B981),
        badgeBg: const Color(0xFF10B981).withValues(alpha: 0.1),
        label: 'Orders Today',
        value: '1,284',
      ),
      _MetricData(
        icon: Icons.monetization_on_outlined,
        iconBg: kPrimary.withValues(alpha: 0.1),
        iconColor: kPrimary,
        badge: '+2.3%',
        badgeColor: const Color(0xFF10B981),
        badgeBg: const Color(0xFF10B981).withValues(alpha: 0.1),
        label: 'Average Order Value',
        value: r'$18.25',
      ),
      _MetricData(
        icon: Icons.trending_up,
        iconBg: kHighlight.withValues(alpha: 0.12),
        iconColor: kHighlight,
        badge: '+18.2%',
        badgeColor: kPrimary,
        badgeBg: kPrimary.withValues(alpha: 0.1),
        label: 'User Growth',
        value: '24,502',
      ),
    ];

    return Row(
      children: cards
          .map(
            (d) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    right: cards.indexOf(d) < cards.length - 1 ? 16 : 0),
                child: _MetricCard(data: d),
              ),
            ),
          )
          .toList(),
    );
  }

  // ── Charts Row ────────────────────────────────────────────────────────────

  Widget _buildChartsRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Monthly Revenue Trend (line chart)
        Expanded(
          child: _ChartCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Monthly Revenue Trend',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            'Gross revenue vs operating costs',
                            style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                    // Legend
                    Row(
                      children: [
                        Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                                color: kPrimary,
                                shape: BoxShape.circle)),
                        const SizedBox(width: 4),
                        const Text('Revenue',
                            style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF64748B))),
                        const SizedBox(width: 12),
                        Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                                color: kHighlight,
                                shape: BoxShape.circle)),
                        const SizedBox(width: 4),
                        const Text('Target',
                            style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF64748B))),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  child: CustomPaint(
                    painter: _RevenueChartPainter(),
                    size: Size.infinite,
                  ),
                ),
                const SizedBox(height: 12),
                // X-axis labels
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL'
                  ]
                      .map((m) => Text(
                            m,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF94A3B8),
                              letterSpacing: 0.5,
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 24),
        // Most Popular Items
        Expanded(
          child: _ChartCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Most Popular Items',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            'Based on volume of orders',
                            style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.more_vert,
                        color: Color(0xFF94A3B8), size: 20),
                  ],
                ),
                const SizedBox(height: 24),
                ...kPopularItems.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              Text(
                                item.orders,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: kPrimary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: LinearProgressIndicator(
                              value: item.fraction,
                              backgroundColor:
                                  const Color(0xFFF1F5F9),
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(
                                      item.barColor),
                              minHeight: 10,
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Bottom Row ────────────────────────────────────────────────────────────

  Widget _buildBottomRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Peak Ordering Hours bar chart
        Expanded(
          flex: 2,
          child: _ChartCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Peak Ordering Hours',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: kHighlight.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        'HIGH TRAFFIC ALERT',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: kHighlight,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 180,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: kHourBars.map((bar) {
                      final isPeak = bar['peak'] as bool;
                      final isYellow = bar['yellow'] as bool;
                      final heightFraction =
                          bar['height'] as double;
                      Color barColor;
                      if (isYellow) {
                        barColor = kHighlight;
                      } else if (isPeak) {
                        barColor = kPrimary;
                      } else {
                        barColor = kPrimary.withValues(alpha: 0.12);
                      }

                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4),
                          child: Column(
                            mainAxisAlignment:
                                MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.end,
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(
                                          milliseconds: 400),
                                      width: double.infinity,
                                      height: 160 * heightFraction,
                                      decoration: BoxDecoration(
                                        color: barColor,
                                        borderRadius:
                                            const BorderRadius
                                                .vertical(
                                          top: Radius.circular(6),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                bar['label'] as String,
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: isPeak
                                      ? const Color(0xFF0F172A)
                                      : const Color(0xFF94A3B8),
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 24),
        // Daily Insight card
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: kPrimary,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: kPrimary.withValues(alpha: 0.45),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.bolt, color: kHighlight, size: 22),
                    SizedBox(width: 8),
                    Text(
                      'Daily Insight',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xCCFFFFFF),
                      height: 1.6,
                    ),
                    children: [
                      TextSpan(
                          text:
                              "Lunch rush started 15 minutes earlier today. Recommend increasing prep staff for tomorrow's "),
                      TextSpan(
                        text: '11:45 AM',
                        style: TextStyle(
                          color: kHighlight,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(text: ' slot.'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Efficiency Score box
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Colors.white.withValues(alpha: 0.12)),
                  ),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Efficiency Score',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '94%',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: kHighlight,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: 0.94,
                          backgroundColor:
                              Colors.white.withValues(alpha: 0.2),
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(
                                  kHighlight),
                          minHeight: 6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Transactions Table ────────────────────────────────────────────────────

  Widget _buildTransactionsTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kPrimary.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.03), blurRadius: 8),
        ],
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding:
                const EdgeInsets.fromLTRB(24, 18, 24, 18),
            child: Row(
              children: [
                const Text(
                  'Recent Transactions',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: kPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Column headers
          Container(
            color: const Color(0xFFF8FAFC),
            padding: const EdgeInsets.symmetric(
                horizontal: 24, vertical: 10),
            child: const Row(
              children: [
                SizedBox(
                    width: 160,
                    child: _ColHdr('TRANSACTION ID')),
                SizedBox(
                    width: 160, child: _ColHdr('USER')),
                Expanded(child: _ColHdr('ITEMS')),
                SizedBox(
                    width: 110, child: _ColHdr('AMOUNT')),
                SizedBox(
                    width: 110, child: _ColHdr('STATUS')),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Rows
          ...kTransactions.map((tx) => _TxRow(tx: tx)),
        ],
      ),
    );
  }
}

// ─── Metric Card ─────────────────────────────────────────────────────────────

class _MetricData {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String badge;
  final Color badgeColor;
  final Color badgeBg;
  final String label;
  final String value;

  const _MetricData({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.badge,
    required this.badgeColor,
    required this.badgeBg,
    required this.label,
    required this.value,
  });
}

class _MetricCard extends StatelessWidget {
  final _MetricData data;
  const _MetricCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kPrimary.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6),
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
                  color: data.iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(data.icon,
                    color: data.iconColor, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: data.badgeBg,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  data.badge,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: data.badgeColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            data.label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            data.value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Chart Card Wrapper ───────────────────────────────────────────────────────

class _ChartCard extends StatelessWidget {
  final Widget child;
  const _ChartCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kPrimary.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.03), blurRadius: 6),
        ],
      ),
      child: child,
    );
  }
}

// ─── Revenue Line Chart Painter ───────────────────────────────────────────────

class _RevenueChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Gradient fill under revenue line
    final fillPath = Path();
    final pts = kRevenueCurve;
    fillPath.moveTo(0, size.height);
    fillPath.lineTo(
        pts.first.dx * size.width, pts.first.dy * size.height);
    for (int i = 0; i < pts.length - 1; i++) {
      final cp1x = (pts[i].dx + pts[i + 1].dx) / 2 * size.width;
      final cp1y = pts[i].dy * size.height;
      final cp2x = cp1x;
      final cp2y = pts[i + 1].dy * size.height;
      fillPath.cubicTo(cp1x, cp1y, cp2x, cp2y,
          pts[i + 1].dx * size.width, pts[i + 1].dy * size.height);
    }
    fillPath.lineTo(size.width, size.height);
    fillPath.close();
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        kPrimary.withValues(alpha: 0.18),
        kPrimary.withValues(alpha: 0.0),
      ],
    );
    final fillPaint = Paint()
      ..shader = gradient.createShader(
          Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(fillPath, fillPaint);

    // Revenue line
    final linePaint = Paint()
      ..color = kPrimary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    final linePath = Path();
    linePath.moveTo(
        pts.first.dx * size.width, pts.first.dy * size.height);
    for (int i = 0; i < pts.length - 1; i++) {
      final cp1x = (pts[i].dx + pts[i + 1].dx) / 2 * size.width;
      final cp1y = pts[i].dy * size.height;
      final cp2x = cp1x;
      final cp2y = pts[i + 1].dy * size.height;
      linePath.cubicTo(cp1x, cp1y, cp2x, cp2y,
          pts[i + 1].dx * size.width, pts[i + 1].dy * size.height);
    }
    canvas.drawPath(linePath, linePaint);

    // Target dashed line
    final dashedPaint = Paint()
      ..color = kHighlight
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    final t0 = kTargetLine[0];
    final t1 = kTargetLine[1];
    _drawDashedLine(
      canvas,
      Offset(t0.dx * size.width, t0.dy * size.height),
      Offset(t1.dx * size.width, t1.dy * size.height),
      dashedPaint,
    );
  }

  void _drawDashedLine(
      Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashLen = 8.0;
    const gapLen = 5.0;
    final total = (end - start).distance;
    final dir = (end - start) / total;
    double drawn = 0;
    while (drawn < total) {
      final segEnd = min(drawn + dashLen, total);
      canvas.drawLine(start + dir * drawn, start + dir * segEnd, paint);
      drawn = segEnd + gapLen;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Transaction Row ──────────────────────────────────────────────────────────

class _TxRow extends StatelessWidget {
  final Transaction tx;
  const _TxRow({required this.tx});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 24, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 160,
            child: Text(
              tx.id,
              style: const TextStyle(
                fontSize: 13,
                fontFamily: 'monospace',
                color: Color(0xFF334155),
              ),
            ),
          ),
          SizedBox(
            width: 160,
            child: Text(
              tx.user,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          Expanded(
            child: Text(
              tx.items,
              style: const TextStyle(
                  fontSize: 13, color: Color(0xFF64748B)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 110,
            child: Text(
              tx.amount,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          SizedBox(
            width: 110,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: tx.completed
                    ? const Color(0xFF10B981).withValues(alpha: 0.1)
                    : kHighlight.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                tx.completed ? 'COMPLETED' : 'PENDING',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                  color: tx.completed
                      ? const Color(0xFF10B981)
                      : kHighlight,
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

class _ColHdr extends StatelessWidget {
  final String text;
  const _ColHdr(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: Color(0xFF94A3B8),
        letterSpacing: 0.8,
      ),
    );
  }
}

// ─── Nav Item ─────────────────────────────────────────────────────────────────

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}