import 'package:flutter/material.dart';
import 'package:grupchat/models/pool_list.dart';
import 'package:grupchat/modules/app/screens/screens.pools/pool_details.dart';
import 'package:grupchat/modules/app/screens/widgets/home/circular_progress.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
import 'package:grupchat/utils/formatters/formatter.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PoolCardsHorizontal extends StatelessWidget {
  const PoolCardsHorizontal({
    super.key,
    required Future<List<PoolListItem>> poolsFuture,
  }) : _poolsFuture = poolsFuture;

  final Future<List<PoolListItem>> _poolsFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PoolListItem>>(
      future: _poolsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
                color: kPrimaryColor, size: SizeConfig.screenHeight * 0.05),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final pools = snapshot.data!;
          if (pools.isEmpty) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/create-pool');
              },
              child: Container(
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
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ]),
                ),
              ),
            );
          }
          return SizedBox(
            height: SizeConfig.screenHeight * 0.24,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, PoolDetails.routeName,
                          arguments: pools[index].poolId);
                    },
                    child: Card(
                      color: kPrimaryColor,
                      elevation: 3,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth * 0.016,
                        ),
                        child: Container(
                          width: SizeConfig.screenHeight * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.048,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeConfig.screenWidth * 0.032,
                                    ),
                                    child: Text(
                                      pools[index].name,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Flexible(
                                      child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.screenWidth * 0.032),
                                    child: Text(
                                      NumberFormat(
                                              "###,###,###,###.00#", "en_US")
                                          .format(pools[index].targetAmount),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomCircularProgressIndicator(
                                    currentValue:
                                        pools[index].insights.totalDeposits,
                                    totalValue: pools[index].targetAmount,
                                    radius: SizeConfig.screenWidth * 0.1,
                                    linewidth: 6),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.screenWidth * 0.032,
                                    vertical: SizeConfig.screenHeight * 0.008),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        UtilFormatter.formatShortDate(
                                            pools[index].endDate),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "${pools[index].numberOfMembers}",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              width: SizeConfig.screenWidth *
                                                  0.008,
                                            ),
                                            const Icon(
                                              Icons.people_alt_outlined,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
    );
  }
}
