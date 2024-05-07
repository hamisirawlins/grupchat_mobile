import 'package:flutter/material.dart';
import 'package:grupchat/models/pool.dart';
import 'package:grupchat/modules/app/screens/widgets/home/home_header.dart';
import 'package:grupchat/modules/app/screens/widgets/common/section_header_title.dart';
import 'package:grupchat/modules/app/screens/widgets/home/home_trends.dart';
import 'package:grupchat/modules/app/screens/widgets/home/pool_cards_horizontal.dart';
import 'package:grupchat/services/data_service.dart';
import 'package:grupchat/utils/constants/sys_util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Pool>> _poolsFuture;

  @override
  void initState() {
    super.initState();
    _poolsFuture = _fetchPools();
  }

  Future<List<Pool>> _fetchPools() async {
    final gatewayService = DataService();
    return await gatewayService.getPools();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeader(searchController: _searchController),
            SizedBox(height: SizeConfig.screenHeight * 0.016),
            const SectionHeader(
              text: "Trends",
              showViewAll: false,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.016),
            const SectionHeader(
              text: "Active Pools",
              showViewAll: false,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.016),
            PoolCardsHorizonatal(poolsFuture: _poolsFuture),
          ],
        ),
      ),
    );
  }
}
