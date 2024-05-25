import 'package:flutter/material.dart';
import 'package:grupchat/models/pool_list.dart';
import 'package:grupchat/modules/app/screens/screens.pools/pool_details.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
import 'package:grupchat/utils/formatters/formatter.dart';

class HorizontalPoolCard extends StatelessWidget {
  const HorizontalPoolCard({
    super.key,
    required PoolListItem pool,
  }) : _pool = pool;

  final PoolListItem _pool;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PoolDetails.routeName,
            arguments: _pool.poolId);
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.screenHeight * 0.008,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 6,
                  child: Text(
                    _pool.name,
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${_pool.numberOfMembers}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.008,
                        ),
                        const Icon(
                          Icons.people_alt_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.screenHeight * 0.008,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${(_pool.insights.totalDeposits - _pool.insights.totalWithdrawals)} / ${_pool.targetAmount}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.08,
                  width: SizeConfig.screenHeight * 0.08,
                  child: CircularProgressIndicator(
                    strokeWidth: 8,
                    backgroundColor: kAccentColor,
                    value: UtilFormatter.getPoolProgress(_pool),
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.blue[200]!),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.screenHeight * 0.008,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Started ${UtilFormatter.formatDate(_pool.createdAt)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Ends ${UtilFormatter.formatDate(_pool.endDate)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

