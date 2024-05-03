import 'package:flutter/material.dart';
import 'package:grupchat/models/pool.dart';
import 'package:grupchat/modules/app/screens/widgets/home/home_header.dart';
import 'package:grupchat/modules/app/screens/widgets/common/section_header_title.dart';
import 'package:grupchat/modules/app/screens/widgets/home/month_progression.dart';
import 'package:grupchat/services/data_service.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
            Padding(
              padding: EdgeInsets.all(SizeConfig.screenWidth * 0.016),
              child: Container(
                height: SizeConfig.screenHeight * 0.24,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Month's Progression",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                        ),
                        MonthlyProgressIndicator(),
                        Spacer()
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Active Pools",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w600)),
                        Text("10",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 72,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.016),
            const SectionHeader(
              text: "Active Pools",
              showViewAll: false,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.016),
            FutureBuilder<List<Pool>>(
              future: _poolsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                        color: kPrimaryColor,
                        size: SizeConfig.screenHeight * 0.05),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final pools = snapshot.data!;
                  return SizedBox(
                    height: SizeConfig.screenHeight * 0.2,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.016,
                            ),
                            child: Container(
                              width: SizeConfig.screenHeight * 0.2,
                              decoration: BoxDecoration(
                                color: kSecondaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      pools[index].name,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: pools.length,
                        shrinkWrap: true),
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.016,
                    ),
                    child: Container(
                      height: SizeConfig.screenHeight * 0.16,
                      width: SizeConfig.screenHeight * 0.28,
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
