// import 'package:app_shop/models/sneaker_model.dart';
// import 'package:app_shop/views/shared/stagger_tile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// class LatestShoes extends StatelessWidget {
//   const LatestShoes({
//     super.key,
//     required Future<List<Sneakers>> male,
//   }) : _male = male;

//   final Future<List<Sneakers>> _male;

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Sneakers>>(
//         future: _male,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text("Error ${snapshot.error}");
//           } else {
//             final male = snapshot.data;
//             return StaggeredGrid.count(
//               crossAxisCount: 2,
//               crossAxisSpacing: 20,
//               mainAxisSpacing: 10,
//               children: List.generate(male!.length, (index) {
//                 final shoe = snapshot.data![index];
//                 return StaggeredGridTile.fit(
//                   crossAxisCellCount: 1,
//                   child: SizedBox(
//                     child: StaggerTile(
//                       imageUrl: shoe.imageUrl[1],
//                       name: shoe.name,
//                       price: "\$${shoe.price}",
//                     ),
//                   ),
//                 );
//               }),
//             );
//             ;
//           }
//         });
//   }
// }

import 'package:app_shop/controllers/product_provider.dart';
import 'package:app_shop/models/sneaker_model.dart';
import 'package:app_shop/views/shared/stagger_tile.dart';
import 'package:app_shop/views/ui/product_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LatestShoes extends StatelessWidget {
  const LatestShoes({
    super.key,
    required Future<List<Sneakers>> male,
  }) : _male = male;

  final Future<List<Sneakers>> _male;

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    return FutureBuilder<List<Sneakers>>(
      future: _male,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error ${snapshot.error}");
        } else {
          final male = snapshot.data;
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                childAspectRatio: 0.7,
                 // Adjust the aspect ratio as needed
              ),
              itemCount: male!.length,
              itemBuilder: (context, index) {
                final shoe = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    productNotifier.shoesSizes = shoe.sizes;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductPage(
                                id: shoe.id,
                                category: shoe.category)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StaggerTile(
                      imageUrl: shoe.imageUrl[1],
                      name: shoe.name,
                      price: "\$${shoe.price}",
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
