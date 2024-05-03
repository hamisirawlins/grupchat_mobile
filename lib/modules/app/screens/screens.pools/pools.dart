import 'package:flutter/material.dart';
import 'package:grupchat/modules/app/screens/widgets/common/search_bar.dart';
import 'package:grupchat/modules/app/screens/widgets/pools/pool_list_item.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:grupchat/utils/constants/sys_util.dart';

class PoolsScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  PoolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  Searchbar(searchController: _searchController),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.014),
              PoolsListItem(),
              PoolsListItem(),
              PoolsListItem(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kPrimaryColor,
        onPressed: () {},
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: const Text(
          'Create Pool',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
    );
  }
}
