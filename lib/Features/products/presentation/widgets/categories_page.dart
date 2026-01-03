import 'package:flowers_app/Features/products/presentation/view_model/products_events.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_view_model.dart';
import 'package:flowers_app/Features/products/presentation/widgets/category_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

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
    final tabs = ["All", "Plants", "Flowers", "Pots", "Seeds"];

    return SafeArea(
      child: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          body: CategoryBody(
            searchController: searchController,
            tabs: tabs,
            scrollController: _scrollController,
          ),
        ),
      ),
    );
  }
}
