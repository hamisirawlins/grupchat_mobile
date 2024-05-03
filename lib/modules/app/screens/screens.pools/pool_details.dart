import 'package:flutter/material.dart';
import 'package:grupchat/modules/app/screens/widgets/common/section_header_title.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PoolDetails extends StatefulWidget {
  final String name;
  final String image;
  final bool isNetworkImage;
  const PoolDetails(
      {super.key,
      required this.image,
      required this.isNetworkImage,
      required this.name});

  @override
  State<PoolDetails> createState() => _PoolDetailsState();
}

class _PoolDetailsState extends State<PoolDetails> {
  List<List<String>> listData = [
    ["User 1: ", "Ksh 3000"],
    ["User 2: ", "Ksh 2800"],
    ["User 3: ", "Ksh 2600"],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: SizeConfig.screenHeight * 0.36,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                image: widget.isNetworkImage
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.image),
                      )
                    : const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/icons/banknote-envelope.png'),
                      ),
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.auto_graph_outlined,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Deposit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.play_for_work_sharp,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Withdraw',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.share),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            Row(
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth * 0.66,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.032,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text.rich(
                            textAlign: TextAlign.start,
                            TextSpan(
                              text: 'Pool: ',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                                TextSpan(
                                    text: widget.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text.rich(
                            textAlign: TextAlign.start,
                            TextSpan(
                              text: 'Start Date: ',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                                TextSpan(
                                    text: widget.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text.rich(
                            textAlign: TextAlign.start,
                            TextSpan(
                              text: 'End Date: ',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                                TextSpan(
                                    text: widget.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text.rich(
                            textAlign: TextAlign.start,
                            TextSpan(
                              text: 'Description: ',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                                TextSpan(
                                    text: widget.name.replaceRange(
                                        11, widget.name.length, '...'),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text.rich(
                            textAlign: TextAlign.start,
                            TextSpan(
                              text: 'Target: ',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                                TextSpan(
                                    text: widget.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text.rich(
                            textAlign: TextAlign.start,
                            TextSpan(
                              text: 'Current Amount: ',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                                TextSpan(
                                    text: widget.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    const Text(
                      'Progress',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.02,
                    ),
                    CircularPercentIndicator(
                      radius: SizeConfig.screenHeight * 0.06,
                      lineWidth: 5.0,
                      percent: 0.90,
                      center: const Text("90%"),
                      progressColor: Colors.green,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            const SectionHeader(
              text: 'Contributions',
              showViewAll: false,
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.02),
              child: ListView.builder(
                itemCount: listData.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Text(
                          listData[index][0],
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        Text(listData[index][1]),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
