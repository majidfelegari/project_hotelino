import 'package:flutter/material.dart';
import 'package:hotelino/bootstrap.dart';
import 'package:hotelino/core/theme/app_theme.dart';
import 'package:hotelino/core/theme/theme_provider.dart';
import 'package:hotelino/features/onboarding/data/repositories/onboarding_repository.dart';
import 'package:hotelino/features/onboarding/presentation/onboarding_provider.dart';
import 'package:hotelino/routes/app_route.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async{
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  //bootstraping = config, connect to database, get post from api, notificatio, check sms, sensor (1 , 2 seconds)
  await lazyBootstrap();
  FlutterNativeSplash.remove();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider(WidgetsBinding.instance.platformDispatcher.platformBrightness)),
      ChangeNotifierProvider(create: (_) => OnboardingProvider(OnboardingRepository())),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  //initial observer
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  //remove observer
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    // TODO: implement didChangePlatformBrightness
    super.didChangePlatformBrightness();

    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    Provider.of<ThemeProvider>(context, listen: false).updateBrightness(brightness);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeModeProvider, child){
        return MaterialApp(
          title: 'hotelino',
          debugShowCheckedModeBanner: false,
          theme: themeModeProvider.brightness == Brightness.light ? AppTheme.lightTheme : AppTheme.darkTheme,
          routes: AppRoute.routes,
          initialRoute: AppRoute.onboarding,
        );
      },
    );
  }
}


