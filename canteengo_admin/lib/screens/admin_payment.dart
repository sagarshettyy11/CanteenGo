import 'package:flutter/material.dart';

class AdminPaymentMenuApp extends StatelessWidget {
  const AdminPaymentMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CanteenGo Admin - Payment & Menu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F6F6),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC6102E)),
        fontFamily: 'sans-serif',
      ),
      home: const AdminPaymentMenuScreen(),
    );
  }
}

// ─── Constants ───────────────────────────────────────────────────────────────

const Color kPrimary = Color(0xFFC6102E);
const Color kSecondary = Color(0xFFFFC72C);
const Color kBackground = Color(0xFFF8F6F6);

// ─── Models ──────────────────────────────────────────────────────────────────

class Transaction {
  final String id;
  final String customer;
  final String amount;
  final String method;
  final bool success;

  const Transaction({
    required this.id,
    required this.customer,
    required this.amount,
    required this.method,
    required this.success,
  });
}

class MenuItem {
  final String name;
  final String price;
  final String description;
  final String imageUrl;
  final bool inStock;

  const MenuItem({
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.inStock,
  });
}

const List<Transaction> kTransactions = [
  Transaction(
    id: '#TXN-9082',
    customer: 'Aditya Sharma',
    amount: '₹240.00',
    method: 'UPI',
    success: true,
  ),
  Transaction(
    id: '#TXN-9081',
    customer: 'Riya Patel',
    amount: '₹185.00',
    method: 'CARD',
    success: true,
  ),
  Transaction(
    id: '#TXN-9080',
    customer: 'Vikram Singh',
    amount: '₹450.00',
    method: 'WALLET',
    success: false,
  ),
];

const List<MenuItem> kMenuItems = [
  MenuItem(
    name: 'Crispy Samosa Set',
    price: '₹40',
    description: 'Two pieces served with mint chutney and spicy imli dip.',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuA-qi6P43izmBO9BcbRJ1P-UZ-GmaVbddy9QVNI9iMSM8gyG4C1KbbRqC5b6CLrzzBJYefYCFHAEKyHvRqHbxZ22AlLB1ZmW0g8V9zqmFya6vT4wtKcoHrGCwolqtk0FimJ-8L4LdnNnLCzyRAwv7BYF15Ot0u1GDO0RUigBe6G7saqwsKOg_YyDUF32AvD34oRWqB_pdW1rHU0hi9wdq3oq5rTAlXqOHRkl9zzFhPr9xhSjXEh-IdJL1aakUe3B4qMZ_nUqQarLpoD',
    inStock: true,
  ),
  MenuItem(
    name: 'Classic Chicken Burger',
    price: '₹120',
    description:
        'Hand-breaded chicken breast with secret sauce and iceberg lettuce.',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuB58MBUtIrfq3D4OljKIawuE0E1CHlpM4TbGyY31xTW0SpwpjAmqlS3iSfiMqrUXScUch3D5Ly9EcbJk4ModnPmF8QtyIWz55qvG5pi4siy87O5VhLwkakZJc-frpw9BiZhlEadBa5uz4tQpmyiWL2M5qrzbNQ4KfCVLP6EsePvQQaBgNSqp3gLlO-WxjmN-RMggeV9rNshTtZZP68qDD3bSKxUhmERHJAs2gKECJeU-u4A-cxSuT5jTYCu5mKqLViU6AblCH1Hn88T',
    inStock: false,
  ),
  MenuItem(
    name: 'Creamy White Pasta',
    price: '₹150',
    description:
        'Penne pasta tossed in rich parmesan alfredo with mixed veggies.',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDED0LZBI7A13KEWMcwPsRi0kHn74nPkxVg_mdCFG-X2YlfI59te5Q8aULlV937yZJ0yZ8KDVx6BIeYJYcKsx4p-BHe4fweogyCNW6qDjTRhojH9AY-u1e7DP7OxWipvn3I6Q5MuoVUTNqapBDaHo8D4SL8oWglBuTVFbFR3tBQIcVrYVAFoNgJWCNovF7jDiy_82v7nC5s-Y_1p1nFG-wv62LsawTxnOyO5PBlnVAnAQrYzpqEd1t5CCjZQ-DKn9bESFbbMfjCamzx',
    inStock: true,
  ),
];

// ─── Main Screen ─────────────────────────────────────────────────────────────

class AdminPaymentMenuScreen extends StatefulWidget {
  const AdminPaymentMenuScreen({super.key});

  @override
  State<AdminPaymentMenuScreen> createState() => _AdminPaymentMenuScreenState();
}

