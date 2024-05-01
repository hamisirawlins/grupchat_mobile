import 'package:flutter/material.dart';
import 'package:grupchat/features/app/screens/screens.home/home.dart';
import 'package:grupchat/features/app/screens/screens.pools/pools.dart';
import 'package:grupchat/features/app/screens/screens.profile/profile.dart';
import 'package:grupchat/features/app/screens/screens.transactions/transactions.dart';
import 'package:grupchat/utils/constants/colors.dart';

class HomeView extends StatefulWidget {
  static const String routeName = '/home-view';

  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    PoolsScreen(),
    const TransactionsScreen(),
    const ProfileScreen(),
  ];

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: kSecondaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onDestinationSelected,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bubble_chart_rounded),
            label: "Pools",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Transactions",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
