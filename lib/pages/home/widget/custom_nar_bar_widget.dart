// import 'package:tinbanxe/pages/home/controller/home_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
//
//
// class CustomNavBarWidget extends StatelessWidget {
//   final int selectedIndex;
//   final List<PersistentBottomNavBarItem> items;
//   final ValueChanged<int> onItemSelected;
//
//   CustomNavBarWidget({
//     Key key,
//     this.selectedIndex,
//     @required this.items,
//     this.onItemSelected,
//   });
//
//   Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected) {
//     return Container(
//       alignment: Alignment.center,
//       height: kBottomNavigationBarHeight,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Flexible(
//             child: IconTheme(
//               data: IconThemeData(
//                   size: 26.0,
//                   color:  Colors.red),
//                   // isSelected
//                   //     ? (item.activeColorAlternate == null
//                   //         ? item.activeColor
//                   //         : item.activeColorAlternate)
//                   //     : item.inactiveColor == null
//                   //         ? item.activeColor
//                   //         : item.inactiveColor),
//               child: item.icon,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 5.0),
//             child: Material(
//               type: MaterialType.transparency,
//               child: FittedBox(
//                   child: Text(
//                 item.title,
//                 style: TextStyle(
//                     // color: isSelected
//                     //     ? (item.activeColorAlternate == null
//                     //         ? item.activeColor
//                     //         : item.activeColorAlternate)
//                     //     : item.inactiveColor,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 12.0),
//               )),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeController>(
//         init: HomeController(),
//         builder: (controller) {
//           return Container(
//             color: Colors.white,
//             child: Container(
//               width: double.infinity,
//               height: kBottomNavigationBarHeight,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: items.map((item) {
//                   int index = items.indexOf(item);
//                   return Flexible(
//                     child: GestureDetector(
//                       onTap: () {
//                         this.onItemSelected(index);
//                       },
//                       child: _buildItem(item, selectedIndex == index),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           );
//         });
//   }
// }
