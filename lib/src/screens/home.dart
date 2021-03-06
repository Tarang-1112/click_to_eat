import 'package:click_to_eat/src/helpers/screen_navigation.dart';
import 'package:click_to_eat/src/helpers/style.dart';
import 'package:click_to_eat/src/providers/app.dart';
import 'package:click_to_eat/src/providers/category.dart';
import 'package:click_to_eat/src/providers/product.dart';
import 'package:click_to_eat/src/providers/restaurant.dart';
import 'package:click_to_eat/src/providers/user.dart';
import 'package:click_to_eat/src/screens/cart.dart';
import 'package:click_to_eat/src/screens/category.dart';
import 'package:click_to_eat/src/screens/likedProduct.dart';
import 'package:click_to_eat/src/screens/likedRestaurants.dart';
import 'package:click_to_eat/src/screens/login.dart';
import 'package:click_to_eat/src/screens/orders.dart';
import 'package:click_to_eat/src/screens/product_search.dart';
import 'package:click_to_eat/src/screens/restaurant.dart';
import 'package:click_to_eat/src/screens/restaurant_search.dart';
import 'package:click_to_eat/src/widgets/bottom_navigation_icons.dart';
import 'package:click_to_eat/src/widgets/categories.dart';
import 'package:click_to_eat/src/widgets/custom_text.dart';
import 'package:click_to_eat/src/widgets/featured_products.dart';
import 'package:click_to_eat/src/widgets/restaurant.dart';
import 'package:click_to_eat/src/widgets/small_floating_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppProvider>(context);
    final user = Provider.of<UserProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        elevation: 0.1,
        backgroundColor: Colors.deepPurple,
        title: CustomText(
          text: "Click To Eat",
          colors: white,
          size: 16,
          weight: FontWeight.bold,
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    changeScreen(context, CartScreen());
                  },
                  icon: Icon(Icons.shopping_cart)),
              // Positioned(
              //   top: 12,
              //   right: 12,
              //   child: Container(
              //     height: 10,
              //     width: 10,
              //     decoration: BoxDecoration(
              //       color: red,
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //   ),
              // ),
            ],
          ),
          Stack(
            children: <Widget>[
              IconButton(onPressed: null, icon: Icon(Icons.notifications)),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              accountName: CustomText(
                text: "${user.userModel!.name}",
                colors: white,
                size: 20,
                weight: FontWeight.bold,
              ),
              accountEmail: CustomText(
                text: "${user.userModel!.email}",
                colors: white,
                size: 16,
                weight: FontWeight.normal,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.home),
              title: CustomText(
                text: "Home",
                colors: black,
                size: 16,
                weight: FontWeight.normal,
              ),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, LikedProductScreen());
              },
              leading: Icon(Icons.fastfood),
              title: CustomText(
                text: "Food I like",
                colors: black,
                size: 16,
                weight: FontWeight.normal,
              ),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, LikedRestaurantsScreen());
              },
              leading: Icon(Icons.restaurant),
              title: CustomText(
                text: "Liked restaurants",
                colors: black,
                size: 16,
                weight: FontWeight.normal,
              ),
            ),
            ListTile(
              onTap: () async {
                await user.getOrders();
                changeScreen(context, OrdersScreen());
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(
                text: "My orders",
                colors: black,
                size: 16,
                weight: FontWeight.normal,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.settings),
              title: CustomText(
                text: "Settings",
                colors: black,
                size: 16,
                weight: FontWeight.normal,
              ),
            ),
            ListTile(
              onTap: () async {
                await user.signOut();
                changeScreenReplacement(context, LoginScreen());
              },
              leading: Icon(Icons.person),
              title: CustomText(
                text: "Account",
                colors: black,
                size: 16,
                weight: FontWeight.normal,
              ),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, CartScreen());
              },
              leading: Icon(Icons.shopping_cart),
              title: CustomText(
                text: "Cart",
                colors: black,
                size: 16,
                weight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: white,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: white,
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.search,
                      color: purple,
                    ),
                    title: TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (pattern) async {
                        app.changeLoading();
                        if (app.search == SearchBy.PRODUCTS) {
                          await productProvider.searchProduct(
                              productName: pattern);
                          changeScreen(context, ProductSearchScreen());
                        } else {
                          await restaurantProvider.searchRaestro(
                              restaurantName: pattern);
                          changeScreen(context, RestaurantSearchScreen());
                        }
                        app.changeLoading();
                      },
                      decoration: InputDecoration(
                        hintText: "Find Food and Restaurant",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CustomText(
                  text: "Search By : ",
                  size: 16,
                  colors: grey.shade700,
                  weight: FontWeight.bold,
                ),
                DropdownButton<String>(
                  value: app.filterBy,
                  style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.bold,
                  ),
                  icon: Icon(
                    Icons.filter_list,
                    color: black,
                  ),
                  elevation: 0,
                  onChanged: (value) {
                    if (value == "Products") {
                      app.changeSearchBy(newSearchBy: SearchBy.PRODUCTS);
                    } else {
                      app.changeSearchBy(newSearchBy: SearchBy.RESTAURANTS);
                    }
                  },
                  items: <String>["Products", "Restaurants"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 5,
            ),
            //Categories(),
            Container(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryProvider.categories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          await productProvider.loadProductsByCategory(
                              categoryName:
                                  categoryProvider.categories[index].name);
                          changeScreen(
                              context,
                              CategoryScreen(
                                  categoryModel:
                                      categoryProvider.categories[index]));
                        },
                        child: CategoryWidget(
                          category: categoryProvider.categories[index],
                        ),
                      );
                    })),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Featured",
                    size: 20,
                    colors: grey,
                    weight: FontWeight.normal,
                  ),
                  CustomText(
                    text: "See all",
                    size: 20,
                    colors: purple.shade700,
                    weight: FontWeight.normal,
                  ),
                ],
              ),
            ),
            Featured(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Popular Restaurants",
                    size: 20,
                    colors: grey,
                    weight: FontWeight.normal,
                  ),
                  CustomText(
                    text: "See all",
                    size: 20,
                    colors: purple.shade700,
                    weight: FontWeight.normal,
                  ),
                ],
              ),
            ),
            Column(
              children: restaurantProvider.restaurants
                  .map((item) => GestureDetector(
                        onTap: () async {
                          await productProvider.loadProductsByRestaurant(
                              restaurantId: item.id);
                          changeScreen(
                              context,
                              RestaurantScreen(
                                restaurantModel: item,
                              ));
                        },
                        child: RestaurantWidget(
                          restaurant: item,
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 75,
        color: white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            BottomNavIcon(onTap: () {}, image: "home.jpg", name: "Home"),
            BottomNavIcon(onTap: () {}, image: "target.png", name: "Near By"),
            BottomNavIcon(
                onTap: () {
                  changeScreen(context, CartScreen());
                },
                image: "shopping_bag.jpg",
                name: "Bag"),
            BottomNavIcon(onTap: () {}, image: "avatar.png", name: "Account"),
          ],
        ),
      ),
    );
  }
}
