import 'package:flutter/material.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:grupchat/utils/constants/sys_util.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.016),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/create-pool');
                  },
                  child: Container(
                    width: SizeConfig.screenWidth * 0.92,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenHeight * 0.02,
                          vertical: SizeConfig.screenHeight * 0.02),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 40,
                          ),
                          Text(
                            'Create A Pool',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.016),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/withdraw');
                  },
                  child: Container(
                    width: SizeConfig.screenWidth * 0.44,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenHeight * 0.02,
                          vertical: SizeConfig.screenHeight * 0.02),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            color: Colors.white,
                            size: 40,
                          ),
                          Text(
                            'Withdraw',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/deposit');
                  },
                  child: Container(
                    width: SizeConfig.screenWidth * 0.44,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenHeight * 0.02,
                          vertical: SizeConfig.screenHeight * 0.02),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.auto_graph_sharp,
                            color: Colors.white,
                            size: 40,
                          ),
                          Text(
                            'Deposit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
