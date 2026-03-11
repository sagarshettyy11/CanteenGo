import 'package:flutter/material.dart';

class HomePageApp extends StatelessWidget {
  const HomePageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CanteenGo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'sans-serif',
        scaffoldBackgroundColor: const Color(0xFFF8F6F6),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC6102E)),
      ),
      home: const HomePage(),
    );
  }
}

// ─── Constants ───────────────────────────────────────────────────────────────

const Color kPrimary = Color(0xFFC6102E);
const Color kAccentYellow = Color(0xFFFFC72C);
const Color kBackground = Color(0xFFF8F6F6);

// ─── Data Model ──────────────────────────────────────────────────────────────

class FoodItem {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final bool isFavorite;

  const FoodItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });
}

const List<FoodItem> kFoodItems = [
  FoodItem(
    name: 'Double Burger',
    description: 'Extra cheese, fresh patties',
    price: 8.50,
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDFm0AOZY4sIHmSL4CtaF6bf5JkL2rm_I8qkswAKOAFvQT212U7EDgWRVSwkGILOuIdRABbflg7odm8lDR6DvnxSEebvRNfYmymobR09SbbpKLKMXJWP8Mt7F8esNE8KcXWlfqoWpY2W7kphuKazMfKfHDRCCKGA473w6FaXA1xt25y4-b1e_UL8NGMOLm0vx2ddT3zHmgHwqQaFiuj8dneihIgcFfDRbkCrbarO8zpcTevk7gw-FHBIa2FfzUY3758Sx21dIoLJ2VI',
    isFavorite: true,
  ),
  FoodItem(
    name: 'Caesar Salad',
    description: 'Grilled chicken & parmesan',
    price: 7.25,
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuA-yCodU99Z9s84ZGT9Go4TsqipKmTWQYmIvtdUX3agYf5xj-SAj_tS7Zo8kxIGZbsYGQd2sGCyQRfvtE6qeUFOrVeGjtr5-FRCNM-Jt1Sh9g70MCCiyEogYuc46Gl9wx1Kbz3tqyOZG1voUaDCCS0qurOevTXWlWrG57C8gykQnOfadmrUzl0-pHRtgJ6398ofcUdcD9plYII7SuoGBnJ3mU-sdycUby1orhtHF41D4_e1Me2vJ9XUWLjbJ7EZv3xsoxIo2DSHVvay',
  ),
  FoodItem(
    name: 'Pepperoni Slice',
    description: 'Classic wood-fired dough',
    price: 4.50,
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuD9HSP0LUT_o4G1sSEn3R_cgJSeB58fO46WHxPIwz4S1jaMsCexUShFMN2gx1-VHx9LJLxLT2I_0nKSsNpe8EUlpilnrOawO0JSNRlWkioYN15La9nSFCeMSJhCW7EkQXy-6drQy5KuFEwC4H4W5eqL8mvU4UxlP5i63h-19w0LT4TS6BTYSjdwZLXJTFqjamgRKOMt_B3A91Nwlv-G8vTxPlHf8PV7cb4wZ8LJNpSh_O-TFn5WH947nxCisxX6J2QLEsVs98WTRmTx',
  ),
  FoodItem(
    name: 'Cold Brew',
    description: 'Ethically sourced beans',
    price: 3.95,
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDmQUKkic85aYFhH6pIhNeDbGjqb4i6yOXfsIWThv-Xits6cdDmMOE5YSQMk1Pnsr2FTL6Lg2oQ5QYofka_IWiLj0Qv631_NXb_pwusMJlXPkfBLuLsiKOQiMwI6Gqb06sPwhHb-tzWK6WEaZzeU9PZt22_MkKzfWoQGoe55b-kB-4BqlBA_NzyxraOV1p0nTfmzWciavcPdSBMsl9TtFtZHAiXENolmS0A31lEhXY29kT0_WaEUpmBN4sOk_Kh_x3Jqwk0pLP-fcq6',
  ),
  FoodItem(
    name: 'Beef Tacos',
    description: 'Set of 3 with fresh salsa',
    price: 6.80,
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDaVsDwI1c_ywcVqj6gKgQrvhBcsE-yvNBByalZLs-ECh2ncet6ZGx7ysMM2PbAPrrduTc1MFEz_bLkbmTJtyk0KMzWgVPQ_V7zIgELpHliFXvxRtfmcxDfp_37xay3NP9zidpUN2A-J1YMXXXCFCiYZx-wWRLay0s9Y6ESLDdPF5drALVI81Djcph8LRo-efywyRxXID25a77bCLywB_htRIz-gjJ9Yhj9PvLyHEXexSDprrIzdefWsj_geJKOUw-Wzsk_p8-FhqEx',
  ),
  FoodItem(
    name: 'Sushi Combo',
    description: 'Daily fresh salmon & tuna',
    price: 12.50,
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDdRA0xTnT-3rnxRWBRaUkDf357kFdy-lUzJ7f1fMvO7XL46RHyNEdYCVk4L0NBEkwWuhSKDLwbGxqOVO7Fj9Sc3V0b3uIZTaVaOmlLygekIL_mfQIZsQN-lQtTh-5BC5cQu4bZRrRZDXKFNq326v6Bm7QdEiWXz8q7iH1hfusRTaWWScLk7EpkWci4DCe9uvbvWYSk7uAe2exDBNtT65RRUUgdxDr109kEC4osKwXpbNaDvk63TYJsRWeBfhcIUboqYkhc-1gVPfXO',
  ),
];

