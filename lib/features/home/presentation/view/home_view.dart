import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:lazastore/features/home/presentation/widgets/brand_selector.dart';
import 'package:lazastore/features/home/presentation/widgets/new_arrival_section.dart';
import '../widgets/home_header.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/custom_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ValueNotifier<bool> _isDrawerOpenNotifier = ValueNotifier<bool>(false);
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _isDrawerOpenNotifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const CustomDrawer(),
      onDrawerChanged: (isOpen) {
        _isDrawerOpenNotifier.value = isOpen;
      },
      body: SafeArea(
        child: ValueListenableBuilder<bool>(
          valueListenable: _isDrawerOpenNotifier,
          builder: (context, isDrawerOpen, child) {
            return isDrawerOpen ? Blur(blur: 5.0, child: child!) : child!;
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const HomeHeader(),

                const SizedBox(height: 16),

                const SearchBarWidget(),

                const SizedBox(height: 24),

                const BrandSelector(),

                const SizedBox(height: 24),

                NewArrivalSection(scrollController: _scrollController),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Bag',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
