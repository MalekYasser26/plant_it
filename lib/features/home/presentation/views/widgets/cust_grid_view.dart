import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:plant_it/features/home/presentation/views/widgets/custom_frame.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 6,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (context, index) =>
             GridViewItem(index: index,)
    );
  }
}

class GridViewItem extends StatelessWidget {
 final int index ;
  const GridViewItem({
    super.key, required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(8.0),
        child:Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CustomFrame(
                  index: index+1,
                )))
    );
  }
}
