import 'package:ecommerce/modal/product.dart';
import 'package:ecommerce/providers/cart.dart';
import 'package:ecommerce/widgets/empty_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = CartProvider.of(context);
    final List<Product> cartList = cartProvider.cartList;

    buildProductQuantity(IconData icon, int index) {
      return InkWell(
        onTap: () {
          if (icon == Icons.add) {
            cartList[index].quantity++;
          } else {
            if (cartList[index].quantity > 1) {
              cartList[index].quantity--;
            }
          }
          cartProvider.updateCart();
        },
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text(
          "Cart Screen",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          cartList.isEmpty
              ? buildNoFavoriteItem(
                  context: context,
                  title: "No Cart Item",
                  subtitle: "Product added to your cart will be shown here",
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: cartList.length,
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
                                  cartList.removeAt(index);
                                  cartProvider.updateCart();
                                },
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                                foregroundColor: Colors.white,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(15),
                            minVerticalPadding: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.grey.shade500,
                                width: 1,
                              ),
                            ),
                            leading: Image.asset(
                              cartList[index].image,
                              fit: BoxFit.contain,
                            ),
                            title: Text(
                              cartList[index].name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$${cartList[index].price}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Row(
                                    children: [
                                      buildProductQuantity(Icons.add, index),
                                      const SizedBox(width: 8),
                                      Text(
                                        "${cartList[index].quantity}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      buildProductQuantity(Icons.remove, index),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            // trailing: Padding(
                            //   padding: const EdgeInsets.only(right: 8.0),
                            //   child: Column(
                            //     children: [
                            //       buildProductQuantity(Icons.add, index),
                            //       Text(
                            //         "${cartList[index].quantity}",
                            //         style: const TextStyle(
                            //           fontSize: 14,
                            //           fontWeight: FontWeight.w400,
                            //         ),
                            //       ),
                            //       buildProductQuantity(Icons.remove, index),
                            //     ],
                            //   ),
                            // ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "\$${cartProvider.calcTotalPrice()}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text("Checkout"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
