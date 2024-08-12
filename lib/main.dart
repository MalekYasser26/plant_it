import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/blocObserever.dart';
import 'package:plant_it/features/auth/presentation/view_model/signin/signin_cubit.dart';
import 'package:plant_it/features/auth/presentation/view_model/signup/signup_cubit.dart';
import 'package:plant_it/features/splash/presentation/views/splash_view.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SigninCubit(),),
        BlocProvider(create: (context) => SignupCubit(),),
      ],
      child: const MaterialApp(
        home: SplashView(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


