import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:oline_ordering_system/GetX/mainGetX.dart';
import 'package:oline_ordering_system/firebase_options.dart';
import 'package:oline_ordering_system/provider/ApiConnection/ApiConnection_Provider.dart';
import 'package:oline_ordering_system/provider/ApiConnection/AuthRepo.dart';
import 'package:oline_ordering_system/provider/firebase_Provider.dart';
import 'package:oline_ordering_system/views/PageViews/AccountScreen.dart';
import 'package:oline_ordering_system/views/PageViews/CartScreen.dart';
import 'package:oline_ordering_system/views/AuthViews/ForgotPasswordOtpScreen.dart';
import 'package:oline_ordering_system/views/AuthViews/ForgotPasswordScreen.dart';
import 'package:oline_ordering_system/views/Home%20Screen.dart';
import 'package:oline_ordering_system/views/AuthViews/Login%20Screen.dart';
import 'package:oline_ordering_system/views/PageViews/OrderHistoryScreen.dart';
import 'package:oline_ordering_system/views/AuthViews/OtpScreen.dart';
import 'package:oline_ordering_system/views/PageViews/ProductScreen.dart';
import 'package:oline_ordering_system/views/AuthViews/Registration%20Screen.dart';
import 'package:oline_ordering_system/views/AuthViews/ChangePswScreen.dart';
import 'package:oline_ordering_system/views/Splash%20Screen.dart';
import 'package:oline_ordering_system/provider/cart_provider.dart';
import 'package:oline_ordering_system/provider/favourite_provider.dart';
import 'package:oline_ordering_system/provider/placeOrder_provider.dart';
import 'package:oline_ordering_system/provider/search_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Bloc/mainBloc.dart';
import 'notificationservice/local_notification_service.dart';
import 'views/PageViews/ProductDetailsScreen.dart';
import 'views/PageViews/WishlistScreen.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (DefaultFirebaseOptions.currentPlatform == DefaultFirebaseOptions.android) {
     await Firebase.initializeApp(options: DefaultFirebaseOptions.android);


  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  final fcmToken = await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    LocalNotificationService.initialize();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('fcmToken', fcmToken!);
    log(fcmToken!);

  } else {

  }

  runApp(const BlocApp());
  // runApp(const GetApp());
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FavouriteProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => PlaceOrderProvider()),
          ChangeNotifierProvider(create: (_) => SearchProvider()),
          ChangeNotifierProvider(create: (_) => ApiConnectionProvider()),
          ChangeNotifierProvider(create: (_)=> FirebaseApiCalling()),
          ChangeNotifierProvider(create: (_)=> AuthRepo())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const Splash(),
          routes: {
            '/login-screen': (context) => const LoginScreen(),
            '/forgotpsw-screen': (context) => const ForgotPasswordScreen(),
            '/forgotpswOtp-screen': (context) => const ForgotPasswordOtpScreen(),
            '/resetpsw-screen': (context) => const ResetPasswordScreen(),
            '/registration-screen': (context) => const RegistrationScreen(),
            '/otp-screen': (context) => const OtpScreen(),
            '/home-screen': (context) => HomeScreen(),
            '/product-screen': (context) => const ProductScreen(),
            '/productDetails-screen': (context) => const ProductDetailsScreen(),
            '/wishlist-screen': (context) => const WishlistScreen(),
            '/cart-screen': (context) => const CartScreen(),
            '/orderhistory-screen': (context) => const OrderHistoryScreen(),
            '/account-screen': (context) => const AccountScreen(),
          },
        ));
  }
}