class _AdminPaymentMenuScreenState extends State<AdminPaymentMenuScreen>
    with SingleTickerProviderStateMixin {
  int _selectedNavIndex = 1;
  late TabController _tabController;

  final _navItems = const [
    _NavItem(icon: Icons.dashboard_outlined, label: 'Dashboard'),
    _NavItem(icon: Icons.payments_outlined, label: 'Payments & Menu'),
    _NavItem(icon: Icons.shopping_cart_outlined, label: 'Live Orders'),
    _NavItem(icon: Icons.group_outlined, label: 'Customers'),
    _NavItem(icon: Icons.settings_outlined, label: 'Settings'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 32),
                  _buildStatsRow(),
                  const SizedBox(height: 32),
                  _buildTabs(),
                  const SizedBox(height: 24),
                  _buildPaymentSection(),
                  const SizedBox(height: 40),
                  _buildMenuCatalog(),
                ],
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
      width: 272,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Column(
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 28, 24, 16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: kPrimary,
                    borderRadius: BorderRadius.circular(8),
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
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: kPrimary,
                        letterSpacing: -0.3,
                      ),
                    ),
                    Text(
                      'Admin Central',
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

          const SizedBox(height: 8),

          // Nav items
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: List.generate(_navItems.length, (i) {
                  final item = _navItems[i];
                  final isActive = i == _selectedNavIndex;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedNavIndex = i),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 2),
                      decoration: BoxDecoration(
                        color: isActive
                            ? kPrimary.withValues(alpha: 0.08)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: isActive
                            ? const Border(
                                right: BorderSide(color: kPrimary, width: 3),
                              )
                            : null,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
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
                              fontSize: 13,
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

          // Footer
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: kSecondary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Main Canteen',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        'OPERATOR',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF64748B),
                          letterSpacing: 0.6,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.logout, size: 16, color: Color(0xFF94A3B8)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Operations Hub',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Manage your revenue flows and digital menu catalog.',
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
            'Add New Item',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 3,
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
            iconBg: const Color(0xFFDCFCE7),
            icon: Icons.trending_up,
            iconColor: const Color(0xFF16A34A),
            badge: '+14.2%',
            badgeColor: const Color(0xFF16A34A),
            label: 'Total Revenue',
            value: '₹1,42,580',
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _StatCard(
            iconBg: const Color(0xFFDBEAFE),
            icon: Icons.receipt_long_outlined,
            iconColor: const Color(0xFF2563EB),
            badge: '+28 today',
            badgeColor: const Color(0xFF2563EB),
            label: 'Total Orders',
            value: '842',
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _StatCard(
            iconBg: kSecondary.withValues(alpha: 0.2),
            icon: Icons.star_outlined,
            iconColor: const Color(0xFFB45309),
            badge: '4.8 Avg',
            badgeColor: const Color(0xFF94A3B8),
            label: 'Customer Satisfaction',
            value: '96%',
          ),
        ),
      ],
    );
  }

  // ── Tabs ──────────────────────────────────────────────────────────────────

  Widget _buildTabs() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        labelColor: kPrimary,
        unselectedLabelColor: const Color(0xFF64748B),
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        indicatorColor: kPrimary,
        indicatorWeight: 2,
        tabs: const [
          Tab(text: 'Payment Overview'),
          Tab(text: 'Menu Management'),
          Tab(text: 'Stock Control'),
        ],
      ),
    );
  }

  // ── Payment Section ───────────────────────────────────────────────────────

  Widget _buildPaymentSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Revenue Mix card
        SizedBox(width: 280, child: _buildRevenueMixCard()),
        const SizedBox(width: 24),
        // Recent Transactions
        Expanded(child: _buildTransactionsCard()),
      ],
    );
  }

  Widget _buildRevenueMixCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Revenue Mix',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 24),
          _RevenueMixRow(
            label: 'UPI Payments',
            percent: '65%',
            value: 0.65,
            color: kPrimary,
            dotColor: kPrimary,
          ),
          const SizedBox(height: 16),
          _RevenueMixRow(
            label: 'Card',
            percent: '25%',
            value: 0.25,
            color: kSecondary,
            dotColor: kSecondary,
          ),
          const SizedBox(height: 16),
          _RevenueMixRow(
            label: 'Wallets & Others',
            percent: '10%',
            value: 0.10,
            color: const Color(0xFF94A3B8),
            dotColor: const Color(0xFF94A3B8),
          ),
          const SizedBox(height: 24),
          const Divider(color: Color(0xFFF8FAFC), height: 1),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Most Used Method',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: kPrimary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'Google Pay',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: kPrimary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
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
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Column headers
          Container(
            color: const Color(0xFFF8FAFC),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: const Row(
              children: [
                SizedBox(width: 130, child: _TxColHeader('TRANSACTION ID')),
                SizedBox(width: 150, child: _TxColHeader('CUSTOMER')),
                SizedBox(width: 100, child: _TxColHeader('AMOUNT')),
                SizedBox(width: 100, child: _TxColHeader('METHOD')),
                Expanded(child: _TxColHeader('STATUS')),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Transaction rows
          ...kTransactions.map((tx) => _TransactionRow(transaction: tx)),
        ],
      ),
    );
  }

  // ── Menu Catalog ──────────────────────────────────────────────────────────

  Widget _buildMenuCatalog() {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Digital Menu Catalog',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0F172A),
                letterSpacing: -0.3,
              ),
            ),
            const Spacer(),
            _IconBtn(icon: Icons.filter_alt_outlined, onTap: () {}),
            const SizedBox(width: 8),
            _IconBtn(icon: Icons.sort, onTap: () {}),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...kMenuItems.map(
              (item) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: _MenuItemCard(item: item),
                ),
              ),
            ),
            // Add new placeholder
            Expanded(child: _AddMenuItemCard()),
          ],
        ),
      ],
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

  const _StatCard({
    required this.iconBg,
    required this.icon,
    required this.iconColor,
    required this.badge,
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
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F5F9)),
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
                  fontSize: 11,
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
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
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

