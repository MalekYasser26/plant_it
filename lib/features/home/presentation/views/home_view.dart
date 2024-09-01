import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/home/presentation/view_model/products_cubit.dart';
import 'package:plant_it/features/home/presentation/views/widgets/cust_grid_view.dart';
import 'package:plant_it/features/home/presentation/views/widgets/search_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    // Fetch products when the widget initializes
    BlocProvider.of<ProductsCubit>(context).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.basicallyWhite,
        body: Container(
          decoration: const BoxDecoration(
            color: AppColors.basicallyWhite,
          ),
          child: Center(
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
                        Image.asset(
                          ImagesCust.logo,
                          height: getResponsiveSize(context, fontSize: 40),
                          width: getResponsiveSize(context, fontSize: 40),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Plant-it",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: getResponsiveSize(context, fontSize: 30),
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: SearchWidget(),
                  ),
                  const SizedBox(height: 40),
                  // Listen to ProductsCubit state and display products accordingly
                  Expanded(
                    child: BlocBuilder<ProductsCubit, ProductsState>(
                      builder: (context, state) {
                        if (state is ProductsLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.darkGreen,
                            ),
                          );
                        } else if (state is ProductsSuccessfulState) {
                          return CustomGridView(products: state.products); // Show products
                        } else if (state is ProductsFailureState) {
                          return const Center(
                            child: Text('Failed to load products'),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),

                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
