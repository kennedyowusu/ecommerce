import 'package:ecommerce/modal/product.dart';
import 'package:ecommerce/providers/favorite.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final FavoriteProvider provider = FavoriteProvider.of(context);

    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.2),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.category,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    provider.toggleFavorite(widget.product);
                  },
                  child: Icon(
                    provider.isFavorite(widget.product)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: provider.isFavorite(widget.product)
                        ? Colors.red
                        : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 110,
            width: 110,
            child: Image.asset(
              widget.product.image,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.product.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "\$${widget.product.price}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