// ─── Revenue Mix Row ──────────────────────────────────────────────────────────

class _RevenueMixRow extends StatelessWidget {
  final String label;
  final String percent;
  final double value;
  final Color color;
  final Color dotColor;

  const _RevenueMixRow({
    required this.label,
    required this.percent,
    required this.value,
    required this.color,
    required this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF334155),
                ),
              ),
            ),
            Text(
              percent,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: const Color(0xFFF1F5F9),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}

// ─── Transaction Column Header ────────────────────────────────────────────────

class _TxColHeader extends StatelessWidget {
  final String text;
  const _TxColHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w800,
        color: Color(0xFF94A3B8),
        letterSpacing: 0.8,
      ),
    );
  }
}

// ─── Transaction Row ──────────────────────────────────────────────────────────

class _TransactionRow extends StatelessWidget {
  final Transaction transaction;
  const _TransactionRow({required this.transaction});

  Color get _methodBg {
    switch (transaction.method) {
      case 'UPI':
        return const Color(0xFFEFF6FF);
      case 'CARD':
        return const Color(0xFFFFFBEB);
      default:
        return const Color(0xFFF1F5F9);
    }
  }

  Color get _methodColor {
    switch (transaction.method) {
      case 'UPI':
        return const Color(0xFF2563EB);
      case 'CARD':
        return const Color(0xFFB45309);
      default:
        return const Color(0xFF475569);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      child: Row(
        children: [
          // Transaction ID
          SizedBox(
            width: 130,
            child: Text(
              transaction.id,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          // Customer
          SizedBox(
            width: 150,
            child: Text(
              transaction.customer,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF334155),
              ),
            ),
          ),
          // Amount
          SizedBox(
            width: 100,
            child: Text(
              transaction.amount,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          // Method badge
          SizedBox(
            width: 100,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _methodBg,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                transaction.method,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: _methodColor,
                ),
              ),
            ),
          ),
          // Status
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: transaction.success
                        ? const Color(0xFF16A34A)
                        : const Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  transaction.success ? 'Success' : 'Failed',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: transaction.success
                        ? const Color(0xFF16A34A)
                        : const Color(0xFFEF4444),
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

// ─── Menu Item Card ───────────────────────────────────────────────────────────

class _MenuItemCard extends StatelessWidget {
  final MenuItem item;
  const _MenuItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Stack(
              children: [
                Image.network(
                  item.imageUrl,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    height: 140,
                    color: Colors.grey[200],
                    child: const Icon(Icons.fastfood, color: Colors.grey),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: item.inStock
                          ? const Color(0xFF22C55E)
                          : const Color(0xFFEF4444),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      item.inStock ? 'IN STOCK' : 'OUT OF STOCK',
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      item.price,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        color: kPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  item.description,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF64748B),
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 34,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Center(
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF334155),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.delete_outline,
                        size: 16,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Add Menu Item Placeholder ────────────────────────────────────────────────

class _AddMenuItemCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add_circle_outline,
              color: Color(0xFF94A3B8),
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Add New Menu Item',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Icon Button ─────────────────────────────────────────────────────────────

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Icon(icon, size: 18, color: const Color(0xFF475569)),
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
