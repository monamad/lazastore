import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazastore/features/home/Logic/get_product/get_product_cubit.dart';
import 'package:lazastore/features/home/Logic/get_product/get_product_state.dart';
import 'package:lazastore/features/home/presentation/widgets/product_card.dart';
import 'package:lazastore/features/home/presentation/widgets/shimmer_widgets.dart';
import 'package:shimmer/shimmer.dart';

class ProductsGridView extends StatelessWidget {
  final ProductLoaded productState;
  const ProductsGridView({super.key, required this.productState});

  @override
  Widget build(BuildContext context) {
    final products = productState.products.items;
    final showPaginationError =
        productState.paginationError != null && !productState.isLoadingMore;

    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.70,
          ),
          itemCount: products.length + (productState.isLoadingMore ? 2 : 0),
          itemBuilder: (context, index) {
            if (index >= products.length) {
              return ShimmerWidgets.buildProductCardShimmer();
            }
            final product = products[index];

            // Use ObjectKey to prevent unnecessary rebuilds of identical items
            return buildProductCard(product);
          },
        ),
        // Show pagination error with retry option
        if (showPaginationError)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: [
                Text(
                  'Failed to load more products',
                  style: TextStyle(color: Colors.red[600], fontSize: 14),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<GetProductCubit>().loadMoreProducts();
                  },
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

Widget buildProductCard(product) {
  return ProductCard(
    title: product.name,
    subtitle: product.description.length > 20
        ? '${product.description.substring(0, 20)}...'
        : product.description,
    price: '\$${product.price.toStringAsFixed(2)}',
    imageWidget: Builder(
      builder: (context) {
        print('widget build for product id: ${product.id}');
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: product.coverPictureUrl,
            fit: BoxFit.contain,
            // Use product ID as cache key for consistent caching
            cacheKey: 'product_${product.id}_cover',
            // Optimize memory: use smaller resolution than original
            maxWidthDiskCache: 500,
            maxHeightDiskCache: 500,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(color: Colors.grey[300]),
            ),
            errorWidget: (context, url, error) => Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Icon(
                Icons.shopping_bag,
                size: 40,
                color: Colors.grey[600],
              ),
            ),
          ),
        );
      },
    ),
  );
}
