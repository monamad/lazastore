// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:shimmer/shimmer.dart';
// import '../Logic/get_product/home_cubit.dart';
// import 'product_card.dart';
// import 'shimmer_widgets.dart';

// class NewArrivalSection extends StatefulWidget {
//   const NewArrivalSection({super.key});

//   @override
//   State<NewArrivalSection> createState() => _NewArrivalSectionState();
// }

// class _NewArrivalSectionState extends State<NewArrivalSection> {
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _onScroll() {
//     if (_scrollController.position.pixels >=
//         _scrollController.position.maxScrollExtent * 0.8) {
//       context.read<HomeCubit>().loadMoreProducts();
//     }
//   }

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
//                 'New Arrival',
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
//           BlocBuilder<HomeCubit, HomeState>(
//             builder: (context, state) {
//               if (state is HomeLoadingState && state.isLoadingProducts) {
//                 return _buildShimmerLoading();
//               } else if (state is ProductLoaded) {
//                 return _buildProductsGrid(state);
//               } else if (state is ProductsError) {
//                 return _buildErrorWidget(state.message);
//               }
//               return _buildShimmerLoading();
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildShimmerLoading() {
//     return ShimmerWidgets.buildGridShimmer(itemCount: 4);
//   }

//   Widget _buildProductsGrid(ProductLoaded state) {
//     final products = state.products.items;

//     return Column(
//       children: [
//         GridView.builder(
//           controller: _scrollController,
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 16,
//             mainAxisSpacing: 16,
//             childAspectRatio: 0.75,
//           ),
//           itemCount: products.length + (state.isLoadingMore ? 2 : 0),
//           itemBuilder: (context, index) {
//             if (index >= products.length) {
//               // Show loading shimmer for new items being loaded
//               return ShimmerWidgets.buildProductCardShimmer();
//             }

//             final product = products[index];
//             return _buildProductCard(product);
//           },
//         ),
//         if (state.hasMore && !state.isLoadingMore)
//           Padding(
//             padding: const EdgeInsets.only(top: 16),
//             child: ElevatedButton(
//               onPressed: () => context.read<HomeCubit>().loadMoreProducts(),
//               child: const Text('Load More'),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildProductCard(product) {
//     // Generate random colors for product cards
//     final colors = [
//       const Color(0xFFE8F5E8),
//       const Color(0xFFE8F4FF),
//       const Color(0xFFFFF8E1),
//       const Color(0xFFE3F2FD),
//       const Color(0xFFF3E5F5),
//       const Color(0xFFE8F5E8),
//     ];

//     final colorIndex = product.id.hashCode % colors.length;

//     return ProductCard(
//       title: product.name,
//       subtitle: product.description.length > 20
//           ? '${product.description.substring(0, 20)}...'
//           : product.description,
//       price: '\$${product.price.toStringAsFixed(2)}',
//       backgroundColor: colors[colorIndex],
//       imageWidget: SizedBox(
//         width: 80,
//         height: 80,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: CachedNetworkImage(
//             imageUrl: product.coverPictureUrl,
//             fit: BoxFit.cover,
//             placeholder: (context, url) => Shimmer.fromColors(
//               baseColor: Colors.grey[300]!,
//               highlightColor: Colors.grey[100]!,
//               child: Container(color: Colors.grey[300]),
//             ),
//             errorWidget: (context, url, error) => Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: colors[colorIndex],
//               ),
//               child: Icon(
//                 Icons.shopping_bag,
//                 size: 40,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildErrorWidget(String message) {
//     return SizedBox(
//       height: 100,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.error_outline, color: Colors.red, size: 32),
//             const SizedBox(height: 8),
//             Text(
//               'Failed to load products',
//               style: TextStyle(
//                 color: Colors.red,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             Text(
//               message,
//               style: TextStyle(color: Colors.grey, fontSize: 12),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: () => context.read<HomeCubit>().getProducts(),
//               child: const Text('Retry'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
