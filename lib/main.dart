import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grupchat/widgets/navbar.dart';
import 'package:grupchat/modules/auth/screens/screens.onboarding/auth_screen.dart';
import 'package:grupchat/routes/routes.dart';
import 'package:grupchat/utils/constants/colors.dart';
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
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      title: 'GrupChat',
      debugShowCheckedModeBanner: false,
      routes: appRoutes,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blue[50],
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
                return const LoginAndRegisterView();
              case AuthChangeEvent.initialSession:
                if (snapshot.data!.session != null) {
                  return const HomeView();
                } else {
                  return const LoginAndRegisterView();
                }
              default:
                return Center(child: Text('${snapshot.data!.event}'));
            }
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const LoginAndRegisterView();
          }
        },
      ),
    );
  }
}
