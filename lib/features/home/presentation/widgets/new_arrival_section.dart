import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazastore/features/home/Logic/get_product/get_product_cubit.dart';
import 'package:lazastore/features/home/Logic/get_product/get_product_state.dart';
import 'package:lazastore/features/home/presentation/widgets/products_grid_view.dart';
import 'shimmer_widgets.dart';

class NewArrivalSection extends StatefulWidget {
  const NewArrivalSection({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<NewArrivalSection> createState() => _NewArrivalSectionState();
}

class _NewArrivalSectionState extends State<NewArrivalSection> {
  bool _isLoadingMore = false;

  // Throttle scroll events: store last scroll trigger time
  Timer? _throttle;
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (_throttle?.isActive ?? false) return;
    _throttle = Timer(const Duration(milliseconds: 100), () {});
    if (!mounted) return;
    if (_isLoadingMore) return;

    final scrollPosition = widget.scrollController.position;

    // Guard against content shorter than viewport (maxScrollExtent == 0)
    if (scrollPosition.maxScrollExtent <= 0) return;

    // Throttle: prevent listener from triggering pagination too frequently

    if (scrollPosition.pixels >= scrollPosition.maxScrollExtent * 0.8) {
      _isLoadingMore = true;
      context
          .read<GetProductCubit>()
          .loadMoreProducts()
          .then((_) {
            if (mounted) {
              _isLoadingMore = false;
            }
          })
          .catchError((_) {
            // Ensure flag resets even if future fails
            if (mounted) {
              _isLoadingMore = false;
            }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'New Arrival',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          BlocBuilder<GetProductCubit, GetProductState>(
            builder: (context, state) {
              if (state is ProductLoaded) {
                return ProductsGridView(productState: state);
              } else if (state is ProductLoading) {
                return _buildShimmerLoading();
              } else if (state is ProductsError) {
                return Center(
                  child: Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ShimmerWidgets.buildGridShimmer(itemCount: 4);
  }
}

class NewArrivalSectiontemp extends StatelessWidget {
  const NewArrivalSectiontemp({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'New Arrival',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View All',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
                SizedBox(height: 16),
                
              ],
            ),
          ),
        ),
        // Add SliverGrid or other slivers here for products
      ],
    );
  }
}