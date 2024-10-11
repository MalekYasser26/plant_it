import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/blocObserever.dart';
import 'package:plant_it/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:plant_it/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:plant_it/features/checkout/presentation/view_model/checkout_cubit.dart';
import 'package:plant_it/features/description/presentation/view_model/single_product_cubit.dart';
import 'package:plant_it/features/favourites/presentation/view_model/liked_cubit.dart';
import 'package:plant_it/features/favourites/presentation/view_model/liked_plants_cubit.dart';
import 'package:plant_it/features/home/presentation/view_model/home_product_cubit.dart';
import 'package:plant_it/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:plant_it/features/ratings_cubit/ratings_cubit.dart';
import 'package:plant_it/features/splash/presentation/views/splash_view.dart';
import 'package:plant_it/firebase_options.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final authCubit = AuthCubit();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Pass AuthCubit
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()), // Use initialized AuthCubit
        BlocProvider(create: (context) => ProfileCubit(),),
        BlocProvider(create: (context) => HomeProductsCubit(),),
        BlocProvider(create: (context) => SingleProductCubit(),),
        BlocProvider(create: (context) => LikedCubit(),),
        BlocProvider(create: (context) => LikedPlantsCubit(),),
        BlocProvider(create: (context) => CartCubit(),),
        BlocProvider(create: (context) => RatingsCubit(),),
        BlocProvider(create: (context) => CheckoutCubit(),),
      ],
      child: const MaterialApp(
        home: SplashView(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

