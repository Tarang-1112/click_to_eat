import 'package:click_to_eat/src/models/category.dart';
import 'package:click_to_eat/src/widgets/custom_text.dart';
import 'package:click_to_eat/src/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../helpers/style.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel category;
  const CategoryWidget({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Stack(
        children: <Widget>[
          Container(
            width: 140,
            height: 160,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Loading(),
                    ),
                  ),
                  Center(
                    child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage, image: category.image),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 140,
            height: 160,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
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
            child: Align(
              alignment: Alignment.center,
              child: CustomText(
                text: category.name,
                colors: white,
                size: 26,
                weight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}









// List<Category> categoriesList = [
//   Category(id: 1, name: "Salad", image: "salad.jpg"),
//   Category(id: 2, name: "Steak", image: "steak.png"),
//   Category(id: 3, name: "Fast Food", image: "sandwitch.png"),
//   Category(id: 4, name: "Dessert", image: "icecream.jpg"),
//   Category(id: 5, name: "Seafood", image: "fish.png"),
//   Category(id: 6, name: "Beer", image: "pint.jpg"),
// ];

// class Categories extends StatelessWidget {
//   const Categories({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       child: ListView.builder(
//         itemCount: categoriesList.length,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (_, index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.red.shade50,
//                         offset: Offset(4, 6),
//                         blurRadius: 20,
//                       ),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(4.0),
//                     child: Image.asset(
//                       "images/${categoriesList[index].image}",
//                       width: 50,
//                       height: 50,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 CustomText(
//                     text: "${categoriesList[index].name}",
//                     size: 14,
//                     colors: black,
//                     weight: FontWeight.normal)
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
