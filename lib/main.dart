import 'package:crm_spx/locator.dart';
import 'package:crm_spx/src/navigation/layouts/layouts.dart';
import 'package:crm_spx/src/pages/auth/login_auth.dart';
import 'package:crm_spx/src/provider/app_provider.dart';
import 'package:crm_spx/src/provider/controller.dart';
import 'package:crm_spx/src/provider/theme_provider.dart';
import 'package:crm_spx/src/routing/router.dart';
import 'package:crm_spx/src/services/user_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  setPathUrlStrategy();
  runApp(
    Phoenix(
      child: const MyApp(),
    ),
  );
  timeago.setLocaleMessages('fr_short', timeago.FrShortMessages());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: AppProvider.init()),
          ChangeNotifierProvider(create: (context) => Controller()),
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ],
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Business Management',
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            onGenerateRoute: generateRoute,
            home: const CheckAuth(),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('fr', 'FR')],
          );
        });
  }
}

class CheckAuth extends StatefulWidget {
  const CheckAuth({Key? key}) : super(key: key);

  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  @override
  void initState() {
    super.initState();
    userPrefs();
  }

  bool? auth;
  bool? theme;

  Future userPrefs() async {
    var user = await UserPreferences.getAuth();
    // await UserPreferences.remove('tokenKey');
    setState(() {
      auth = user;
    });
  }

  authLogin() {
    // AuthHttp().logout();
    if (auth == true) {
      return const Layouts();
    } else {
      return const LoginPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return authLogin();
  }
}
