// import 'package:e_commerce_app/controllers/product_controller.dart';
// import 'package:e_commerce_app/views/category_screen/item_details.dart';
// import 'package:e_commerce_app/widgets_common/bg_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:e_commerce_app/consts/consts.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';

// class CategoryDetails extends StatelessWidget {
//   final String? title;
//   const CategoryDetails({super.key, this.title});

//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.find<ProductController>();
//     return bgWidget(
//       child: Scaffold(
//         appBar: AppBar(
//           title: title!.text.fontFamily(bold).white.make(),
//         ),
//         body: Container(
//           padding: EdgeInsets.all(12),
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: List.generate(
//                     controller.subcat.length,
//                     (index) => "${controller.subcat[index]}"
//                         .text
//                         .fontFamily(semibold)
//                         .color(darkFontGrey)
//                         .makeCentered()
//                         .box
//                         .white
//                         .rounded
//                         .size(150, 60)
//                         .margin(EdgeInsets.symmetric(horizontal: 4))
//                         .make()),
//               ),
//             ),
//             20.heightBox,
//             Expanded(
//                 child: Container(
//               color: lightGrey,
//               child: GridView.builder(
//                   physics: const BouncingScrollPhysics(),
//                   shrinkWrap: true,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       mainAxisExtent: 250,
//                       mainAxisSpacing: 8,
//                       crossAxisSpacing: 8),
//                   itemBuilder: (context, index) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Image.asset(
//                           imgP5,
//                           height: 150,
//                           width: 200,
//                           fit: BoxFit.cover,
//                         ),
//                         const Spacer(),
//                         "Laptop 4GB/64GB"
//                             .text
//                             .fontFamily(semibold)
//                             .color(darkFontGrey)
//                             .make(),
//                         10.heightBox,
//                         "\$600".text.color(redColor).fontFamily(bold).make(),
//                       ],
//                     )
//                         .box
//                         .white
//                         .outerShadowSm
//                         .margin(const EdgeInsets.symmetric(horizontal: 4))
//                         .roundedSM
//                         .padding(const EdgeInsets.all(12))
//                         .make()
//                         .onTap(() {
//                       Get.to(() => ItemDetails(title: "Dummy title"));
//                     });
//                   }),
//             ))
//           ]),
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/controllers/product_controller.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/views/category_screen/item_details.dart';
import 'package:e_commerce_app/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets_common/loading_indicator.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return bgWidget(
      child: Scaffold(
          appBar: AppBar(
            title: title!.text.fontFamily(bold).white.make(),
          ),
          body: StreamBuilder(
              stream: FirestoreServices.getProducts(title),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: loadingIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: "No products found!".text.make(),
                  );
                } else {
                  var data = snapshot.data!.docs;
                  return Container(
                    padding: EdgeInsets.all(12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                  controller.subcat.length,
                                  (index) => "${controller.subcat[index]}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .makeCentered()
                                      .box
                                      .white
                                      .rounded
                                      .size(150, 60)
                                      .margin(
                                          EdgeInsets.symmetric(horizontal: 4))
                                      .make()),
                            ),
                          ),
                          20.heightBox,
                          Expanded(
                              child: Container(
                            color: lightGrey,
                            child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisExtent: 250,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        data[index]['p_imgs'][0],
                                        height: 150,
                                        width: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      const Spacer(),
                                      "${data[index]['p_name']}"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      10.heightBox,
                                      "${data[index]['p_price']}"
                                          .text
                                          .color(redColor)
                                          .fontFamily(bold)
                                          .make(),
                                    ],
                                  )
                                      .box
                                      .white
                                      .outerShadowSm
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 4))
                                      .roundedSM
                                      .padding(const EdgeInsets.all(12))
                                      .make()
                                      .onTap(() {
                                    controller.checkifFav(data[index]);
                                    Get.to(() => ItemDetails(
                                          title: "${data[index]['p_name']}",
                                          data: data[index],
                                        ));
                                  });
                                }),
                          ))
                        ]),
                  );
                }
              })),
    );
  }
}
