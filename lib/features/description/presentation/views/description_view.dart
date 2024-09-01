import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/checkout/presentation/widgets/cust_app_bar.dart';
import 'package:plant_it/features/description/presentation/views/widgets/description_section.dart';
import 'package:plant_it/features/description/presentation/views/widgets/plant_images_description.dart';
import 'package:plant_it/features/home/presentation/view_model/product_model.dart';
import 'package:plant_it/features/home/presentation/view_model/products_cubit.dart';

class DescriptionView extends StatelessWidget {
  final int productId;

  const DescriptionView({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsCubit()..fetchProductById(productId),
      child: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is SingleProductLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SingleProductSuccessfulState) {
            final Product product = state.product;

            return SafeArea(
              child: Scaffold(
                backgroundColor: AppColors.basicallyWhite,
                appBar: CustAppBar(
                  text: product.productName,
                  implyLeading: true,
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const PlantImagesDescriptionWidget(),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                const Text(
                                  "EGP ",
                                  style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize: 25,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  "${product.price} ",
                                  style: const TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const DescriptionSection(
                              title: "Product Bio",
                              subfields: [
                                {
                                  "header": "Bio: ",
                                  // "description": product.bio.toString(),
                                },
                                {
                                  "header": "Available Stock: ",
                                  // "description": product.availableStock.toString(),
                                },
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text("Failed to load product details"));
          }
        },
      ),
    );
  }
}
