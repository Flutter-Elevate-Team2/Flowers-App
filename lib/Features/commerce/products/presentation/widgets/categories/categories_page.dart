import 'package:flowers_app/Features/commerce/home/domain/entities/home_entities/category_entity.dart';
import 'package:flowers_app/Features/commerce/products/presentation/view_model/products_events.dart';
import 'package:flowers_app/Features/commerce/products/presentation/view_model/products_view_model.dart';
import 'package:flowers_app/Features/commerce/products/presentation/widgets/categories/category_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesPage extends StatefulWidget {
  final List<CategoryEntity>? categories;
  final int initialIndex;
  const CategoriesPage({super.key, this.categories, this.initialIndex = 0});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= 200) {
      context.read<ProductsViewModel>().doIntent(LoadMoreProductsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    final tabs = ["All", ...?widget.categories?.map((e) => e.name)];

    return SafeArea(
      child: DefaultTabController(
        initialIndex: widget.initialIndex,
        length: tabs.length,
        child: Scaffold(
          body: CategoryBody(
            searchController: searchController,
            tabs: tabs,
            scrollController: _scrollController,
            categories: widget.categories,
          ),
        ),
      ),
    );
  }
}
