import 'package:ecommerce/modal/product.dart';
import 'package:ecommerce/providers/favorite.dart';
import 'package:ecommerce/widgets/empty_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class LikesScreen extends StatefulWidget {
  const LikesScreen({super.key});

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  @override
  Widget build(BuildContext context) {
    final FavoriteProvider provider = FavoriteProvider.of(context);
    final List<Product> favoriteList = provider.favoriteList;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            favoriteList.isEmpty
                ? buildNoFavoriteItem(
                    context: context,
                    title: "No Favorite Item",
                    subtitle:
                        "Product added to your favorites will be shown here",
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: favoriteList.length,
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    favoriteList.removeAt(index);
                                    // setState(() {});
                                    provider.updateFavorite();
                                  },
                                  backgroundColor: Colors.red,
                                  icon: Icons.delete,
                                  foregroundColor: Colors.white,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(10),
                              minVerticalPadding: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Colors.grey.shade500,
                                  width: 1,
                                ),
                              ),
                              leading: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(.2),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Image.asset(
                                  favoriteList[index].image,
                                  width: 60,
                                ),
                              ),
                              title: Text(favoriteList[index].name),
                              subtitle: Text(
                                "\$${favoriteList[index].price}",
                                style: const TextStyle(color: Colors.black54),
                              ),
                              trailing: GestureDetector(
                                onTap: () {
                                  provider.toggleFavorite(favoriteList[index]);
                                },
                                child: Icon(
                                  provider.isFavorite(favoriteList[index])
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color:
                                      provider.isFavorite(favoriteList[index])
                                          ? Colors.red
                                          : Colors.black54,
                                ),
                              ),
                              onTap: () {
                                // Add any action you want to perform when the ListTile is tapped
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
