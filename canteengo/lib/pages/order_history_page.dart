import 'package:flutter/material.dart';

class OrderHistoryPageApp extends StatelessWidget {
  const OrderHistoryPageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CanteenGo - Order History',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F6F6),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC6102E)),
      ),
      home: const OrderHistoryPage(),
    );
  }
}

// ─── Constants ───────────────────────────────────────────────────────────────

const Color kPrimary = Color(0xFFC6102E);
const Color kBackground = Color(0xFFF8F6F6);

// ─── Order Model ─────────────────────────────────────────────────────────────

enum OrderStatus { completed, cancelled }

class OrderRecord {
  final String orderId;
  final double amount;
  final String date;
  final int itemCount;
  final OrderStatus status;
  final String imageUrl;

  const OrderRecord({
    required this.orderId,
    required this.amount,
    required this.date,
    required this.itemCount,
    required this.status,
    required this.imageUrl,
  });
}

const List<OrderRecord> kOrders = [
  OrderRecord(
    orderId: '#CG-77210',
    amount: 12.50,
    date: 'Oct 24, 2026',
    itemCount: 2,
    status: OrderStatus.completed,
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuANCYFspz8dUmkkbyesObVtXdtYCXzKdHck5xEKvPy72fXSTrZ72umozWfBbQMJ8rA629ITsRb0Pd0bTX_N8V0AMytznI1F5ImVVpzJYs99yXUp3AhL4Aws3GbK-Z80xGLThNZdJ2L2ub1Y6Gc8sGNmz2ckO8Yeg-fjs0qJ5r-W5m_0GDdz-EKtZiEw5kGuZ3CGYrDav1Ijz79XzzSaGjtwEcLqn8QvFfgr8BnVlwQq2vhPTK-z9wUHk2EBbhLc4Q0hFbW1nRUGtbkN',
  ),
  OrderRecord(
    orderId: '#CG-77195',
    amount: 8.75,
    date: 'Oct 22, 2026',
    itemCount: 1,
    status: OrderStatus.completed,
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDa_UAFAvUCVGWxxt6l-pgp9wOt-xMO6XATk2c2SdJ4T98L0cFOO6cNxPGgU98HzO6VmegguZF0qJI7f7WKE0GAzc6z9KMSt92uqKobQCivo6AZWRv94BSwsuTkMSGX8KsMZ47pQNCmP6vt8fZ4l_iD02ulziDiT4rNEg1aoCHVE32BYPU2SvjSa63JNqt_k3CxSCKrWdYeWk1gH8wiWvivkrHxvolK2RvpB-x4JzzW96uZDYcddNr-98F-4EiGuKobAxikjcskHZ08',
  ),
  OrderRecord(
    orderId: '#CG-77150',
    amount: 15.20,
    date: 'Oct 15, 2026',
    itemCount: 3,
    status: OrderStatus.cancelled,
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDCP1zKmxAgX9ZMMlOcaVSMgbtYxQNV7SxTrapnOn3aStWDDuPQTXwUNKSfbZtmZSFgmo-dDg8NB40y2uXMwCu6tjqr9ZDowt9D18NOe7mXMGldrpNabjW55OEGDw8sEMhnMRZoyilk2B18hc8YiGMKF-de9nY2EMYcW720nP9Iq3CJxyDdMtyrWlVubEmW0tQ1e4aO5Q6fgfTKwr0bMc6knRnBwJT9eD5CiNlQiH8EH2OitTBytOOGhUxqDmpmAxErKoMYnbCiRf4Y',
  ),
  OrderRecord(
    orderId: '#CG-77082',
    amount: 6.40,
    date: 'Oct 10, 2026',
    itemCount: 4,
    status: OrderStatus.completed,
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBCa8t2qLgWZmH3za2BITWW6FGSeiWYfHj7MJPyrK0LA9qVRgcdaxyCIpa7RmxcTBX-zWi5gSBXmioP-Y-cpHvKKGalYx9rpTVf2b_3gNHwLEqU8ASrlCQrpNYewVBgpqMSbQP1C1MQgSlQLTcC6o6Ud3qw-yPy4SBXN148d9l7eq52YkVl6Xcevh4x6jcXyluMP4AwGn1OMYx7tfvj1RlZFowQJDbe7X-SllllosetRnUIXpCm2vhqlgga2wV6kpzsEgGA1vnSIb_X',
  ),
];

