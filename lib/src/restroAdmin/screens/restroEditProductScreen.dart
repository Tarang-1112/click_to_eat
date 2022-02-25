import 'package:click_to_eat/src/helpers/style.dart';
import 'package:click_to_eat/src/models/products.dart';
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

class EditProductScreen extends StatefulWidget {
  final ProductModel productModel;
  EditProductScreen({Key? key, required this.productModel}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
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
          "Edit Product",
          style: TextStyle(color: white),
        ),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.save,
            ),
          ),
        ],
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
                                text: "Change Image",
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
                            labelText: "Name",
                            //hintText: widget.productModel.name,
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
                            labelText: "Description",
                            //hintText: widget.productModel.description,
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
                            labelText: "Price",
                            //hintText: widget.productModel.price.toString(),
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
                        text: "Save",
                        size: 16,
                        colors: white,
                        weight: FontWeight.normal,
                      ),
                      onPressed: () async {},
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
