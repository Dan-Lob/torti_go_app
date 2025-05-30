import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
              context.go('/notificaciones');
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
            onPressed: () => context.go('/pedido'),
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
            onPressed: () => context.go('/mis-pedidos'),
          ),
          CustomIconButton(
            icon: Icons.schedule,
            label: 'Horarios',
            onPressed: () => context.go('/horarios'),
          ),
          CustomIconButton(
            icon: Icons.account_balance_wallet,
            label: 'Billetera',
            onPressed: () => context.go('/billetera'),
          ),
          CustomIconButton(
            icon: Icons.person,
            label: 'Mi perfil',
            onPressed: () => context.go('/perfil'),
          ),
        ],
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    int currentIndex() {
      if (location.startsWith('/mis-pedidos')) return 1;
      if (location.startsWith('/billetera')) return 2;
      if (location.startsWith('/notificaciones')) return 3;
      if (location.startsWith('/perfil')) return 4;
      return 0;
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepOrange.shade400,
            Colors.orangeAccent.shade200,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        currentIndex: currentIndex(),
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/mis-pedidos');
              break;
            case 2:
              context.go('/billetera');
              break;
            case 3:
              context.go('/notificaciones');
              break;
            case 4:
              context.go('/perfil');
              break;
          }
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Pedidos'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Billetera'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notificaciones'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
