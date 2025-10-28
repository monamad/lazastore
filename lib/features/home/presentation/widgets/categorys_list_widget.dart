import 'package:flutter/material.dart';
import 'package:lazastore/core/ui_helper/app_widgets/save_icon_widget.dart';
import 'package:lazastore/features/home/domain/entities/category_entity.dart';

class CategorysListWidget extends StatefulWidget {
  final List<CategoryEntity> limitedCategories;

  const CategorysListWidget({super.key, required this.limitedCategories});

  @override
  State<CategorysListWidget> createState() => _CategorysListWidgetState();
}

class _CategorysListWidgetState extends State<CategorysListWidget> {
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  @override
  void dispose() {
    selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.limitedCategories.asMap().entries.map<Widget>((entry) {
          int index = entry.key;
          final category = entry.value;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                selectedIndex.value = index;
              },
              child: Column(
                children: [
                  ValueListenableBuilder(
                    valueListenable: selectedIndex,
                    builder: (context, value, child) {
                      return Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: selectedIndex.value == index
                                ? Colors.black
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: child!,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: _buildCategoryImage(category.coverPictureUrl),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category.name,
                    style: TextStyle(
                      color: selectedIndex.value == index
                          ? Colors.black
                          : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryImage(String imageUrl) {
    return SafeSvgImage(
      imageUrl: imageUrl,
      width: 20,
      height: 20,
      fallbackUrl:
          'https://www.bmw-ghana.com/content/dam/bmw/common/all-models/5-series/sedan/2016/BMW%20M%20Performance/BMW-5series-sedan-mperformance-ts-XXL-desktop.jpg/jcr:content/renditions/cq5dam.resized.img.1680.large.time1530868840796.jpg',
    );
  }
}