const List<String> kCategories = [
  'All',
  'Snacks',
  'Meals',
  'Drinks',
  'Desserts',
];

// ─── Home Page ────────────────────────────────────────────────────────────────

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedCategory = 0;
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      // Use Column so sticky header never participates in scroll
      body: Column(
        children: [
          _StickyHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  // Banner
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildBanner(),
                  ),
                  const SizedBox(height: 20),
                  // Category tabs
                  _buildCategoryTabs(),
                  const SizedBox(height: 12),
                  // Food grid
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildFoodGrid(),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── Flash Sale Banner ──────────────────────────────────────────────────────
  // FIX: Use ClipRRect + Stack with Positioned for background icon so it
  // never causes overflow. Content uses mainAxisSize.min (no fixed height).

  Widget _buildBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 160),
        color: kAccentYellow,
        child: Stack(
          children: [
            // Decorative background icon — clipped by ClipRRect above
            Positioned(
              right: -28,
              bottom: -28,
              child: Opacity(
                opacity: 0.18,
                child: Transform.rotate(
                  angle: 0.21,
                  child: const Icon(
                    Icons.restaurant,
                    size: 175,
                    color: kPrimary,
                  ),
                ),
              ),
            ),
            // Content — intrinsic height, right padding avoids icon overlap
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 110, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // KEY FIX: no fixed height
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      'FLASH SALE',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: kPrimary,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Today's Special\n– 20% Off",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Valid on all meal combos today',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimary,
                      foregroundColor: Colors.white,
                      elevation: 3,
                      shadowColor: kPrimary.withValues(alpha: 0.3),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Order Now',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Category Tabs ──────────────────────────────────────────────────────────

  Widget _buildCategoryTabs() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: kCategories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = index == _selectedCategory;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? kPrimary : Colors.white,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: isSelected ? kPrimary : const Color(0xFFF1F5F9),
                ),
              ),
              child: Text(
                kCategories[index],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  color: isSelected ? Colors.white : const Color(0xFF475569),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Food Grid ──────────────────────────────────────────────────────────────

  Widget _buildFoodGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.78,
      ),
      itemCount: kFoodItems.length,
      itemBuilder: (context, index) => _FoodCard(item: kFoodItems[index]),
    );
  }

  // ── Bottom Navigation ──────────────────────────────────────────────────────

  Widget _buildBottomNav() {
    const items = [
      _NavItem(icon: Icons.home, label: 'Home'),
      _NavItem(icon: Icons.receipt_long, label: 'Orders'),
      _NavItem(icon: Icons.shopping_cart, label: 'Cart', badge: '2'),
      _NavItem(icon: Icons.person, label: 'Profile'),
    ];

    return Container(
      color: kPrimary,
      padding: EdgeInsets.only(
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
        left: 16,
        right: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isActive = index == _selectedNavIndex;
          return GestureDetector(
            onTap: () => setState(() => _selectedNavIndex = index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      item.icon,
                      size: 24,
                      color: isActive
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.65),
                    ),
                    if (item.badge != null)
                      Positioned(
                        top: -4,
                        right: -6,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: kAccentYellow,
                            shape: BoxShape.circle,
                            border: Border.all(color: kPrimary, width: 2),
                          ),
                          child: Center(
                            child: Text(
                              item.badge!,
                              style: const TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                    color: isActive
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.65),
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

// ─── Sticky Header Widget ─────────────────────────────────────────────────────

class _StickyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackground.withValues(alpha: 0.95),
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Greeting row
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: kPrimary.withValues(alpha: 0.2),
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuDqW5C6ZCU0dgzg8oeZKBV0afnc_ttFEKip7A59mKYiGsf_xijDl4femJAEgE20C-pP328O5GgQkliN_TNWBR1I9VrLyQgbwZ76jyZ0xYdGLiPCqNjpVZi9i8mRSyh4NSPaRVi1IkmRzylPicxJjzfrD52hNd1sLnQkxv1XzKihCd7rJom2uSdXPP1o8FnfCx7fg1B6tamEdzw3uM8NvSrOc0Dcpv6kV_f0_CARhnFdsbiuFrKJ22sgRbsN9t6BmQUyTY2z7os10ZsB',
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.person, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, Alex 👋',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                            height: 1.2,
                          ),
                        ),
                        Text(
                          'Main Campus Canteen',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.notifications_outlined,
                      color: Color(0xFF334155),
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            // Search bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 14),
                    const Icon(
                      Icons.search,
                      color: Color(0xFF94A3B8),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Search for food, drinks...',
                          hintStyle: TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 14,
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
          ],
        ),
      ),
    );
  }
}

// ─── Food Card ────────────────────────────────────────────────────────────────

class _FoodCard extends StatelessWidget {
  final FoodItem item;
  const _FoodCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: SizedBox.expand(
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.fastfood, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                if (item.isFavorite)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: kPrimary,
                        size: 14,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Info
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  item.description,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: kPrimary,
                      ),
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: kPrimary,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: kPrimary.withValues(alpha: 0.25),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
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

// ─── Nav Item Model ───────────────────────────────────────────────────────────

class _NavItem {
  final IconData icon;
  final String label;
  final String? badge;
  const _NavItem({required this.icon, required this.label, this.badge});
}
