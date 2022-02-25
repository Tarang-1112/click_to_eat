import 'package:click_to_eat/src/helpers/style.dart';
import 'package:click_to_eat/src/providers/app.dart';
import 'package:click_to_eat/src/providers/category.dart';
import 'package:click_to_eat/src/providers/product.dart';
import 'package:click_to_eat/src/restroAdmin/providers/restroAdmin.dart';
import 'package:click_to_eat/src/widgets/custom_file_upload.dart';
import 'package:click_to_eat/src/widgets/custom_text.dart';
import 'package:click_to_eat/src/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final restroAdminProvider = Provider.of<RestroAdminProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      key: _key,
      backgroundColor: black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: grey),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: black,
        title: Text(
          "Add Product",
          style: TextStyle(color: white),
        ),
      ),
      body: appProvider.isLoading
          ? Loading()
          : ListView(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 130,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: productProvider.productImage == null
                            ? CustomFileUploadButton(
                                icon: Icons.image,
                                text: "Add Image",
                                onTap: () async {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext bc) {
                                      return Container(
                                        child: new Wrap(
                                          children: <Widget>[
                                            new ListTile(
                                              leading: new Icon(Icons.image),
                                              title: new Text('From gallery'),
                                              onTap: () async {
                                                productProvider.getImageFile(
                                                    source:
                                                        ImageSource.gallery);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            new ListTile(
                                              leading:
                                                  new Icon(Icons.camera_alt),
                                              title: new Text('Take a photo'),
                                              onTap: () async {
                                                productProvider.getImageFile(
                                                    source: ImageSource.camera);
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child:
                                    Image.file(productProvider.productImage!),
                              ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: productProvider.productImage != null,
                  child: TextButton(
                    child: CustomText(
                      text: "Change Image",
                      size: 16,
                      colors: black,
                      weight: FontWeight.normal,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext bc) {
                          return Container(
                            child: new Wrap(
                              children: <Widget>[
                                new ListTile(
                                  leading: new Icon(Icons.image),
                                  title: new Text('From gallery'),
                                  onTap: () async {
                                    productProvider.getImageFile(
                                        source: ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
                                ),
                                new ListTile(
                                  leading: new Icon(Icons.camera_alt),
                                  title: new Text('Take a photo'),
                                  onTap: () async {
                                    productProvider.getImageFile(
                                        source: ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Divider(),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CustomText(
                        text: "featured Magazine",
                        colors: white,
                        weight: FontWeight.normal,
                        size: 16,
                      ),
                      Switch(
                        inactiveTrackColor: white,
                        value: productProvider.featured,
                        onChanged: (value) {
                          productProvider.changeFeatured();
                        },
                      ),
                    ],
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CustomText(
                      text: "Category:",
                      colors: grey,
                      weight: FontWeight.w700,
                      size: 18,
                    ),
                    DropdownButton<String>(
                      dropdownColor: black,
                      value: categoryProvider.selectedCategory,
                      style: TextStyle(
                        color: purple.shade400,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                      icon: Icon(
                        Icons.filter_list,
                        color: white,
                      ),
                      elevation: 0,
                      onChanged: (value) {
                        categoryProvider.changeSelectedCategory(
                            newCategory: value!.trim());
                      },
                      items: categoryProvider.categoriesNames
                          .map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        },
                      ).toList(),
                    ),
                  ],
                ),
                Divider(),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                  child: Container(
                    decoration: BoxDecoration(
                        color: white,
                        border: Border.all(color: black, width: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: grey.withOpacity(0.5),
                              offset: Offset(2, 7),
                              blurRadius: 7)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: TextField(
                        controller: productProvider.name,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Product name",
                            hintStyle: TextStyle(
                                color: grey, fontFamily: "Sen", fontSize: 18)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                  child: Container(
                    decoration: BoxDecoration(
                        color: white,
                        border: Border.all(color: black, width: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: grey.withOpacity(0.5),
                              offset: Offset(2, 7),
                              blurRadius: 7)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: TextField(
                        controller: productProvider.description,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Product description",
                            hintStyle: TextStyle(
                                color: grey, fontFamily: "Sen", fontSize: 18)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                  child: Container(
                    decoration: BoxDecoration(
                        color: white,
                        border: Border.all(color: black, width: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: grey.withOpacity(0.5),
                              offset: Offset(2, 7),
                              blurRadius: 7)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: TextField(
                        controller: productProvider.price,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Price",
                            hintStyle: TextStyle(
                                color: grey, fontFamily: "Sen", fontSize: 18)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                  child: Container(
                    decoration: BoxDecoration(
                        color: primary,
                        border: Border.all(color: black, width: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: grey.withOpacity(0.3),
                              offset: Offset(2, 7),
                              blurRadius: 4)
                        ]),
                    child: TextButton(
                      child: CustomText(
                        text: "Post",
                        size: 16,
                        colors: white,
                        weight: FontWeight.normal,
                      ),
                      onPressed: () async {
                        appProvider.changeLoading();
                        if (!await productProvider.uploadProduct(
                            category: categoryProvider.selectedCategory,
                            restaurant:
                                restroAdminProvider.restaurantModel.name,
                            restaurantId:
                                restroAdminProvider.restaurantModel.id)) {
                          _key.currentState!.showSnackBar(SnackBar(
                            content: Text("Upload Failed"),
                            duration: const Duration(seconds: 10),
                          ));
                          appProvider.changeLoading();
                          return;
                        }
                        productProvider.clear();
                        _key.currentState!.showSnackBar(SnackBar(
                          content: Text("Upload completed"),
                          duration: const Duration(seconds: 10),
                        ));
                        productProvider.loadProductsByRestaurant(
                            restaurantId:
                                restroAdminProvider.restaurantModel.id);
                        await restroAdminProvider.reload();
                        appProvider.changeLoading();
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
