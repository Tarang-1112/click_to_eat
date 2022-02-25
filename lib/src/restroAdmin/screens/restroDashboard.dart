import 'package:click_to_eat/src/helpers/screen_navigation.dart';
import 'package:click_to_eat/src/helpers/style.dart';
import 'package:click_to_eat/src/providers/product.dart';
import 'package:click_to_eat/src/providers/user.dart';
import 'package:click_to_eat/src/restroAdmin/providers/restroAdmin.dart';
import 'package:click_to_eat/src/restroAdmin/providers/restroAdmin.dart';
import 'package:click_to_eat/src/restroAdmin/screens/restroAddProduct.dart';
import 'package:click_to_eat/src/restroAdmin/screens/restroOrderScreen.dart';
import 'package:click_to_eat/src/restroAdmin/screens/restroProductDetail.dart';
import 'package:click_to_eat/src/restroAdmin/screens/restroProducts.dart';
import 'package:click_to_eat/src/restroAdmin/widget/restroProduct.dart';
import 'package:click_to_eat/src/screens/login.dart';
import 'package:click_to_eat/src/widgets/custom_text.dart';
import 'package:click_to_eat/src/widgets/product.dart';
import 'package:click_to_eat/src/widgets/small_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final restroAdminProvider = Provider.of<RestroAdminProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    bool hasImage = true;
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        elevation: 0.5,
        backgroundColor: primary,
        title: CustomText(
          text: "Sales: \u{20B9}${restroAdminProvider.totalSales}",
          colors: white,
          size: 16,
          weight: FontWeight.bold,
        ),
        // leading: IconButton(
        //   onPressed: () async {
        //     await restroAdminProvider.signOut();
        //     changeScreenReplacement(context, LoginScreen());
        //   },
        //   icon: Icon(Icons.exit_to_app),
        // ),
        actions: <Widget>[],
      ),
      drawer: Drawer(
        backgroundColor: black,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(
                    text: "${userProvider.userModel!.name}",
                    colors: white,
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                  CustomText(
                    text: "${userProvider.userModel!.email}",
                    colors: white,
                    size: 16,
                    weight: FontWeight.normal,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image:
                      NetworkImage(restroAdminProvider.restaurantModel.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // UserAccountsDrawerHeader(
            //   decoration: BoxDecoration(
            //     color: Colors.deepPurple,
            //   ),
            //   accountName: CustomText(
            //     text: "${userProvider.userModel!.name}",
            //     colors: grey,
            //     size: 20,
            //     weight: FontWeight.bold,
            //   ),
            //   accountEmail: CustomText(
            //     text: "${userProvider.userModel!.email}",
            //     colors: grey,
            //     size: 16,
            //     weight: FontWeight.normal,
            //   ),
            // ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.home,
                color: grey,
              ),
              title: CustomText(
                text: "Home",
                colors: grey,
                size: 16,
                weight: FontWeight.normal,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.restaurant,
                color: grey,
              ),
              title: CustomText(
                text: "Restaurants",
                colors: grey,
                size: 16,
                weight: FontWeight.normal,
              ),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, RestroOrderScreen());
              },
              leading: Icon(
                Icons.bookmark_border,
                color: grey,
              ),
              title: CustomText(
                text: "Orders",
                colors: grey,
                size: 16,
                weight: FontWeight.normal,
              ),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, RestroProductsScreen());
              },
              leading: Icon(
                Icons.fastfood,
                color: grey,
              ),
              title: CustomText(
                text: "Products",
                colors: grey,
                size: 16,
                weight: FontWeight.normal,
              ),
            ),
            ListTile(
              onTap: () {
                restroAdminProvider.signOut();
                changeScreenReplacement(context, LoginScreen());
              },
              leading: Icon(
                Icons.exit_to_app,
                color: grey,
              ),
              title: CustomText(
                text: "Logout",
                colors: grey,
                size: 16,
                weight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(2),
                    bottomRight: Radius.circular(2),
                  ),
                  child: imageWidget(
                    hasImage: hasImage,
                    url: restroAdminProvider.restaurantModel.image,
                  ),
                ),
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(2),
                        bottomRight: Radius.circular(2),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.4),
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.05),
                          Colors.black.withOpacity(0.025),
                        ],
                      )),
                ),
                Positioned.fill(
                  bottom: 30,
                  left: 10,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: CustomText(
                      text: userProvider.userModel!.name,
                      colors: white,
                      size: 24,
                      weight: FontWeight.normal,
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 10,
                  left: 10,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: CustomText(
                      text:
                          "Average Price: \u{20B9} ${restroAdminProvider.avgPrice.toStringAsFixed(2)}",
                      colors: white,
                      size: 16,
                      weight: FontWeight.w300,
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 2,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(
                                Icons.star,
                                color: Colors.yellow[900],
                                size: 20,
                              ),
                            ),
                            Text(
                                "${restroAdminProvider.restaurantModel.rating}"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  top: 5,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: () {},
                        child: SmallButton(Icons.favorite),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: grey.shade300,
                            offset: Offset(-2, -1),
                            blurRadius: 5),
                      ]),
                  child: ListTile(
                    onTap: () {
                      changeScreen(context, RestroOrderScreen());
                    },
                    leading: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Image.asset("images/delivery.png"),
                    ),
                    title: CustomText(
                      text: "Orders",
                      size: 24,
                      weight: FontWeight.normal,
                      colors: black,
                    ),
                    trailing: CustomText(
                      text: restroAdminProvider.orders.length.toString(),
                      size: 24,
                      weight: FontWeight.bold,
                      colors: black,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: grey.shade300,
                            offset: Offset(-2, -1),
                            blurRadius: 5),
                      ]),
                  child: ListTile(
                    onTap: () {
                      changeScreen(context, RestroProductsScreen());
                    },
                    leading: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Image.asset("images/fd.png"),
                    ),
                    title: CustomText(
                      text: "Products",
                      size: 24,
                      weight: FontWeight.normal,
                      colors: black,
                    ),
                    trailing: CustomText(
                      text: restroAdminProvider.products.length.toString(),
                      size: 24,
                      weight: FontWeight.bold,
                      colors: black,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: restroAdminProvider.products
                  .map(
                    (item) => Container(
                      child: InkWell(
                        onTap: () {
                          print("hii");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RestroProductDetails(product: item)));
                        },
                        child: RestroProductWidget(
                          productModel: item,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          changeScreen(context, AddProductScreen());
        },
        child: Icon(Icons.add),
        backgroundColor: primary,
        tooltip: "Add Product",
      ),
    );
  }

  Widget imageWidget({bool? hasImage, required String url}) {
    if (hasImage!)
      return FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: url,
        height: 160,
        fit: BoxFit.fill,
        width: double.infinity,
      );

    // Container(
    //     width: 100.0,
    //     height: 100.0,
    //     decoration: BoxDecoration(
    //       shape: BoxShape.circle,
    //       image: DecorationImage(
    //         fit: BoxFit.cover,
    //         image: NetworkImage(url),
    //       ),
    //     ),
    //   );

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.camera_alt,
                size: 40,
              ),
            ],
          ),
          CustomText(
            text: "No Photo",
            colors: black,
            weight: FontWeight.normal,
            size: 16,
          ),
        ],
      ),
      height: 160,
    );
  }
}
