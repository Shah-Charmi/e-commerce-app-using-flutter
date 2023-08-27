// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_commerce_app/consts/consts.dart';
// import 'package:e_commerce_app/consts/lists.dart';
// import 'package:e_commerce_app/controllers/auth_controller.dart';
// import 'package:e_commerce_app/controllers/profile_controller.dart';
// import 'package:e_commerce_app/services/firestore_services.dart';
// import 'package:e_commerce_app/views/auth_screen/login_screen.dart';
// import 'package:e_commerce_app/views/profile_screen/components/details_card.dart';
// import 'package:e_commerce_app/views/profile_screen/edit_profile_screen.dart';
// import 'package:e_commerce_app/widgets_common/bg_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/get_core.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.put(ProfileController());
//     return bgWidget(
//       child: Scaffold(
//         body:
//             // StreamBuilder(
//             //     stream: FirestoreServices.getUser(currentUser!.uid),
//             //     builder: (BuildContext context,
//             //         AsyncSnapshot<QuerySnapshot> snapshot) {
//             //       if (!snapshot.hasData) {
//             //         return const Center(
//             //           child: CircularProgressIndicator(
//             //             valueColor: AlwaysStoppedAnimation(redColor),
//             //           ),
//             //         );
//             //       } else {

//             //         var data = snapshot.data!.docs[0];

//             SafeArea(
//                 child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: const Align(
//                 alignment: Alignment.topRight,
//                 child: Icon(
//                   Icons.edit,
//                   color: whiteColor,
//                 ),
//               ).onTap(() {
//                 Get.to(() => const EditProfileScreen());
//               }),
//             ),
//             Row(
//               children: [
//                 Image.asset(
//                   imgProfile2,
//                   width: 130,
//                   fit: BoxFit.cover,
//                 ).box.roundedFull.clip(Clip.antiAlias).make(),
//                 10.widthBox,
//                 Expanded(
//                     child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     "Dummy User".text.fontFamily(semibold).white.make(),
//                     "@gmail.com".text.white.make(),
//                   ],
//                 )),
//                 OutlinedButton(
//                     style: OutlinedButton.styleFrom(
//                         side: const BorderSide(
//                       color: whiteColor,
//                     )),
//                     onPressed: () async {
//                       await Get.put(AuthController().signoutMethod(context));
//                       Get.offAll(() => const LoginScreen());
//                     },
//                     child: logout.text.fontFamily(semibold).white.make())
//               ],
//             ),
//             20.heightBox,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 detailsCard(
//                     count: "00",
//                     title: inyourcart,
//                     width: context.screenWidth / 3.2),
//                 detailsCard(
//                     count: "33",
//                     title: yourwishlist,
//                     width: context.screenWidth / 3.2),
//                 detailsCard(
//                     count: "456",
//                     title: yourorders,
//                     width: context.screenWidth / 3.2),
//               ],
//             ),
//             40.heightBox,
//             ListView.separated(
//                     shrinkWrap: true,
//                     separatorBuilder: (context, index) {
//                       return const Divider(
//                         color: lightGrey,
//                       );
//                     },
//                     itemBuilder: (BuildContext context, int index) {
//                       return ListTile(
//                         leading: Image.asset(
//                           profileListIcons[index],
//                           width: 22,
//                         ),
//                         title: profileListItems[index]
//                             .text
//                             .fontFamily(semibold)
//                             .color(darkFontGrey)
//                             .make(),
//                       );
//                     },
//                     itemCount: profileListItems.length)
//                 .box
//                 .white
//                 .shadowSm
//                 .rounded
//                 .margin(const EdgeInsets.all(12))
//                 .padding(const EdgeInsets.symmetric(horizontal: 16))
//                 .make()
//                 .box
//                 .color(redColor)
//                 .make(),
//           ],
//         )),
//       ),
//     );
//   }

// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/consts/consts.dart';
import 'package:e_commerce_app/consts/lists.dart';
import 'package:e_commerce_app/controllers/auth_controller.dart';
import 'package:e_commerce_app/controllers/profile_controller.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:e_commerce_app/views/auth_screen/login_screen.dart';
import 'package:e_commerce_app/views/order_screen/order_screen.dart';
import 'package:e_commerce_app/views/profile_screen/components/details_card.dart';
import 'package:e_commerce_app/views/profile_screen/edit_profile_screen.dart';
import 'package:e_commerce_app/views/wishlist_screen/wishlist_screen.dart';
import 'package:e_commerce_app/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
                stream: FirestoreServices.getUser(currentUser!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      ),
                    );
                  } else {
                    var data = snapshot.data!.docs.isNotEmpty
                        ? snapshot.data!.docs[0]
                        : null;

                    return SafeArea(
                        child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: const Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.edit,
                              color: whiteColor,
                            ),
                          ).onTap(() {
                            controller.nameController.text = data?['name'];
                            // controller.passController.text = data?['password'];
                            Get.to(() => EditProfileScreen(
                                  data: data,
                                ));
                          }),
                        ),
                        Row(
                          children: [
                            data?['imageUrl'] == ''
                                ? Image.asset(
                                    imgProfile2,
                                    width: 130,
                                    fit: BoxFit.cover,
                                  ).box.roundedFull.clip(Clip.antiAlias).make()
                                : Image.network(data?['imageUrl'],
                                        width: 100, fit: BoxFit.cover)
                                    .box
                                    .roundedFull
                                    .clip(Clip.antiAlias)
                                    .make(),
                            10.widthBox,
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data?['name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .white
                                    .make(),
                                "${data?['email']}".text.white.make(),
                              ],
                            )),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                  color: whiteColor,
                                )),
                                onPressed: () async {
                                  await Get.put(
                                      AuthController().signoutMethod(context));
                                  Get.offAll(() => const LoginScreen());
                                },
                                child: logout.text
                                    .fontFamily(semibold)
                                    .white
                                    .make())
                          ],
                        ),
                        20.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detailsCard(
                                count: data?['cart_count'],
                                title: inyourcart,
                                width: context.screenWidth / 3.2),
                            detailsCard(
                                count: data?['wishlist_count'],
                                title: yourwishlist,
                                width: context.screenWidth / 3.2),
                            detailsCard(
                                count: data?['order_count'],
                                title: yourorders,
                                width: context.screenWidth / 3.2),
                          ],
                        ),
                        40.heightBox,
                        ListView.separated(
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    color: lightGrey,
                                  );
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    onTap: () {
                                      switch (index) {
                                        case 0:
                                          Get.to(() => const WishlistScreen());
                                          break;
                                        case 1:
                                          Get.to(() => const OrdersScreen());

                                          break;
                                      }
                                    },
                                    leading: Image.asset(
                                      profileListIcons[index],
                                      width: 22,
                                    ),
                                    title: profileListItems[index]
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                  );
                                },
                                itemCount: profileListItems.length)
                            .box
                            .white
                            .shadowSm
                            .rounded
                            .margin(const EdgeInsets.all(12))
                            .padding(const EdgeInsets.symmetric(horizontal: 16))
                            .make()
                            .box
                            .color(redColor)
                            .make(),
                      ],
                    ));
                  }
                  
                })));
  }
}
