import 'package:flutter/material.dart';
import 'package:grupchat/models/pool_list.dart';
import 'package:grupchat/components/app/screens/widgets/home/home_header.dart';
import 'package:grupchat/components/app/screens/widgets/common/section_header_title.dart';
import 'package:grupchat/components/app/screens/widgets/home/pool_cards_horizontal.dart';
import 'package:grupchat/components/app/screens/widgets/home/quick_actions.dart';
import 'package:grupchat/services/data_service.dart';
import 'package:grupchat/utils/constants/sys_util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<PoolListItem>> _poolsFuture;
  @override
  void initState() {
    super.initState();
    _poolsFuture = _fetchPools();
  }

  Future<List<PoolListItem>> _fetchPools() async {
    final gatewayService = DataService();
    return await gatewayService.getPools(1, 40);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HomeHeader(),
            SizedBox(height: SizeConfig.screenHeight * 0.016),
            const SectionHeader(
              text: "Quick Actions",
              showViewAll: false,
            ),
            const QuickActions(),
            SizedBox(height: SizeConfig.screenHeight * 0.004),
            const SectionHeader(
              text: "Latest Pools",
              showViewAll: false,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.01),
            PoolCardsHorizontal(poolsFuture: _poolsFuture),
          ],
        ),
      ),
    );
  }
}