// ─── Order History Page ───────────────────────────────────────────────────────

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  int _selectedNavIndex = 1; // Orders tab active

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Column(
        children: [
          // ── Sticky Header ──
          _buildAppBar(),

          // ── Search & Filter ──
          _buildSearchBar(),

          // ── Orders List ──
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
              itemCount: kOrders.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _OrderCard(order: kOrders[index]),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── App Bar ────────────────────────────────────────────────────────────────

  Widget _buildAppBar() {
    return Container(
      color: kBackground.withValues(alpha: 0.9),
      child: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFE2E8F0)),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.maybePop(context),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF0F172A),
                      size: 22,
                    ),
                  ),
                ),
              ),
              const Text(
                'Order History',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Search Bar ─────────────────────────────────────────────────────────────

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          // Search input
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 14),
                  const Icon(Icons.search,
                      color: Color(0xFF94A3B8), size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
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
          ),
          const SizedBox(width: 10),
          // Filter button
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: const Icon(
              Icons.tune,
              color: Color(0xFF475569),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  // ── Bottom Navigation ──────────────────────────────────────────────────────

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      padding: EdgeInsets.only(
        top: 10,
        bottom: MediaQuery.of(context).padding.bottom + 10,
        left: 16,
        right: 16,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // Nav items row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _navItem(Icons.home_outlined, 'Home', 0),
              _navItem(Icons.receipt_long, 'Orders', 1),
              // Center gap for the FAB
              const SizedBox(width: 56),
              _navItem(Icons.account_balance_wallet_outlined, 'Wallet', 3),
              _navItem(Icons.person_outline, 'Profile', 4),
            ],
          ),
          // Floating center basket button
          Positioned(
            top: -28,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: kPrimary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: kPrimary.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.shopping_basket,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final isActive = index == _selectedNavIndex;
    return GestureDetector(
      onTap: () => setState(() => _selectedNavIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: isActive ? kPrimary : const Color(0xFF94A3B8),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight:
                  isActive ? FontWeight.w700 : FontWeight.w500,
              color: isActive ? kPrimary : const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Order Card ───────────────────────────────────────────────────────────────

class _OrderCard extends StatelessWidget {
  final OrderRecord order;
  const _OrderCard({required this.order});

  bool get _isCancelled => order.status == OrderStatus.cancelled;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Top: image + info ──
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Food image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ColorFiltered(
                    colorFilter: _isCancelled
                        ? const ColorFilter.matrix([
                            0.2126, 0.7152, 0.0722, 0, 0,
                            0.2126, 0.7152, 0.0722, 0, 0,
                            0.2126, 0.7152, 0.0722, 0, 0,
                            0,      0,      0,      1, 0,
                          ])
                        : const ColorFilter.mode(
                            Colors.transparent, BlendMode.color),
                    child: Opacity(
                      opacity: _isCancelled ? 0.6 : 1.0,
                      child: Image.network(
                        order.imageUrl,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey[200],
                          child: const Icon(Icons.fastfood,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Order details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                // Status label
                                Text(
                                  _isCancelled
                                      ? 'CANCELLED'
                                      : 'COMPLETED',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: _isCancelled
                                        ? const Color(0xFF94A3B8)
                                        : const Color(0xFF16A34A),
                                    letterSpacing: 0.8,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                // Order ID
                                Text(
                                  order.orderId,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Price
                          Text(
                            '\$${order.amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: _isCancelled
                                  ? const Color(0xFF94A3B8)
                                  : kPrimary,
                              decoration: _isCancelled
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Date + items
                      Text(
                        '${order.date} • ${order.itemCount} ${order.itemCount == 1 ? 'Item' : 'Items'}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom: Reorder + Details buttons ──
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                // Reorder button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.reorder, size: 16),
                    label: const Text(
                      'Reorder',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                      minimumSize: const Size(0, 40),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Details button
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFF1F5F9),
                    foregroundColor: const Color(0xFF475569),
                    side: BorderSide.none,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    minimumSize: const Size(0, 40),
                  ),
                  child: const Text(
                    'Details',
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