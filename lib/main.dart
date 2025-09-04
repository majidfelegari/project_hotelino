import 'package:flutter/material.dart';
import 'package:hotelino/bootstrap.dart';
import 'package:hotelino/core/theme/app_theme.dart';
import 'package:hotelino/core/theme/theme_provider.dart';
import 'package:hotelino/features/home/presentation/provider/favorite_item_provider.dart';
import 'package:hotelino/features/home/presentation/provider/home_provider.dart';
import 'package:hotelino/features/home/presentation/provider/profile_provider.dart';
import 'package:hotelino/features/home/repositories/hotel_repository.dart';
import 'package:hotelino/features/home/repositories/profile_repository.dart';
import 'package:hotelino/features/onboarding/data/repositories/onboarding_repository.dart';
import 'package:hotelino/features/onboarding/presentation/onboarding_provider.dart';
import 'package:hotelino/routes/app_route.dart';
import 'package:hotelino/shared/services/json_data_service.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async{
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  //bootstraping = config, connect to database, get post from api, notificatio, check sms, sensor (1 , 2 seconds)
  await lazyBootstrap();
  FlutterNativeSplash.remove();

  final hotelRepository = HotelRepository(jsonDataService: JsonDataService());

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider(WidgetsBinding.instance.platformDispatcher.platformBrightness)),
      ChangeNotifierProvider(create: (_) => OnboardingProvider(OnboardingRepository())),
      ChangeNotifierProvider(create: (_) => HomeProvider(hotelRepository)),
      ChangeNotifierProvider(create: (_) => ProfileProvider(ProfileRepository(), hotelRepository)),
      ChangeNotifierProvider(create: (_) => FavoriteItemProvider(hotelRepository)),
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
          locale: const Locale("fa", "IR"),
          supportedLocales: const [Locale("fa", "IR"), Locale("en", "us")],
          localizationsDelegates: const [
            PersianMaterialLocalizations.delegate,
            PersianCupertinoLocalizations.delegate
          ],
          debugShowCheckedModeBanner: false,
          theme: themeModeProvider.brightness == Brightness.light ? AppTheme.lightTheme : AppTheme.darkTheme,
          routes: AppRoute.routes,
          initialRoute: AppRoute.onboarding,
        );
      },
    );
  }
}


