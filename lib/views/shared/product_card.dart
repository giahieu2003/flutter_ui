import 'package:app_shop/controllers/favorites_provider.dart';
import 'package:app_shop/views/shared/appstyle.dart';
import 'package:app_shop/views/ui/favorites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key,
      required this.price,
      required this.category,
      required this.id,
      required this.name,
      required this.image});

  final String price;
  final String category;
  final String id;
  final String name;
  final String image;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  

  @override
  Widget build(BuildContext context) {
    var favoritesNotifier = Provider.of<FavoritesNotifier>(context, listen: true);
    favoritesNotifier.getFavorites();

    bool selected = true;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.678,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.6,
                offset: Offset(1, 1))
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.235,
                    decoration: BoxDecoration(
                        image:
                            DecorationImage(image: NetworkImage(widget.image), )),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Consumer<FavoritesNotifier>(
                      builder: (context, favoritesNotifier, child) {
                        return GestureDetector(
                        onTap: () async {
                          if(favoritesNotifier.ids.contains(widget.id)) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const Favorites()));
                          }else {
                            favoritesNotifier.createFav({
                              "id": widget.id,
                              "name" : widget.name,
                              "category" : widget.category,
                              "price" : widget.price,
                              "imageUrl" : widget.image,
                            });
                          }
                          setState(() {
                          });
                        },
                        child: favoritesNotifier.ids.contains(widget.id) ?  const Icon(AntDesign.heart) : const Icon(AntDesign.hearto),
                      );
                      },
                  )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: appstyleWithHt(
                          25, Colors.black, FontWeight.bold, 1.4),
                    ),
                    Text(
                      widget.category,
                      style:
                          appstyleWithHt(17, Colors.grey, FontWeight.bold, 2),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.price,
                      style: appstyle(27, Colors.black, FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Text(
                          "Colors",
                          style: appstyle(18, Colors.grey, FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        ChoiceChip(
                        showCheckmark: false,
                        padding: const EdgeInsets.all(4),
                        label: const Text(" "),
                        selected: selected,
                        visualDensity: VisualDensity.compact,
                        selectedColor: Colors.black,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
