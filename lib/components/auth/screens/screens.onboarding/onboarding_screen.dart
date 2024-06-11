import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grupchat/components/app/screens/widgets/pools/non_bordered_button.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:grupchat/utils/constants/sys_util.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            Text(
              'Welcome to GrupChat',
              style: GoogleFonts.raleway(
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.032),
            const FittedBox(
              child: Text(
                'Powering Plans Beyond the Group Chat!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.032),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      children: const [
                        OnboardingImage(
                          image: 'assets/images/team-work.png',
                          text:
                              'Tired Of Plans Never Making It \nPast The Group Chat?',
                        ),
                        OnboardingImage(
                          image: 'assets/images/check-list.png',
                          text:
                              'Regularly Pool Funds and \nRun Group Activities Easily!',
                        ),
                        OnboardingImage(
                          image: 'assets/images/business-idea.png',
                          text:
                              'Deposit, Withdraw and \nTrack Contributions Instantly!',
                        ),
                      ],
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      activeDotColor: kPrimaryColor,
                      dotHeight: 6,
                      dotColor: kSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.032),
            NonBorderedButton(
              text: 'Get Started',
              onTap: () {
                Navigator.pushNamed(context, '/sign-up');
              },
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/auth');
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
          ],
        ),
      ),
    );
  }
}

class OnboardingImage extends StatelessWidget {
  final String image;
  final String text;
  const OnboardingImage({
    Key? key,
    required this.image,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
          height: SizeConfig.screenHeight * 0.42,
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.raleway(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
