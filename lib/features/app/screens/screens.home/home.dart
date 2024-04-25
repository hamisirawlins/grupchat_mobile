import 'package:flutter/material.dart';
import 'package:grupchat/common/widgets/images/cards_slider.dart';
import 'package:grupchat/common/widgets/images/horizontal_image_card.dart';
import 'package:grupchat/features/app/screens/screens.pools/pool_details.dart';
import 'package:grupchat/features/app/screens/widgets/home/home_header.dart';
import 'package:grupchat/common/widgets/images/pool_card.dart';
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
            const SectionHeader(text: "Active Pools"),
            SizedBox(
              height: SizeConfig.screenHeight * 0.016,
            ),
            CardsSlider(items: [
              PoolCard(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PoolDetails(
                      image:
                          'https://images.pexels.com/photos/3607399/pexels-photo-3607399.jpeg?auto=compress&cs=tinysrgb&w=800',
                      isNetworkImage: true,
                      name: 'Baby Shower',
                    ),
                  ),
                ),
                isNetworkImage: true,
                imageUrl:
                    'https://images.pexels.com/photos/3607399/pexels-photo-3607399.jpeg?auto=compress&cs=tinysrgb&w=800',
                text: 'Baby Shower',
              ),
              // Add other PoolCard widgets here
            ]),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            const SectionHeader(text: "Completed Pools"),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.28,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PoolDetails(
                          image:
                              'https://images.pexels.com/photos/7932264/pexels-photo-7932264.jpeg?auto=compress&cs=tinysrgb&w=800',
                          isNetworkImage: true,
                          name: 'House Warming Kitty',
                        ),
                      ),
                    ),
                    child: const HorizontalImageCard(
                      text: "House Warming Kitty",
                      isNetworkImage: true,
                      image:
                          "https://images.pexels.com/photos/7932264/pexels-photo-7932264.jpeg?auto=compress&cs=tinysrgb&w=800",
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PoolDetails(
                          image:
                              'https://images.pexels.com/photos/7932264/pexels-photo-7932264.jpeg?auto=compress&cs=tinysrgb&w=800',
                          isNetworkImage: true,
                          name: 'House Warming Kitty',
                        ),
                      ),
                    ),
                    child: const HorizontalImageCard(
                      text: "House Warming Kitty",
                      isNetworkImage: true,
                      image:
                          "https://images.pexels.com/photos/7932264/pexels-photo-7932264.jpeg?auto=compress&cs=tinysrgb&w=800",
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
}
