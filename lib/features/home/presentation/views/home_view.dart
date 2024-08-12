import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/home/presentation/views/widgets/cust_grid_view.dart';
import 'package:plant_it/features/home/presentation/views/widgets/search_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.basicallyWhite,
        body: Container(
          decoration: const BoxDecoration(
            color: AppColors.basicallyWhite
          ),
          child:  Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Container(
                    color: AppColors.basicallyWhite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImagesCust.logo,height: getResponsiveSize(context, fontSize: 40)
                          ,width: getResponsiveSize(context, fontSize: 40),),
                        const SizedBox(width: 5,),
                        Text("Plant-it",style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: getResponsiveSize(context, fontSize: 30),
                          fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: SearchWidget(),
                  ),

                  const SizedBox(height: 40),
                  const Expanded(
                    child: CustomGridView(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
