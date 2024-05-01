import 'package:flutter/material.dart';
import 'package:grupchat/common/widgets/images/horizontal_image_card.dart';
import 'package:grupchat/features/app/screens/screens.pools/pool_details.dart';
import 'package:grupchat/features/app/screens/widgets/home/home_header.dart';
import 'package:grupchat/features/app/screens/widgets/common/section_header_title.dart';
import 'package:grupchat/utils/constants/sys_util.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeader(searchController: _searchController),
            SizedBox(
              height: SizeConfig.screenHeight * 0.016,
            ),
            const SectionHeader(text: "Pools"),
            SizedBox(
              height: SizeConfig.screenHeight * 0.016,
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            const SectionHeader(text: "Completed Pools"),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
