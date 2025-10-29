import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazastore/features/home/Logic/get_categories/get_categories_cubit.dart';
import 'package:lazastore/features/home/Logic/get_categories/get_categories_state.dart';
import 'package:lazastore/features/home/presentation/widgets/categorys_list_widget.dart';

class BrandSelector extends StatelessWidget {
  const BrandSelector({super.key});

  @override
  Widget build(BuildContext context) {
    print('Building BrandSelector');
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Choose Brand',
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
          BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
            builder: (context, state) {
              print(state);
              if (state is GetCategoriesLoadingState) {
                return const SizedBox(
                  height: 60,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state is GetCategoriesSuccess) {
                return CategorysListWidget(limitedCategories: state.categories);
              } else if (state is GetCategoriesError) {
                return _buildErrorWidget(state.message);
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return SizedBox(
      height: 60,
      child: Center(
        child: Text(
          'Failed to load brands: $message',
          style: TextStyle(color: Colors.red, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
