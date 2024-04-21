
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grupchat/utils/constants/sys_util.dart';

class CardsSlider extends StatelessWidget {
  final List<Widget> items;
  const CardsSlider({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: SizeConfig.screenHeight * 0.24,
        viewportFraction: 0.4,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
      ),
      items: items,
    );
  }
}