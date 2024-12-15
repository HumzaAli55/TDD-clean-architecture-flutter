import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mock_api_practice/feature/home/presentation/bloc/home_bloc.dart';
import 'package:mock_api_practice/feature/home/presentation/bloc/home_events.dart';
import 'package:mock_api_practice/feature/home/presentation/bloc/home_state.dart';
import 'package:mock_api_practice/feature/home/presentation/widgets/custom_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';



class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  Timer? _timer;
  Duration flashSaleDuration = const Duration(hours: 3);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(LoadProductCategories());
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // Duration for one rotation
      vsync: this, // Ticker for animations
    );
    startTimer();
  }


  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (flashSaleDuration.inSeconds > 0) {
          flashSaleDuration = flashSaleDuration - const Duration(seconds: 1);
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  void _rotateAndOpenDrawer() async {
    // Start the rotation animation
    await _controller.forward(); // Rotate 360 degrees
    _controller.reset(); // Reset for next animation
    // Open the drawer
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer:  CustomDrawer(),
      onDrawerChanged: (isOpen){
        print("Drawer Open Status is : $isOpen");
        if(!isOpen) _controller.forward();
      },
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: RotationTransition(
          turns: _controller,
          child: IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: _rotateAndOpenDrawer
          ),
        ),
        title:  const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delivery address',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
            Text(
              '92 High Street, London',
              style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocConsumer<HomeBloc,HomeState>(
        listener: (context,state) {
          if(state is ProductCategoriesLoaded){
            _controller.forward();
          }
        },
        builder: (context,state) =>
           state is ProductCategoriesLoaded ?
          SingleChildScrollView(
            child: AnimatedOpacity(
              opacity: _controller.value,
              duration: const Duration(seconds: 1),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child:  const Row(
                        children: [
                          Icon(Icons.search, color: Colors.black54),
                          SizedBox(width: 10),
                          Text('Search the entire shop', style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                    ),

                    // Delivery banner
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Colors.green, Colors.blue]),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Delivery is ',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              '50% cheaper',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24),

                    // Categories
                     const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Categories',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text('See all', style: TextStyle(color: Colors.green)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    SizedBox(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: 4,
                          itemBuilder: (context,index)=> Row(
                            children: [
                              CategoryItem(icon: Icons.category, label: state.productCategories.categories.data![index].name),
                              const SizedBox(width: 10,)
                            ],
                          ),
                      ),
                    ),

                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: [
                    //       CategoryItem(icon: Icons.phone_iphone, label: 'Phones'),
                    //       CategoryItem(icon: Icons.videogame_asset, label: 'Consoles'),
                    //       CategoryItem(icon: Icons.laptop_mac, label: 'Laptops'),
                    //       CategoryItem(icon: Icons.camera_alt, label: 'Cameras'),
                    //       // Add more categories if needed
                    //     ],
                    //   ),
                    // ),

                    const SizedBox(height: 24),

                    // Flash Sale
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Flash Sale',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        GestureDetector(
                            onTap: (){

                            },
                            child: const Text('See all', style: TextStyle(color: Colors.green))),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.green[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        formatDuration(flashSaleDuration),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 18,
                      mainAxisSpacing: 18,
                      childAspectRatio: 0.75,
                      physics: const NeverScrollableScrollPhysics(),
                      children: state.productCategories.products.data!.products!.map((e) => ProductItem(
                            imageUrl: e.thumbnail,
                            name: e.title,
                            price: e.price.toString(),
                            oldPrice: e.discountPercentage.toString(),
                          )).toList()
                      // [
                      //   ProductItem(
                      //     imageUrl: 'https://linktoimage.com/iphone.png',
                      //     name: 'Apple iPhone 15 Pro',
                      //     price: '£699.00',
                      //     oldPrice: '£739.00',
                      //   ),
                      //   ProductItem(
                      //     imageUrl: 'https://linktoimage.com/galaxybuds.png',
                      //     name: 'Samsung Galaxy Buds',
                      //     price: '£69.00',
                      //     oldPrice: '£85.00',
                      //   ),
                      //   // Add more products if needed
                      // ],
                    ),
                  ],
                ),
              ),
            ),
          ) : state is ErrorLoadingCategories ? const Center(child: Text("Error Occurred")) : const Center(child: CircularProgressIndicator())
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0, // Home selected
        onTap: (index) {},
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Catalog'),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    constraints: BoxConstraints(minWidth: 16, minHeight: 16),
                    child: const Text(
                      '2',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorites'),
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;

  CategoryItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[200],
          child: Icon(icon, size: 30, color: Colors.black),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}

class ProductItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  final String oldPrice;

  const ProductItem({super.key, required this.imageUrl, required this.name, required this.price, required this.oldPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: FadeInImage.assetNetwork(
                    placeholder: 'assets/spinner.gif', // Path to your placeholder image
                    image: imageUrl,
                    fadeInDuration: const Duration(milliseconds: 500), // Fade-in duration
                    fadeInCurve: Curves.easeIn, // Optional: Curve of fade-in effect
                    imageErrorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error), // Fallback for loading error
                    fit: BoxFit.cover, // Adjust image fit
                    ),
                  ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(price, style: const TextStyle(color: Colors.green)),
                Text(oldPrice, style: const TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}