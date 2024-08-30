import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:plant_it/features/home/presentation/view_model/product_model.dart';
import 'package:plant_it/features/home/presentation/views/widgets/custom_frame.dart';

class CustomGridView extends StatelessWidget {
  final List<Product> products;

  const CustomGridView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: products.length, // Number of products
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        final product = products[index]; // Get each product
        return GridViewItem(
          product: product,
          index: index,
        );
      },
    );
  }
}

class GridViewItem extends StatelessWidget {
  final Product product;
  final int index ;
  const GridViewItem({super.key, required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CustomFrame(
            product: product,
            index: index,
          ),
        ),
      ),
    );
  }
}
