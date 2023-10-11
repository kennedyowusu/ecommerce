import 'package:ecommerce/screens/cart.dart';
import 'package:ecommerce/screens/home.dart';
import 'package:ecommerce/screens/likes.dart';
import 'package:ecommerce/screens/profile.dart';
import 'package:flutter/material.dart';

class ProjectRoot extends StatefulWidget {
  const ProjectRoot({super.key});

  @override
  State<ProjectRoot> createState() => _ProjectRootState();
}

class _ProjectRootState extends State<ProjectRoot> {
  int currentIndex = 0;

  List screens = [
    const HomeScreen(),
    const LikesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        automaticallyImplyLeading: false,
        title: const Text(
          "Ecommerce App",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ));
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.black26,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "",
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(
              Icons.favorite,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(
              Icons.person,
            ),
          ),
        ],
      ),
    );
  }
}
