import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grupchat/firebase_options.dart';
import 'package:grupchat/modules/auth/screens/screens.onboarding/onboarding_screen.dart';
import 'package:grupchat/widgets/navbar.dart';
import 'package:grupchat/routes/routes.dart';
import 'package:grupchat/utils/constants/colors.dart';
import 'package:grupchat/widgets/show_snackbar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'utils/constants/sys_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env file
  await dotenv.load();
  String supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  String supabaseKey = dotenv.env['SUPABASE_KEY'] ?? '';

// Initialize Supabase
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
    debug: true,
  );

  //Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

// Run the app
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    supabase.auth.onAuthStateChange.listen((event) async {
      if (event.event == AuthChangeEvent.signedIn) {
        await FirebaseMessaging.instance.requestPermission();
        await FirebaseMessaging.instance.getAPNSToken();
        final token = await FirebaseMessaging.instance.getToken();
        if (token != null) {
          await _setFcm(token);
        }
      }
    });
    FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
      await _setFcm(token);
    });

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification != null) {
        showSnackBar(context, '${notification.title}: ${notification.body}');
      }
    });
  }

  Future<void> _setFcm(String token) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId != null) {
      await supabase.from('users').upsert({
        'id': userId,
        'fcm': token,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      title: 'GrupChat',
      debugShowCheckedModeBanner: false,
      routes: appRoutes,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: StreamBuilder(
        stream: supabase.auth.onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingAnimationWidget.stretchedDots(
                color: Colors.blueGrey, size: SizeConfig.screenHeight * 0.024);
          } else if (snapshot.hasData) {
            switch (snapshot.data!.event) {
              case AuthChangeEvent.signedIn:
                return const HomeView();
              case AuthChangeEvent.tokenRefreshed:
                return const HomeView();
              case AuthChangeEvent.signedOut:
                return const OnboardingScreen();
              case AuthChangeEvent.initialSession:
                if (snapshot.data!.session != null) {
                  return const HomeView();
                } else {
                  return const OnboardingScreen();
                }
              default:
                return Center(child: Text('${snapshot.data!.event}'));
            }
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const OnboardingScreen();
          }
        },
      ),
    );
  }
}
