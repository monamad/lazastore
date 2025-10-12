// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lazastore/core/ui_helper/app_widgets/save_icon_widget.dart';
// import 'package:lazastore/features/home/presentation/Logic/get_categories/get_categories_cubit.dart';
// import 'package:lazastore/features/home/presentation/Logic/get_categories/get_categories_state.dart';


// class BrandSelector extends StatefulWidget {
//   const BrandSelector({super.key});

//   @override
//   State<BrandSelector> createState() => _BrandSelectorState();
// }

// class _BrandSelectorState extends State<BrandSelector> {
//   int selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Choose Brand',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: const Text(
//                   'View All',
//                   style: TextStyle(color: Colors.grey, fontSize: 14),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
//             builder: (context, state) {
//               print('Current GetCategoriesState: ${state.runtimeType}');
//               if (state is GetCategoriesLoadingState && state.isLoadingCategories) {
//                 return _buildShimmerLoading();
//               } else if (state is CategoriesSuccess) {
//                 print('Categories loaded successfully');
//                 return _buildCategoriesList(state.categories);
//               } else if (state is CategoriesError) {
//                 print('Error loading categories: ${state.message}');
//                 return _buildErrorWidget(state.message);
//               }
//               return SizedBox();
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildShimmerLoading() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: List.generate(6, (index) => ShimmerWidgets.buildBrandShimmer()),
//     );
//   }

//   Widget _buildCategoriesList(List<CategoryEntity> categories) {
//     final limitedCategories = categories.toList();

//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: limitedCategories.asMap().entries.map<Widget>((entry) {
//           int index = entry.key;
//           final category = entry.value;

//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: GestureDetector(
//               onTap: () {},
//               child: Column(
//                 children: [
//                   Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       color: selectedIndex == index
//                           ? Colors.black
//                           : Colors.grey[200],
//                       borderRadius: BorderRadius.circular(30),
//                       border: Border.all(
//                         color: selectedIndex == index
//                             ? Colors.black
//                             : Colors.transparent,
//                         width: 2,
//                       ),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(28),
//                       child: _buildCategoryImage(category.coverPictureUrl),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     category.name,
//                     style: TextStyle(
//                       color: selectedIndex == index
//                           ? Colors.black
//                           : Colors.grey,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _buildCategoryImage(String imageUrl) {
//     return SafeSvgImage(
//       imageUrl: imageUrl,
//       width: 20,
//       height: 20,
//       fallbackUrl:
//           'https://www.bmw-ghana.com/content/dam/bmw/common/all-models/5-series/sedan/2016/BMW%20M%20Performance/BMW-5series-sedan-mperformance-ts-XXL-desktop.jpg/jcr:content/renditions/cq5dam.resized.img.1680.large.time1530868840796.jpg',
//     );
//   }

//   Widget _buildErrorWidget(String message) {
//     return SizedBox(
//       height: 60,
//       child: Center(
//         child: Text(
//           'Failed to load brands: $message',
//           style: TextStyle(color: Colors.red, fontSize: 12),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }
