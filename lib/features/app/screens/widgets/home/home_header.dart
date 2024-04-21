import 'package:flutter/material.dart';
import 'package:grupchat/features/app/screens/widgets/common/search_bar.dart';
import 'package:grupchat/features/app/screens/widgets/home/total_pooled.dart';
import 'package:grupchat/utils/constants/sys_util.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.32,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Colors.blue[300]!,
            Colors.blue[700]!,
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Searchbar(searchController: _searchController),
          SizedBox(height: SizeConfig.screenHeight * 0.024),
          const TotalPooled(),
          SizedBox(height: SizeConfig.screenHeight * 0.024),
          const Text(
            "Powering Plans Beyond The Group Chat",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
