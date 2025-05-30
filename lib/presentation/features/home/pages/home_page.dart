import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:torti_go_app/presentation/shared/widgets/custom_icon_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              _HeaderSection(),
              _MainActionCard(),
              _QuickAccessGrid(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _BottomNavBar(),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage: const AssetImage('assets/images/avatar.png'),
              ),
              SizedBox(width: 8.w),
              Text(
                'Daniel',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/notificaciones');
            },
            icon: Icon(Icons.notifications_none, size: 24.sp),
          ),
        ],
      ),
    );
  }
}

class _MainActionCard extends StatelessWidget {
  const _MainActionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFCC80),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                flex: 0,
                child: Image.asset(
                  'assets/images/tortilla_bag.png',
                  width: 50.w,
                  height: 50.w,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  'Haz tu pedido',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/pedido'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE65100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
            child: Text(
              'Hacer pedido',
              style: TextStyle(fontSize: 16.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAccessGrid extends StatelessWidget {
  const _QuickAccessGrid();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 1.2,
        children: [
          CustomIconButton(
            icon: Icons.shopping_cart,
            label: 'Mis pedidos',
            onPressed: () => Navigator.pushNamed(context, '/mis-pedidos'),
          ),
          CustomIconButton(
            icon: Icons.schedule,
            label: 'Horarios',
            onPressed: () => Navigator.pushNamed(context, '/horarios'),
          ),
          CustomIconButton(
            icon: Icons.account_balance_wallet,
            label: 'Billetera',
            onPressed: () => Navigator.pushNamed(context, '/billetera'),
          ),
          CustomIconButton(
            icon: Icons.person,
            label: 'Mi perfil',
            onPressed: () => Navigator.pushNamed(context, '/perfil'),
          ),
        ],
      ),
    );
  }
}

class _BottomNavBar extends StatefulWidget {
  const _BottomNavBar();

  @override
  State<_BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<_BottomNavBar> {
  int _currentIndex = 0;

  final List<String> _routes = [
    '/home',
    '/mis-pedidos',
    '/billetera',
    '/notificaciones',
    '/perfil',
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        if (_routes[index] != ModalRoute.of(context)?.settings.name) {
          setState(() {
            _currentIndex = index;
          });
          Navigator.pushReplacementNamed(context, _routes[index]);
        }
      },
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Pedidos'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet), label: 'Billetera'),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications), label: 'Notificaciones'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
      ],
    );
  }
}
